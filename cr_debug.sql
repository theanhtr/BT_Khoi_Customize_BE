-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2023 at 12:17 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cr_debug`
--
CREATE DATABASE IF NOT EXISTS `cr_debug` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cr_debug`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `attach` (IN `in_debug_id` INTEGER)  SQL SECURITY INVOKER BEGIN
  SET @debug_id = in_debug_id, @timeout = 5;
  DO GET_LOCK(CAST(@debug_id AS char), 5);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `continue` (IN `in_step_kind` INTEGER)  SQL SECURITY INVOKER BEGIN
  DECLARE stack_depth INTEGER;

  SELECT
    MAX(c.stack_depth)
  FROM callstack c
  WHERE c.debug_id = @debug_id
  INTO stack_depth;

  UPDATE debuggings
    SET step_kind = in_step_kind
    WHERE id = @debug_id;

  IF (in_step_kind = 3) THEN
    UPDATE debuggings
      SET estimated_depth = stack_depth - 1
      WHERE id = @debug_id;
  ELSEIF (in_step_kind = 2) THEN
    UPDATE debuggings
      SET estimated_depth = stack_depth
      WHERE id = @debug_id;
  ELSE
    UPDATE debuggings
      SET estimated_depth = -1
      WHERE id = @debug_id;
  END IF;

  CALL switch_locks(0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `debug_off` ()  SQL SECURITY INVOKER BEGIN
  DELETE
    FROM callstack
    WHERE debug_id = @debug_id;
  DELETE
    FROM breakpoints
    WHERE debug_id = @debug_id;
  DELETE
    FROM watches
    WHERE debug_id = @debug_id;
  DELETE
    FROM debuggings
    WHERE id = @debug_id;
  DELETE
    FROM info
    WHERE debug_id = @debug_id;
  DO RELEASE_LOCK(@debug_id);
  DO RELEASE_LOCK(CONCAT(@debug_id, 'second'));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `debug_on` (OUT `out_debug_id` INTEGER)  SQL SECURITY INVOKER BEGIN
  SET @supress_system_calls := 0;
  CALL update_system_calls(-1);

  DELETE d.*, c.*, i.*, w.*, b.*
    FROM debuggings d
      LEFT JOIN callstack c
        ON c.debug_id = d.id
      LEFT JOIN breakpoints b
        ON b.debug_id = d.id
      LEFT JOIN info i
        ON i.debug_id = d.id
      LEFT JOIN watches w
        ON w.debug_id = d.id
    WHERE proc_id = CONNECTION_ID();

  INSERT INTO debuggings (proc_id, step_kind)
    VALUES (CONNECTION_ID(), 1);
  SELECT
    LAST_INSERT_ID()
  INTO @debug_id;

  SET @stack_depth := 0;

  INSERT INTO info (debug_id, break_reason, stack_depth)
    VALUES (@debug_id, -1, @stack_depth);

  SET out_debug_id := @debug_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `detach` ()  SQL SECURITY INVOKER BEGIN
  DO RELEASE_LOCK(@debug_id);
  DO RELEASE_LOCK(CONCAT(@debug_id, 'second'));
  SET @debug_id = -1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `exit_handler` (IN `in_stack_depth` INTEGER)  SQL SECURITY INVOKER BEGIN
  CALL cr_debug.leave_module(in_stack_depth);
  IF (get_update_code() > 0) THEN
    SET @supress_system_calls := 1;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `leave_module` (IN `in_stack_depth` INTEGER)  SQL SECURITY INVOKER BEGIN
  IF (@debug_id > 0) THEN
    DELETE
      FROM callstack
      WHERE debug_id = @debug_id
        AND stack_depth > in_stack_depth;

    SET @stack_depth = in_stack_depth;
    UPDATE info
      SET stack_depth = in_stack_depth
      WHERE debug_id = @debug_id;

    IF (@stack_depth <= 0) THEN
      UPDATE info
        SET break_reason = 25
        WHERE debug_id = @debug_id;
    END IF;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_breakpoint` (`breakpoint_no` INTEGER)  SQL SECURITY INVOKER BEGIN
  DELETE
    FROM breakpoints
    WHERE id = breakpoint_no;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `set_breakpoint` (IN `in_module_name` VARCHAR(300), IN `in_module_owner` VARCHAR(300), IN `in_module_type` INTEGER, IN `in_line` INTEGER, IN `in_pos` INTEGER, OUT `out_br_no` INTEGER)  SQL SECURITY INVOKER BEGIN
  DECLARE module_exists INTEGER DEFAULT -1;

  IF (in_module_type = 7 OR in_module_type = 8) THEN
    SELECT
      COUNT(routine_name)
    INTO module_exists
    FROM information_schema.routines
    WHERE routine_name = in_module_name
      AND routine_schema = in_module_owner;
  ELSEIF (in_module_type = 12) THEN
    SELECT
      COUNT(trigger_name)
    INTO module_exists
    FROM information_schema.triggers
    WHERE trigger_name = in_module_name
      AND trigger_schema = in_module_owner;
  END IF;

  SET out_br_no := -1;
  IF (module_exists <> 0) THEN
    DELETE
      FROM breakpoints
      WHERE module_name = in_module_name
        AND module_owner = in_module_owner
        AND module_type = in_module_type
        AND line = in_line
        AND pos = in_pos
        AND debug_id = @debug_id;
    INSERT INTO breakpoints (module_name, module_owner, module_type, line, pos, debug_id)
      VALUES (in_module_name, in_module_owner, in_module_type, in_line, in_pos, @debug_id);
    SELECT
      LAST_INSERT_ID()
    INTO out_br_no;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `switch_locks` (IN `is_target` TINYINT)   BEGIN
  DECLARE lock1 VARCHAR(200) DEFAULT @debug_id;
  DECLARE lock2 VARCHAR(200) DEFAULT CONCAT(@debug_id, 'second');
  DECLARE timeout INT;
  DECLARE to_lock,
          to_release VARCHAR(200);

  IF (is_target > 0) THEN
    SET timeout = 3600;
  ELSE
    SET timeout = 10;
  END IF;

  IF (IS_USED_LOCK(lock1) = CONNECTION_ID()) THEN
    SET to_lock = lock2;
    SET to_release = lock1;
  ELSE
    SET to_lock = lock1;
    SET to_release = lock2;
  END IF;

  IF (is_target > 0) THEN
    DO RELEASE_LOCK(to_release);
  END IF;

  DO GET_LOCK(to_lock, timeout);

  IF (is_target = 0) THEN
    DO RELEASE_LOCK(to_release);
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `synchronize` (OUT `out_unit_name` VARCHAR(300), OUT `out_module_name` VARCHAR(300), OUT `out_module_owner` VARCHAR(300), OUT `out_module_type` INTEGER, OUT `out_stack_depth` INTEGER, OUT `out_start_line` INTEGER, OUT `out_end_line` INTEGER, OUT `out_start_pos` INTEGER, OUT `out_end_pos` INTEGER, OUT `out_break_reason` INTEGER)  SQL SECURITY INVOKER BEGIN
  DECLARE second_lock VARCHAR(200);
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET out_break_reason = 0;

  IF (IS_USED_LOCK(CAST(@debug_id AS CHAR)) = CONNECTION_ID()) THEN
    SET second_lock = CONCAT(@debug_id, 'second');
  ELSE
    SET second_lock = @debug_id;
  END IF;

  IF (IS_FREE_LOCK(second_lock) > 0) THEN
    SELECT
      unit_name,
      module_name,
      module_owner,
      module_type,
      c.stack_depth,
      start_line,
      end_line,
      start_pos,
      end_pos,
      break_reason
    FROM callstack c,
         debuggings d,
         info i
    WHERE c.debug_id = @debug_id
      AND d.id = @debug_id
      AND i.debug_id = @debug_id
      AND c.stack_depth = i.stack_depth
    INTO out_unit_name, out_module_name, out_module_owner, out_module_type, out_stack_depth, out_start_line, out_end_line, out_start_pos,
    out_end_pos, out_break_reason;
  ELSE
    SELECT
      break_reason
    FROM info
    WHERE debug_id = @debug_id
    INTO out_break_reason;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `trace` (IN `in_start_line` INTEGER, IN `in_end_line` INTEGER, IN `in_start_pos` INTEGER, IN `in_end_pos` INTEGER, IN `in_update_code` INTEGER, IN `in_stack_depth` INTEGER)  SQL SECURITY INVOKER Trace:
BEGIN
  DECLARE step_kind,
          estimated_depth INTEGER DEFAULT -1;
  DECLARE cnt INT DEFAULT 0;

  IF (in_update_code > 0) THEN
    SET @supress_system_calls := 0;
  END IF;

  IF (@debug_id > 0) THEN
    IF (in_stack_depth < @stack_depth) THEN
      CALL leave_module(in_stack_depth);
    END IF;

    UPDATE callstack
      SET start_line = in_start_line,
          end_line = in_end_line,
          start_pos = in_start_pos,
          end_pos = in_end_pos,
          update_code = in_update_code
      WHERE debug_id = @debug_id
        AND stack_depth = @stack_depth;

    SET step_kind := get_step_kind();

    IF (step_kind = 1100) THEN
      UPDATE info
        SET break_reason = 25
        WHERE debug_id = @debug_id;
      UPDATE debuggings
        SET cr_debug_terminated = 1
        WHERE id = @debug_id;
    END IF;

    IF (check_version_compatibility(@stack_depth) != 0) THEN
      LEAVE Trace;
    END IF;

    IF (step_kind = 2 OR step_kind = 3) THEN
      SELECT
        d.estimated_depth
      FROM debuggings d
      WHERE id = @debug_id
      INTO estimated_depth;

      IF (@stack_depth > estimated_depth AND check_breakpoint() = 0) THEN
        LEAVE Trace;
      END IF;

    ELSEIF (step_kind = 4 AND check_breakpoint() = 0) THEN
      LEAVE Trace;
    END IF;

    IF check_breakpoint() != 0 THEN
      UPDATE info
        SET break_reason = 22
        WHERE debug_id = @debug_id;
    ELSEIF step_kind IN (1, 2, 3) THEN
      UPDATE info
        SET break_reason = 21
        WHERE debug_id = @debug_id;
    ELSEIF step_kind = 4 THEN
      UPDATE info
        SET break_reason = 25
        WHERE debug_id = @debug_id;
    END IF;

    CALL switch_locks(1);
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_system_calls` (IN `in_query_type` INTEGER)   this: BEGIN
  IF (@supress_system_calls = 1) THEN
    LEAVE this;
  ELSEIF (in_query_type = 101) THEN
    SET @debug_found_rows := FOUND_ROWS();
  ELSEIF (in_query_type = 102) THEN
    SET @debug_row_count := ROW_COUNT();
    SET @debug_last_insert_id := LAST_INSERT_ID();
  ELSEIF (in_query_type = 103 OR in_query_type = 104) THEN
    SET @debug_row_count := ROW_COUNT();
  ELSE
    SET @debug_row_count := ROW_COUNT();
    SET @debug_found_rows := FOUND_ROWS();
    SET @debug_last_insert_id := LAST_INSERT_ID();
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_watch2` (IN `in_watch_name` VARCHAR(200), IN `in_watch_value` VARCHAR(65535), IN `in_stack_depth` INTEGER)  SQL SECURITY INVOKER BEGIN
  CALL update_watch3(in_watch_name, in_watch_value, '', in_stack_depth);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_watch3` (IN `in_watch_name` VARCHAR(200), IN `bin_watch_value` VARBINARY(65535), IN `in_watch_type` VARCHAR(200), IN `in_stack_depth` INTEGER)  SQL SECURITY INVOKER BEGIN
  DECLARE in_watch_value TEXT;
  DECLARE watch_id INT DEFAULT -1;

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET in_watch_value = CONCAT('0x', HEX(bin_watch_value));

  SET in_watch_value = CAST(bin_watch_value AS CHAR);

  IF (@debug_id > 0) THEN

    SELECT
      id
    INTO watch_id
    FROM watches
    WHERE watch_name = in_watch_name
      AND stack_depth = in_stack_depth
      AND debug_id = @debug_id;

    IF (watch_id < 0) THEN
      INSERT INTO watches (watch_name, watch_value, watch_type, stack_depth, debug_id)
        VALUES (in_watch_name, in_watch_value, in_watch_type, in_stack_depth, @debug_id);
    ELSE
      UPDATE watches
        SET watch_name = in_watch_name,
            watch_value = in_watch_value,
            debug_id = @debug_id
        WHERE id = watch_id;
    END IF;
  END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `check_breakpoint` () RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  DECLARE result INTEGER DEFAULT 0;

  IF (@debug_id > 0) THEN
    SELECT
      COUNT(*)
    FROM callstack c,
         breakpoints b
    WHERE c.debug_id = @debug_id
      AND b.debug_id = @debug_id
      AND c.stack_depth = @stack_depth
      AND c.module_name = b.module_name
      AND c.module_owner = b.module_owner
      AND c.module_type = b.module_type
      AND c.start_line = b.line
    INTO result;
  END IF;
  RETURN result;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `check_version_compatibility` (`in_stack_depth` INTEGER) RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  DECLARE c_version INTEGER DEFAULT NULL;
  SELECT
    compiler_version
  FROM callstack
  WHERE debug_id = @debug_id
    AND stack_depth = in_stack_depth
  INTO c_version;
  RETURN COALESCE(c_version, 0) - get_version();
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `enter_handler` (`in_unit_name` VARCHAR(300), `in_module_name` VARCHAR(300), `in_module_owner` VARCHAR(300), `in_module_type` INTEGER, `in_compiler_version` INTEGER) RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  DECLARE update_code INT DEFAULT get_update_code();
  IF (update_code > 0) THEN
    CALL cr_debug.update_system_calls(update_code);
    SET @supress_system_calls := 1;
  END IF;
  RETURN cr_debug.enter_module3(in_unit_name, in_module_name, in_module_owner, in_module_type, in_compiler_version);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `enter_module` (`in_module_name` VARCHAR(300), `in_module_owner` VARCHAR(300), `in_module_type` INTEGER) RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  RETURN cr_debug.enter_module2(in_module_name, in_module_owner, in_module_type, NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `enter_module2` (`in_module_name` VARCHAR(300), `in_module_owner` VARCHAR(300), `in_module_type` INTEGER, `in_compiler_version` INTEGER) RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  RETURN cr_debug.enter_module3(NULL, in_module_name, in_module_owner, in_module_type, in_compiler_version);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `enter_module3` (`in_unit_name` VARCHAR(300), `in_module_name` VARCHAR(300), `in_module_owner` VARCHAR(300), `in_module_type` INTEGER, `in_compiler_version` INTEGER) RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  IF (@debug_id > 0) THEN
    SET @stack_depth := @stack_depth + 1;
    UPDATE info
      SET stack_depth = @stack_depth
      WHERE debug_id = @debug_id;
    INSERT INTO cr_debug.callstack (debug_id, unit_name, module_name, module_owner, module_type, stack_depth, compiler_version)
      VALUES (@debug_id, in_unit_name, in_module_name, in_module_owner, in_module_type, @stack_depth, in_compiler_version);
  END IF;

  RETURN @stack_depth;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_found_rows` () RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  RETURN @debug_found_rows;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_last_insert_id` () RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  RETURN @debug_last_insert_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_row_count` () RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  RETURN @debug_row_count;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_step_kind` () RETURNS INT(11) READS SQL DATA BEGIN
  DECLARE result INTEGER DEFAULT -1;

  SELECT
    step_kind
  FROM debuggings
  WHERE id = @debug_id
  INTO result;
  RETURN result;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_update_code` () RETURNS INT(11) READS SQL DATA SQL SECURITY INVOKER BEGIN
  DECLARE c_update_code INTEGER DEFAULT 0;
  SELECT
    update_code
  FROM callstack
  WHERE debug_id = @debug_id AND stack_depth = @stack_depth
  INTO c_update_code;
  RETURN c_update_code;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_version` () RETURNS INT(11) DETERMINISTIC READS SQL DATA SQL SECURITY INVOKER BEGIN
  RETURN 100637;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `breakpoints`
--

CREATE TABLE `breakpoints` (
  `id` int(11) NOT NULL,
  `debug_id` int(11) DEFAULT NULL,
  `module_name` varchar(300) NOT NULL,
  `module_owner` varchar(300) NOT NULL,
  `module_type` int(11) NOT NULL,
  `line` int(11) DEFAULT NULL,
  `pos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `callstack`
--

CREATE TABLE `callstack` (
  `id` int(11) NOT NULL,
  `debug_id` int(11) NOT NULL,
  `unit_name` varchar(300) DEFAULT NULL,
  `module_name` varchar(300) NOT NULL,
  `module_owner` varchar(300) NOT NULL,
  `module_type` int(11) NOT NULL,
  `start_line` int(11) DEFAULT NULL,
  `end_line` int(11) DEFAULT NULL,
  `start_pos` int(11) DEFAULT NULL,
  `end_pos` int(11) DEFAULT NULL,
  `update_code` int(11) DEFAULT 0,
  `stack_depth` int(11) NOT NULL,
  `compiler_version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `debuggings`
--

CREATE TABLE `debuggings` (
  `id` int(11) NOT NULL,
  `proc_id` int(11) NOT NULL,
  `step_kind` int(11) DEFAULT NULL,
  `estimated_depth` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `info`
--

CREATE TABLE `info` (
  `id` int(11) NOT NULL,
  `debug_id` int(11) NOT NULL,
  `break_reason` int(11) DEFAULT NULL,
  `stack_depth` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `watches`
--

CREATE TABLE `watches` (
  `id` int(11) NOT NULL,
  `debug_id` int(11) NOT NULL,
  `stack_depth` int(11) NOT NULL,
  `watch_name` varchar(200) NOT NULL,
  `watch_value` mediumtext DEFAULT NULL,
  `watch_type` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `breakpoints`
--
ALTER TABLE `breakpoints`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `callstack`
--
ALTER TABLE `callstack`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `debuggings`
--
ALTER TABLE `debuggings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `info`
--
ALTER TABLE `info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `watches`
--
ALTER TABLE `watches`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `breakpoints`
--
ALTER TABLE `breakpoints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `callstack`
--
ALTER TABLE `callstack`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `debuggings`
--
ALTER TABLE `debuggings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `info`
--
ALTER TABLE `info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `watches`
--
ALTER TABLE `watches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
