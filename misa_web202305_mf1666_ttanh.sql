-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2023 at 12:16 PM
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
-- Database: `misa.web202305_mf1666_ttanh`
--
CREATE DATABASE IF NOT EXISTS `misa.web202305_mf1666_ttanh` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `misa.web202305_mf1666_ttanh`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_Count` (IN `tableName` VARCHAR(255))  SQL SECURITY INVOKER COMMENT 'Procedure để đếm số bản ghi trong 1 bảng.' BEGIN
    SET @query = CONCAT('SELECT COUNT(1) FROM ', tableName);
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_Delete` (IN `tableName` VARCHAR(255), IN `tableId` VARCHAR(255), IN `id` CHAR(36))  SQL SECURITY INVOKER COMMENT 'Procedure xóa 1 bản ghi.' BEGIN
    SET @query = CONCAT('DELETE FROM ', tableName, ' WHERE ', tableId, ' = \'', id, '\'');
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_DeleteList` (IN `tableName` VARCHAR(255), IN `tableId` VARCHAR(255), IN `ids` TEXT)  SQL SECURITY INVOKER COMMENT 'Procedure xóa nhiều bản ghi theo id.' BEGIN
    SET @query = CONCAT('DELETE FROM ', tableName, ' WHERE ', tableId, ' IN (', ids, ')');
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_GetAll` (IN `tableName` VARCHAR(255))  SQL SECURITY INVOKER COMMENT 'Procedure lấy tất cả bản ghi trong 1 bảng.' BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName);
    PREPARE stmt FROM @query;
    EXECUTE stmt;

  /* giải phóng tài nguyên */
  DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_GetAllByColumnName` (IN `tableName` VARCHAR(255), IN `columnName` VARCHAR(255))  SQL SECURITY INVOKER COMMENT 'Procedure lấy tất cả bản ghi của một bảng nhưng chỉ lấy một cột.' BEGIN
    SET @query = CONCAT('SELECT ', columnName, ' FROM ', tableName);
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_GetByCode` (IN `tableName` VARCHAR(255), IN `tableCode` VARCHAR(255), IN `code` VARCHAR(20))  SQL SECURITY INVOKER COMMENT 'Procedure lấy bản ghi theo mã code.' BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName, ' entity WHERE entity.', tableCode, ' = \'', code, '\'');
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_GetById` (IN `tableName` VARCHAR(255), IN `tableId` VARCHAR(255), IN `id` CHAR(36))  SQL SECURITY INVOKER COMMENT 'Procedure lấy một bản ghi theo id.' BEGIN
DECLARE cr_stack_depth_handler INTEGER/*[cr_debug.1]*/;
DECLARE cr_stack_depth INTEGER DEFAULT cr_debug.ENTER_MODULE2('Proc_AllTable_GetById', 'misa.web202305_mf1666_ttanh', 7, 100637)/*[cr_debug.1]*/;
    CALL cr_debug.UPDATE_WATCH3('tableName', tableName, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('tableId', tableId, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('id', id, 'CHAR(36)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.TRACE(3, 3, 0, 5, 0, cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.TRACE(4, 4, 4, 106, 0, cr_stack_depth)/*[cr_debug.2]*/;
SET @query = CONCAT('SELECT * FROM ', tableName, ' entity WHERE entity.', tableId, ' = \'', id, '\'');
CALL cr_debug.UPDATE_WATCH3('@query', @query, '', cr_stack_depth)/*[cr_debug.1]*/;
    CALL cr_debug.TRACE(5, 5, 4, 29, 0, cr_stack_depth)/*[cr_debug.2]*/;
PREPARE stmt FROM @query;
    CALL cr_debug.TRACE(6, 6, 4, 17, 100, cr_stack_depth)/*[cr_debug.2]*/;
EXECUTE stmt;
CALL cr_debug.UPDATE_SYSTEM_CALLS(100)/*[cr_debug.1]*/;

    /* giải phóng tài nguyên */
    CALL cr_debug.TRACE(9, 9, 4, 28, 0, cr_stack_depth)/*[cr_debug.2]*/;
DEALLOCATE PREPARE stmt;
CALL cr_debug.TRACE(10, 10, 0, 3, 0, cr_stack_depth)/*[cr_debug.2]*/;
SET cr_stack_depth = cr_stack_depth - 1/*[cr_debug.2]*/;
CALL cr_debug.LEAVE_MODULE(cr_stack_depth)/*[cr_debug.2]*/;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_AllTable_GetListByColumnValues` (IN `tableName` VARCHAR(255), IN `columnName` VARCHAR(255), IN `values` TEXT)  SQL SECURITY INVOKER COMMENT 'Procedure lấy ra danh sách bản ghi theo một chuỗi các giá trị của một trường.' BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName, ' entity WHERE entity.', columnName, ' IN (', `values`, ')');
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Department_Filter` (IN `pageSize` INT, IN `pageNumber` INT, IN `searchText` VARCHAR(255))  SQL SECURITY INVOKER COMMENT 'Procedure lọc phòng ban.' BEGIN
  DECLARE startIndex int;
  SET startIndex = (pageNumber - 1) * pageSize;
  
  SELECT *
  FROM department d
  WHERE 
    (searchText IS NULL 
      OR (d.DepartmentCode LIKE CONCAT('%', searchText, '%')
          OR d.DepartmentName LIKE CONCAT('%', searchText, '%')
         )
    )
  LIMIT startIndex, pageSize;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Department_Insert` (IN `DepartmentId` CHAR(36), IN `DepartmentCode` VARCHAR(20), IN `DepartmentName` VARCHAR(100), IN `CreatedDate` DATETIME, IN `CreatedBy` VARCHAR(100))  SQL SECURITY INVOKER COMMENT 'Procedure thêm phòng ban.' BEGIN
  INSERT INTO department (DepartmentId, DepartmentCode, DepartmentName, CreatedDate, CreatedBy)
  VALUES (DepartmentId, DepartmentCode, DepartmentName, CreatedDate, CreatedBy);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Department_Update` (IN `DepartmentId` CHAR(36), IN `DepartmentCode` VARCHAR(20), IN `DepartmentName` VARCHAR(100), IN `ModifiedDate` DATETIME, IN `ModifiedBy` VARCHAR(255), IN `id` CHAR(36))  SQL SECURITY INVOKER COMMENT 'Procedure cập nhật thông tin phòng ban.' BEGIN
  UPDATE department d 
  SET d.DepartmentId = DepartmentId,
      d.DepartmentCode = DepartmentCode,
      d.DepartmentName = DepartmentName,
      d.ModifiedDate = ModifiedDate,
      d.ModifiedBy = ModifiedBy
  WHERE d.DepartmentId = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_EmployeeLayout_Insert` (IN `EmployeeLayoutId` CHAR(36), IN `ServerColumnName` VARCHAR(255), IN `CreatedDate` DATETIME, IN `CreatedBy` VARCHAR(100), IN `ColumnWidth` INT, IN `ColumnTextAlign` VARCHAR(255), IN `ColumnFormat` VARCHAR(255), IN `ColumnIsShow` TINYINT(1), IN `ColumnIsPin` TINYINT(1), IN `OrderNumber` INT, IN `ColumnIsShowDefault` TINYINT(1), IN `ColumnIsPinDefault` TINYINT(1), IN `ColumnWidthDefault` INT, IN `OrderNumberDefault` INT, IN `viTooltip` VARCHAR(255), IN `viClientColumnName` VARCHAR(255), IN `viClientColumnNameDefault` VARCHAR(255), IN `enTooltip` VARCHAR(255), IN `enClientColumnName` VARCHAR(255), IN `enClientColumnNameDefault` VARCHAR(255))  SQL SECURITY INVOKER COMMENT 'Procedure thêm 1 thông tin cột của nhân viên.' BEGIN
  INSERT INTO employeelayout (EmployeeLayoutId, ServerColumnName, Tooltip, ColumnWidth, ColumnTextAlign, ColumnFormat, ColumnIsShow, ColumnIsPin, OrderNumber, CreatedDate, CreatedBy, ColumnIsShowDefault, ColumnIsPin, OrderNumberDefault, ColumnWidthDefault, viTooltip, viClientColumnName, viClientColumnNameDefault, enTooltip, enClientColumnName, enClientColumnNameDefault)
  VALUES (EmployeeLayoutId, ServerColumnName, Tooltip, ColumnWidth, ColumnTextAlign, ColumnFormat, ColumnIsShow, ColumnIsPin, OrderNumber, CreatedDate, CreatedBy, ColumnIsShowDefault, ColumnIsPin, OrderNumberDefault, ColumnWidthDefault, viTooltip, viClientColumnName, viClientColumnNameDefault, enTooltip, enClientColumnName, enClientColumnNameDefault);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_EmployeeLayout_SetDefault` ()  SQL SECURITY INVOKER COMMENT 'Procedure lấy lại dữ liệu mặc định.' BEGIN
  UPDATE employeelayout
  set viClientColumnName = viClientColumnNameDefault,
      enClientColumnName = enClientColumnNameDefault,
      ColumnWidth = ColumnWidthDefault,
      ColumnIsShow = ColumnIsShowDefault,
      ColumnIsPin = ColumnIsPinDefault,
      OrderNumber = OrderNumberDefault;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_EmployeeLayout_Update` (IN `ColumnWidth` VARCHAR(255), IN `ModifiedDate` DATETIME, IN `ModifiedBy` VARCHAR(255), IN `id` CHAR(36), IN `ColumnIsShow` TINYINT(1), IN `ColumnIsPin` TINYINT(1), IN `OrderNumber` INT, IN `viClientColumnName` VARCHAR(255), IN `enClientColumnName` VARCHAR(255))  SQL SECURITY INVOKER COMMENT 'Procedure cập nhật thông tin cột của nhân viên.' BEGIN
  UPDATE employeelayout el 
  SET el.viClientColumnName = viClientColumnName,
      el.enClientColumnName = enClientColumnName,
      el.ColumnWidth = ColumnWidth,
      el.ColumnIsShow = ColumnIsShow,
      el.ColumnIsPin = ColumnIsPin,
      el.OrderNumber = OrderNumber,
      el.ModifiedDate = ModifiedDate,
      el.ModifiedBy = ModifiedBy
  WHERE el.EmployeeLayoutId = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_EmployeeLayout_UpdateList` (IN `values` MEDIUMTEXT)  SQL SECURITY INVOKER COMMENT 'Procedure cập nhật nhiều bản ghi của employee layout' BEGIN
    /* Dựa trên cơ chế insert nhưng gặp trùng */
    SET @columnsInsert = '(EmployeeLayoutId, viClientColumnName, enClientColumnName, ColumnWidth, ColumnIsShow, ColumnIsPin, OrderNumber, ModifiedDate, ModifiedBy)';
    SET @columnsUpdate = '
      EmployeeLayoutId=VALUES(EmployeeLayoutId), 
      viClientColumnName=VALUES(viClientColumnName),
      enClientColumnName=VALUES(enClientColumnName),
      ColumnWidth=VALUES(ColumnWidth), 
      ColumnIsShow=VALUES(ColumnIsShow),
      ColumnIsPin=VALUES(ColumnIsPin), 
      OrderNumber=VALUES(OrderNumber), 
      ModifiedDate=VALUES(ModifiedDate),
      ModifiedBy=VALUES(ModifiedBy);';
    SET @query = CONCAT('INSERT INTO employeelayout ', @columnsInsert, ' VALUES ', `values`, ' ON DUPLICATE KEY UPDATE EmployeeLayoutId = VALUES(EmployeeLayoutId),', @columnsUpdate);
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Employee_Filter` (IN `pageSize` INT, IN `pageNumber` INT, IN `searchText` VARCHAR(255))  SQL SECURITY INVOKER COMMENT 'Procedure lọc nhân viên.' BEGIN
  DECLARE startIndex int;
  SET startIndex = (pageNumber - 1) * pageSize;
  
  SELECT *
  FROM employee e
  WHERE 
    (searchText IS NULL 
      OR (e.EmployeeCode LIKE CONCAT('%', searchText, '%')
          OR e.FullName LIKE CONCAT('%', searchText, '%') 
          OR e.DepartmentCode LIKE CONCAT('%', searchText, '%') 
          OR e.DepartmentName LIKE CONCAT('%', searchText, '%') 
          OR e.IdentityNumber LIKE CONCAT('%', searchText, '%') 
          OR e.`Position` LIKE CONCAT('%', searchText, '%')
         )
    )
  ORDER BY GREATEST(COALESCE(e.ModifiedDate, '0000-00-00'), e.CreatedDate) DESC
  LIMIT startIndex, pageSize;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Employee_Insert` (IN `EmployeeId` CHAR(36), IN `EmployeeCode` VARCHAR(20), IN `FullName` VARCHAR(100), IN `DepartmentId` CHAR(36), IN `DepartmentCode` VARCHAR(20), IN `DepartmentName` VARCHAR(255), IN `Gender` INT(2), IN `DateOfBirth` DATE, IN `Position` VARCHAR(100), IN `SupplierCustomerGroup` VARCHAR(255), IN `IdentityNumber` VARCHAR(25), IN `IdentityDate` DATE, IN `IdentityPlace` VARCHAR(255), IN `PayAccount` VARCHAR(100), IN `ReceiveAccount` VARCHAR(100), IN `Salary` DECIMAL(18,4), IN `SalaryCoefficients` DECIMAL(18,4), IN `SalaryPaidForInsurance` DECIMAL(18,4), IN `PersonalTaxCode` VARCHAR(25), IN `TypeOfContract` VARCHAR(255), IN `NumberOfDependents` INT(10), IN `AccountNumber` VARCHAR(25), IN `BankName` VARCHAR(255), IN `BankBranch` VARCHAR(255), IN `BankProvince` VARCHAR(255), IN `ContactAddress` VARCHAR(255), IN `ContactPhoneNumber` VARCHAR(50), IN `ContactLandlinePhoneNumber` VARCHAR(50), IN `ContactEmail` VARCHAR(100), IN `CreatedDate` DATETIME, IN `CreatedBy` VARCHAR(100))  SQL SECURITY INVOKER COMMENT 'Procedure thêm nhân viên.' BEGIN
  INSERT INTO employee (EmployeeId, EmployeeCode, FullName, DepartmentId, DepartmentCode, DepartmentName, Gender, DateOfBirth, `Position`, SupplierCustomerGroup, IdentityNumber, IdentityDate, IdentityPlace, PayAccount, ReceiveAccount, Salary, SalaryCoefficients, SalaryPaidForInsurance, PersonalTaxCode, TypeOfContract, NumberOfDependents, AccountNumber, BankName, BankBranch, BankProvince, ContactAddress, ContactPhoneNumber, ContactLandlinePhoneNumber, ContactEmail, CreatedDate, CreatedBy)
  VALUES (EmployeeId, EmployeeCode, FullName, DepartmentId, DepartmentCode, DepartmentName, Gender, DateOfBirth, Position, SupplierCustomerGroup, IdentityNumber, IdentityDate, IdentityPlace, PayAccount, ReceiveAccount, Salary, SalaryCoefficients, SalaryPaidForInsurance, PersonalTaxCode, TypeOfContract, NumberOfDependents, AccountNumber, BankName, BankBranch, BankProvince, ContactAddress, ContactPhoneNumber, ContactLandlinePhoneNumber, ContactEmail, CreatedDate, CreatedBy);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Employee_InsertList` (IN `values` MEDIUMTEXT)  SQL SECURITY INVOKER COMMENT 'Procedure thêm nhiều bản ghi.' BEGIN
    SET @columnsInsert = '(EmployeeId, EmployeeCode, FullName, DepartmentId, DepartmentCode, DepartmentName, Gender, DateOfBirth, `Position`, SupplierCustomerGroup, IdentityNumber, IdentityDate, IdentityPlace, PayAccount, ReceiveAccount, Salary, SalaryCoefficients, SalaryPaidForInsurance, PersonalTaxCode, TypeOfContract, NumberOfDependents, AccountNumber, BankName, BankBranch, BankProvince, ContactAddress, ContactPhoneNumber, ContactLandlinePhoneNumber, ContactEmail, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy)';
    SET @query = CONCAT('INSERT INTO employee ', @columnsInsert, ' VALUES ', `values`);
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Employee_NewCode` ()  SQL SECURITY INVOKER COMMENT 'Procedure lấy mã nhân viên mới không trùng.' BEGIN
  DECLARE LastestCode varchar(20);

  -- Lấy tiền tố của mã nhân viên tạo mới nhất
  SELECT
  SUBSTRING_INDEX (e.EmployeeCode, '-', 1) INTO LastestCode
  FROM employee e
  ORDER BY e.CreatedDate DESC LIMIT 1;

  -- Tìm hậu tố lớn nhất của tiền tố vừa tìm được
  SELECT
    CONCAT(LastestCode, '-', MAX(CAST(SUBSTRING_INDEX (EmployeeCode, '-', -1) AS UNSIGNED)) + 1) AS MaxCode
  FROM employee
  WHERE EmployeeCode LIKE CONCAT(LastestCode, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Employee_Update` (IN `EmployeeId` CHAR(36), IN `EmployeeCode` VARCHAR(20), IN `FullName` VARCHAR(100), IN `DepartmentId` CHAR(36), IN `DepartmentCode` VARCHAR(20), IN `DepartmentName` VARCHAR(255), IN `Gender` INT(2), IN `DateOfBirth` DATE, IN `Position` VARCHAR(100), IN `SupplierCustomerGroup` VARCHAR(255), IN `IdentityNumber` VARCHAR(25), IN `IdentityDate` DATE, IN `IdentityPlace` VARCHAR(255), IN `PayAccount` VARCHAR(100), IN `ReceiveAccount` VARCHAR(100), IN `Salary` DECIMAL(18,4), IN `SalaryCoefficients` DECIMAL(18,4), IN `SalaryPaidForInsurance` DECIMAL(18,4), IN `PersonalTaxCode` VARCHAR(25), IN `TypeOfContract` VARCHAR(255), IN `NumberOfDependents` INT(10), IN `AccountNumber` VARCHAR(25), IN `BankName` VARCHAR(255), IN `BankBranch` VARCHAR(255), IN `BankProvince` VARCHAR(255), IN `ContactAddress` VARCHAR(255), IN `ContactPhoneNumber` VARCHAR(50), IN `ContactLandlinePhoneNumber` VARCHAR(50), IN `ContactEmail` VARCHAR(100), IN `ModifiedDate` DATETIME, IN `ModifiedBy` VARCHAR(255), IN `id` CHAR(36))  MODIFIES SQL DATA SQL SECURITY INVOKER COMMENT 'Procedure cập nhật thông tin nhân viên.' BEGIN
DECLARE cr_stack_depth_handler INTEGER/*[cr_debug.1]*/;
DECLARE cr_stack_depth INTEGER DEFAULT cr_debug.ENTER_MODULE2('Proc_Employee_Update', 'misa.web202305_mf1666_ttanh', 7, 100637)/*[cr_debug.1]*/;
  CALL cr_debug.UPDATE_WATCH3('`EmployeeId`', `EmployeeId`, 'CHAR(36)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`EmployeeCode`', `EmployeeCode`, 'VARCHAR(20)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`FullName`', `FullName`, 'VARCHAR(100)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`DepartmentId`', `DepartmentId`, 'CHAR(36)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`DepartmentCode`', `DepartmentCode`, 'VARCHAR(20)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`DepartmentName`', `DepartmentName`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`Gender`', `Gender`, 'INT(2)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`DateOfBirth`', `DateOfBirth`, 'DATE', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`Position`', `Position`, 'VARCHAR(100)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`SupplierCustomerGroup`', `SupplierCustomerGroup`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`IdentityNumber`', `IdentityNumber`, 'VARCHAR(25)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`IdentityDate`', `IdentityDate`, 'DATE', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`IdentityPlace`', `IdentityPlace`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`PayAccount`', `PayAccount`, 'VARCHAR(100)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`ReceiveAccount`', `ReceiveAccount`, 'VARCHAR(100)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`Salary`', `Salary`, 'DECIMAL(18,4)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`SalaryCoefficients`', `SalaryCoefficients`, 'DECIMAL(18,4)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`SalaryPaidForInsurance`', `SalaryPaidForInsurance`, 'DECIMAL(18,4)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`PersonalTaxCode`', `PersonalTaxCode`, 'VARCHAR(25)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`TypeOfContract`', `TypeOfContract`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`NumberOfDependents`', `NumberOfDependents`, 'INT(10)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`AccountNumber`', `AccountNumber`, 'VARCHAR(25)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`BankName`', `BankName`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`BankBranch`', `BankBranch`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`BankProvince`', `BankProvince`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`ContactAddress`', `ContactAddress`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`ContactPhoneNumber`', `ContactPhoneNumber`, 'VARCHAR(50)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`ContactLandlinePhoneNumber`', `ContactLandlinePhoneNumber`, 'VARCHAR(50)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`ContactEmail`', `ContactEmail`, 'VARCHAR(100)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`ModifiedDate`', `ModifiedDate`, 'DATETIME', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`ModifiedBy`', `ModifiedBy`, 'VARCHAR(255)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.UPDATE_WATCH3('`id`', `id`, 'CHAR(36)', cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.TRACE(4, 4, 0, 5, 0, cr_stack_depth)/*[cr_debug.2]*/;
CALL cr_debug.TRACE(5, 36, 2, 26, 104, cr_stack_depth)/*[cr_debug.2]*/;
UPDATE employee e
  SET e.EmployeeCode = EmployeeCode,
    e.FullName = FullName,
    e.DepartmentId = DepartmentId,
    e.DepartmentCode = DepartmentCode,
    e.DepartmentName = DepartmentName,
    e.Gender = Gender,
    e.DateOfBirth = DateOfBirth,
    e.`Position` = Position,
    e.SupplierCustomerGroup = SupplierCustomerGroup,
    e.IdentityNumber = IdentityNumber,
    e.IdentityDate = IdentityDate,
    e.IdentityPlace = IdentityPlace,
    e.PayAccount = PayAccount,
    e.ReceiveAccount = ReceiveAccount,
    e.Salary = Salary,
    e.SalaryCoefficients = SalaryCoefficients,
    e.SalaryPaidForInsurance = SalaryPaidForInsurance,
    e.PersonalTaxCode = PersonalTaxCode,
    e.TypeOfContract = TypeOfContract,
    e.NumberOfDependents = NumberOfDependents,
    e.AccountNumber = AccountNumber,
    e.BankName = BankName,
    e.BankBranch = BankBranch,
    e.BankProvince = BankProvince,
    e.ContactAddress = ContactAddress,
    e.ContactPhoneNumber = ContactPhoneNumber,
    e.ContactLandlinePhoneNumber = ContactLandlinePhoneNumber,
    e.ContactEmail = ContactEmail,
    e.ModifiedDate = ModifiedDate,
    e.ModifiedBy = ModifiedBy
  WHERE e.EmployeeId = id;
CALL cr_debug.UPDATE_SYSTEM_CALLS(104)/*[cr_debug.1]*/;
CALL cr_debug.TRACE(37, 37, 0, 3, 0, cr_stack_depth)/*[cr_debug.2]*/;
SET cr_stack_depth = cr_stack_depth - 1/*[cr_debug.2]*/;
CALL cr_debug.LEAVE_MODULE(cr_stack_depth)/*[cr_debug.2]*/;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Proc_Employee_UpdateList` (IN `values` MEDIUMTEXT)  SQL SECURITY INVOKER COMMENT 'Procedure cập nhật nhiều bản ghi.' BEGIN
    /* Dựa trên cơ chế insert nhưng gặp trùng */
    SET @columnsInsert = '(EmployeeCode, FullName, DepartmentId, DepartmentCode, DepartmentName, Gender, DateOfBirth, `Position`, SupplierCustomerGroup, IdentityNumber, IdentityDate, IdentityPlace, PayAccount, ReceiveAccount, Salary, SalaryCoefficients, SalaryPaidForInsurance, PersonalTaxCode, TypeOfContract, NumberOfDependents, AccountNumber, BankName, BankBranch, BankProvince, ContactAddress, ContactPhoneNumber, ContactLandlinePhoneNumber, ContactEmail, ModifiedDate, ModifiedBy)';
    SET @columnsUpdate = '
      FullName=VALUES(FullName), 
      DepartmentId=VALUES(DepartmentId),
      DepartmentCode=VALUES(DepartmentCode), 
      DepartmentName=VALUES(DepartmentName),
      Gender=VALUES(Gender), 
      DateOfBirth=VALUES(DateOfBirth),
      `Position`=VALUES(`Position`),
      SupplierCustomerGroup=VALUES(SupplierCustomerGroup),
      IdentityNumber=VALUES(IdentityNumber), 
      IdentityDate=VALUES(IdentityDate),
      IdentityPlace=VALUES(IdentityPlace),
      PayAccount=VALUES(PayAccount),
      ReceiveAccount=VALUES(ReceiveAccount), 
      Salary=VALUES(Salary),
      SalaryCoefficients=VALUES(SalaryCoefficients),
      SalaryPaidForInsurance=VALUES(SalaryPaidForInsurance),
      PersonalTaxCode=VALUES(PersonalTaxCode), 
      TypeOfContract=VALUES(TypeOfContract),
      NumberOfDependents=VALUES(NumberOfDependents),
      AccountNumber=VALUES(AccountNumber), 
      BankName=VALUES(BankName),
      BankBranch=VALUES(BankBranch), 
      BankProvince=VALUES(BankProvince),
      ContactAddress=VALUES(ContactAddress),
      ContactPhoneNumber=VALUES(ContactPhoneNumber),
      ContactLandlinePhoneNumber=VALUES(ContactLandlinePhoneNumber),
      ContactEmail=VALUES(ContactEmail), 
      ModifiedDate=VALUES(ModifiedDate),
      ModifiedBy=VALUES(ModifiedBy);';
    SET @query = CONCAT('INSERT INTO employee ', @columnsInsert, ' VALUES ', `values`, ' ON DUPLICATE KEY UPDATE EmployeeCode = VALUES(EmployeeCode),', @columnsUpdate);
    PREPARE stmt FROM @query;
    EXECUTE stmt;

    /* giải phóng tài nguyên */
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DepartmentId` char(36) NOT NULL COMMENT 'Id phòng ban',
  `DepartmentCode` varchar(20) NOT NULL COMMENT 'Mã phòng ban',
  `DepartmentName` varchar(255) NOT NULL COMMENT 'Tên phòng ban',
  `CreatedDate` datetime NOT NULL COMMENT 'Ngày tạo',
  `CreatedBy` varchar(100) DEFAULT NULL COMMENT 'Tạo bởi',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(255) DEFAULT NULL COMMENT 'Sửa bởi'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Thông tin phòng ban';

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DepartmentId`, `DepartmentCode`, `DepartmentName`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
('142cb08f-7c31-21fa-8e90-67245e8b283e', 'PB-0460', 'Phòng nhân sự', '1970-01-01 00:07:13', 'Letha Bolt', '1970-01-01 00:00:04', 'Abraham Acevedo'),
('17120d02-6ab5-3e43-18cb-66948daf6128', 'PB-9483', 'Phòng đào tạo', '2001-10-05 03:39:34', 'Miyoko Mckinney', '1971-05-16 09:45:54', 'Hong Beaudoin'),
('469b3ece-744a-45d5-957d-e8c757976496', 'PB-5222', 'Phòng sản xuất', '2019-06-30 12:29:53', 'Vanita Kelleher', '1975-01-31 18:53:18', 'Retta Lord'),
('4e272fc4-7875-78d6-7d32-6a1673ffca7c', 'PB-2675', 'Phòng hành chính', '2015-02-25 11:35:34', 'Marcos Abraham', '1970-01-01 00:00:08', 'Treena Lind');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `EmployeeId` char(36) NOT NULL COMMENT 'Id nhân viên',
  `EmployeeCode` varchar(20) NOT NULL COMMENT 'Mã nhân viên',
  `FullName` varchar(100) NOT NULL COMMENT 'Tên nhân viên',
  `DepartmentId` char(36) NOT NULL COMMENT 'Id phòng ban',
  `DepartmentCode` varchar(20) NOT NULL COMMENT 'Mã code phòng ban',
  `DepartmentName` varchar(255) NOT NULL COMMENT 'Tên phòng ban',
  `Gender` int(2) DEFAULT NULL COMMENT 'Giới tính (0 - Nam; 1 - Nữ; 2 - Khác)',
  `DateOfBirth` date DEFAULT NULL COMMENT 'Ngày sinh',
  `Position` varchar(100) DEFAULT NULL COMMENT 'Chức danh',
  `SupplierCustomerGroup` varchar(255) DEFAULT NULL COMMENT 'Nhóm khách hàng, nhà cung cấp',
  `IdentityNumber` varchar(25) DEFAULT NULL COMMENT 'Số CMND',
  `IdentityDate` date DEFAULT NULL COMMENT 'Ngày cấp',
  `IdentityPlace` varchar(255) DEFAULT NULL COMMENT 'Nơi cấp',
  `PayAccount` varchar(100) DEFAULT NULL COMMENT 'TK công nợ phải trả',
  `ReceiveAccount` varchar(100) DEFAULT NULL COMMENT 'TK công nợ phải thu',
  `Salary` decimal(18,4) DEFAULT NULL COMMENT 'Lương thỏa thuận',
  `SalaryCoefficients` decimal(18,4) DEFAULT NULL COMMENT 'Hệ số lương',
  `SalaryPaidForInsurance` decimal(18,4) DEFAULT NULL COMMENT 'Lương đóng bảo hiểm',
  `PersonalTaxCode` varchar(25) DEFAULT NULL COMMENT 'Mã số thuế',
  `TypeOfContract` varchar(255) DEFAULT NULL COMMENT 'Loại hợp đồng',
  `NumberOfDependents` int(10) DEFAULT NULL COMMENT 'Số người phụ thuộc',
  `AccountNumber` varchar(25) DEFAULT NULL COMMENT 'Số tài khoản ngân hàng',
  `BankName` varchar(255) DEFAULT NULL COMMENT 'Tên ngân hàng',
  `BankBranch` varchar(255) DEFAULT NULL COMMENT 'Chi nhánh ngân hàng',
  `BankProvince` varchar(255) DEFAULT NULL COMMENT 'Tỉnh/TP của ngân hàng',
  `ContactAddress` varchar(255) DEFAULT NULL COMMENT 'Địa chỉ',
  `ContactPhoneNumber` varchar(50) DEFAULT NULL COMMENT 'Điện thoại di động',
  `ContactLandlinePhoneNumber` varchar(50) DEFAULT NULL COMMENT 'ĐT cố định',
  `ContactEmail` varchar(100) DEFAULT NULL COMMENT 'Email',
  `CreatedDate` datetime DEFAULT NULL COMMENT 'Ngày tạo',
  `CreatedBy` varchar(100) DEFAULT NULL COMMENT 'Người tạo',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa',
  `ModifiedBy` varchar(100) DEFAULT NULL COMMENT 'Người sửa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Thông tin nhân viên';

-- --------------------------------------------------------

--
-- Table structure for table `employeelayout`
--

CREATE TABLE `employeelayout` (
  `EmployeeLayoutId` char(36) NOT NULL COMMENT 'Khóa chính theo Guid.',
  `ServerColumnName` varchar(255) NOT NULL COMMENT 'Tên của cột trên server để lấy dữ liệu từ api.',
  `viTooltip` varchar(255) NOT NULL COMMENT 'Tooltip bằng tiếng việt.',
  `viClientColumnName` varchar(255) NOT NULL COMMENT 'Tên cột hiển thị trên mà hình bằng tiếng việt.',
  `viClientColumnNameDefault` varchar(255) NOT NULL COMMENT 'Tên cột mặc định bằng tiếng việt.',
  `enTooltip` varchar(255) NOT NULL COMMENT 'Tooltip bằng tiếng anh.',
  `enClientColumnName` varchar(255) NOT NULL COMMENT 'Tên cột hiển thị trên màn hình bằng tiếng anh.',
  `enClientColumnNameDefault` varchar(255) NOT NULL COMMENT 'Tên cột mặc định bằng tiếng anh.',
  `ColumnWidth` int(11) NOT NULL COMMENT 'Kích thước cột hiển thị trên màn hình.',
  `ColumnWidthDefault` int(11) NOT NULL COMMENT 'Chiều dài của cột mặc định.',
  `ColumnTextAlign` varchar(255) NOT NULL COMMENT 'Loại căn giữa của cột hiển thị trên màn hình (center - căn giữa; left - căn trái; right - căn phải)',
  `ColumnFormat` varchar(255) NOT NULL COMMENT 'Loại format của các phần tử trong cột (text - chữ; date - ngày tháng; currency - tiền tệ)',
  `ColumnIsShow` tinyint(1) NOT NULL COMMENT 'Xác định xem cột này có được hiển thị không.',
  `ColumnIsShowDefault` tinyint(1) NOT NULL COMMENT 'Hiển thị cột mặc định.',
  `ColumnIsPin` tinyint(1) NOT NULL COMMENT 'Xác định xem cột có được ghim không.',
  `ColumnIsPinDefault` tinyint(1) NOT NULL COMMENT 'Cố định cột mặc định.',
  `OrderNumber` int(11) NOT NULL COMMENT 'Xác định số thứ tự của cột.',
  `OrderNumberDefault` int(11) NOT NULL COMMENT 'Số thứ tự của cột mặc định.',
  `CreatedDate` datetime NOT NULL COMMENT 'Ngày tạo.',
  `CreatedBy` varchar(100) NOT NULL COMMENT 'Người tạo.',
  `ModifiedDate` datetime DEFAULT NULL COMMENT 'Ngày sửa.',
  `ModifiedBy` varchar(100) DEFAULT NULL COMMENT 'Người sửa.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Lưu trữ thông tin bố cục của phân hệ quản lý nhân viên.';

--
-- Dumping data for table `employeelayout`
--

INSERT INTO `employeelayout` (`EmployeeLayoutId`, `ServerColumnName`, `viTooltip`, `viClientColumnName`, `viClientColumnNameDefault`, `enTooltip`, `enClientColumnName`, `enClientColumnNameDefault`, `ColumnWidth`, `ColumnWidthDefault`, `ColumnTextAlign`, `ColumnFormat`, `ColumnIsShow`, `ColumnIsShowDefault`, `ColumnIsPin`, `ColumnIsPinDefault`, `OrderNumber`, `OrderNumberDefault`, `CreatedDate`, `CreatedBy`, `ModifiedDate`, `ModifiedBy`) VALUES
('3fa85f64-5717-4562-b3fc-2c963f66af10', 'IdentityNumber', 'Số chứng minh nhân dân', 'Số CMND', 'Số CMND', 'Identity Number', 'Identity Number', 'Identity Number', 200, 200, 'right', 'text', 1, 1, 0, 0, 5, 5, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af11', 'IdentityDate', 'Ngày cấp', 'Ngày cấp', 'Ngày cấp', 'Identity Date', 'Identity Date', 'Identity Date', 150, 150, 'center', 'date', 1, 1, 0, 0, 6, 6, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af12', 'IdentityPlace', 'Nơi cấp', 'Nơi cấp', 'Nơi cấp', 'Identity Place', 'Identity Place', 'Identity Place', 150, 150, 'left', 'text', 1, 1, 0, 0, 7, 7, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af13', 'Position', 'Chức danh', 'Chức danh', 'Chức danh', 'Position', 'Position', 'Position', 250, 250, 'left', 'text', 1, 1, 0, 0, 8, 8, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af14', 'DepartmentCode', 'Mã đơn vị', 'Mã đơn vị', 'Mã đơn vị', 'Department Code', 'Department Code', 'Department Code', 150, 150, 'left', 'text', 1, 1, 0, 0, 9, 9, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af15', 'DepartmentName', 'Tên đơn vị', 'Tên đơn vị', 'Tên đơn vị', 'Department Name', 'Department Name', 'Department Name', 250, 250, 'left', 'text', 1, 1, 0, 0, 10, 10, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af16', 'SupplierCustomerGroup', 'Nhóm khách hàng/nhà cung cấp', 'Nhóm KH, NCC', 'Nhóm KH, NCC', 'Supplier Customer Group', 'Supplier Customer Group', 'Supplier Customer Group', 200, 200, 'left', 'text', 1, 1, 0, 0, 11, 11, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af17', 'PayAccount', 'TK công nợ phải trả', 'TK công nợ phải trả', 'TK công nợ phải trả', 'Pay Account', 'Pay Account', 'Pay Account', 200, 200, 'left', 'text', 1, 1, 0, 0, 12, 12, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af18', 'ReceiveAccount', 'TK công nợ phải thu', 'TK công nợ phải thu', 'TK công nợ phải thu', 'Receive Account', 'Receive Account', 'Receive Account', 200, 200, 'left', 'text', 1, 1, 0, 0, 13, 13, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af19', 'Salary', 'Lương thỏa thuận', 'Lương thỏa thuận', 'Lương thỏa thuận', 'Salary', 'Salary', 'Salary', 200, 200, 'right', 'currency', 1, 1, 0, 0, 14, 14, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af20', 'SalaryCoefficients', 'Hệ số lương', 'Hệ số lương', 'Hệ số lương', 'Salary Coefficients', 'Salary Coefficients', 'Salary Coefficients', 200, 200, 'right', 'text', 1, 1, 0, 0, 15, 15, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af21', 'SalaryPaidForInsurance', 'Lương đóng bảo hiểm', 'Lương đóng bảo hiểm', 'Lương đóng bảo hiểm', 'Salary Paid For Insurance', 'Salary Paid For Insurance', 'Salary Paid For Insurance', 200, 200, 'right', 'currency', 1, 1, 0, 0, 16, 16, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af22', 'PersonalTaxCode', 'Mã số thuế', 'Mã số thuế', 'Mã số thuế', 'Personal Tax Code', 'Personal Tax Code', 'Personal Tax Code', 150, 150, 'right', 'text', 1, 1, 0, 0, 17, 17, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af23', 'TypeOfContract', 'Loại hợp đồng', 'Loại hợp đồng', 'Loại hợp đồng', 'Type Of Contract', 'Type Of Contract', 'Type Of Contract', 150, 150, 'left', 'text', 1, 1, 0, 0, 18, 18, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af24', 'NumberOfDependents', 'Số người phụ thuộc', 'Số người phụ thuộc', 'Số người phụ thuộc', 'Number Of Dependents', 'Number Of Dependents', 'Number Of Dependents', 200, 200, 'right', 'text', 1, 1, 0, 0, 19, 19, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af25', 'AccountNumber', 'Số tài khoản', 'Số tài khoản', 'Số tài khoản', 'Account Number', 'Account Number', 'Account Number', 150, 150, 'right', 'text', 1, 1, 0, 0, 20, 20, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af26', 'BankName', 'Tên ngân hàng', 'Tên ngân hàng', 'Tên ngân hàng', 'Bank Name', 'Bank Name', 'Bank Name', 250, 250, 'left', 'text', 1, 1, 0, 0, 21, 21, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af27', 'BankBranch', 'Chi nhánh tài khoản ngân hàng', 'Chi nhánh TK ngân hàng', 'Chi nhánh TK ngân hàng', 'Bank Branch', 'Bank Branch', 'Bank Branch', 250, 250, 'left', 'text', 1, 1, 0, 0, 22, 22, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af28', 'BankProvince', 'Tỉnh/Thành phố ngân hàng', 'Tỉnh/TP ngân hàng', 'Tỉnh/TP ngân hàng', 'Bank Province', 'Bank Province', 'Bank Province', 180, 180, 'left', 'text', 1, 1, 0, 0, 23, 23, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af29', 'ContactAddress', 'Địa chỉ', 'Địa chỉ', 'Địa chỉ', 'Contact Address', 'Contact Address', 'Contact Address', 200, 200, 'left', 'text', 1, 1, 0, 0, 24, 24, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af30', 'ContactPhoneNumber', 'Điện thoại di động', 'ĐT di động', 'ĐT di động', 'Contact Phone Number', 'Contact Phone Number', 'Contact Phone Number', 150, 150, 'right', 'text', 1, 1, 0, 0, 25, 25, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af31', 'ContactLandlinePhoneNumber', 'Điện thoại cố định', 'ĐT cố định', 'ĐT cố định', 'Contact Landline Phone Number', 'Contact Landline Phone Number', 'Contact Landline Phone Number', 150, 150, 'right', 'text', 1, 1, 0, 0, 26, 26, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66af32', 'ContactEmail', 'Email', 'Email', 'Email', 'Contact Email', 'Contact Email', 'Contact Email', 200, 200, 'left', 'text', 1, 1, 0, 0, 27, 27, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66afa6', 'EmployeeCode', 'Mã nhân viên', 'Mã nhân viên', 'Mã nhân viên', 'Employee Code', 'Employee Code', 'Employee Code', 150, 150, 'left', 'text', 1, 1, 0, 0, 1, 1, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66afa7', 'FullName', 'Tên nhân viên', 'Tên nhân viên', 'Tên nhân viên', 'Full Name', 'Full Name', 'Full Name', 250, 250, 'left', 'text', 1, 1, 0, 0, 2, 2, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66afa8', 'Gender', 'Giới tính', 'Giới tính', 'Giới tính', 'Gender', 'Gender', 'Gender', 120, 120, 'left', 'gender', 1, 1, 0, 0, 3, 3, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh'),
('3fa85f64-5717-4562-b3fc-2c963f66afa9', 'DateOfBirth', 'Ngày sinh', 'Ngày sinh', 'Ngày sinh', 'Date Of Birth', 'Date Of Birth', 'Date Of Birth', 150, 150, 'center', 'date', 1, 1, 0, 0, 4, 4, '2023-08-02 20:31:27', 'Thế Anh', '2023-08-06 17:07:28', 'Thế Anh');

-- --------------------------------------------------------

--
-- Table structure for table `hangfireaggregatedcounter`
--

CREATE TABLE `hangfireaggregatedcounter` (
  `Id` int(11) NOT NULL,
  `Key` varchar(100) NOT NULL,
  `Value` int(11) NOT NULL,
  `ExpireAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hangfireaggregatedcounter`
--

INSERT INTO `hangfireaggregatedcounter` (`Id`, `Key`, `Value`, `ExpireAt`) VALUES
(1, 'stats:succeeded', 291, NULL),
(2, 'stats:succeeded:2023-07-24', 24, '2023-08-24 18:00:16'),
(27, 'stats:succeeded:2023-07-25', 16, '2023-08-25 15:00:28'),
(45, 'stats:succeeded:2023-07-26', 15, '2023-08-26 16:00:05'),
(62, 'stats:succeeded:2023-07-27', 24, '2023-08-27 16:05:10'),
(89, 'stats:succeeded:2023-07-28', 15, '2023-08-28 13:50:13'),
(106, 'stats:succeeded:2023-07-29', 13, '2023-08-29 07:00:25'),
(121, 'stats:succeeded:2023-07-30', 30, '2023-08-30 15:50:01'),
(152, 'stats:succeeded:2023-07-31', 19, '2023-08-31 23:50:08'),
(171, 'stats:succeeded:2023-08-01', 31, '2023-09-01 15:00:25'),
(204, 'stats:succeeded:2023-08-02', 27, '2023-09-02 16:00:07'),
(231, 'stats:succeeded:2023-08-03', 29, '2023-09-03 16:00:06'),
(262, 'stats:succeeded:2023-08-04', 1, '2023-09-04 00:20:04'),
(264, 'stats:succeeded:2023-08-05', 14, '2023-09-05 15:30:20'),
(265, 'stats:succeeded:2023-08-05-10', 2, '2023-08-06 10:50:50'),
(270, 'stats:succeeded:2023-08-05-11', 4, '2023-08-06 11:45:14'),
(274, 'stats:succeeded:2023-08-05-12', 1, '2023-08-06 12:01:14'),
(275, 'stats:succeeded:2023-08-05-14', 4, '2023-08-06 14:45:36'),
(279, 'stats:succeeded:2023-08-05-15', 3, '2023-08-06 15:30:20'),
(282, 'stats:succeeded:2023-08-06', 33, '2023-09-06 10:15:07'),
(283, 'stats:succeeded:2023-08-06-00', 4, '2023-08-07 00:45:04'),
(288, 'stats:succeeded:2023-08-06-01', 4, '2023-08-07 01:45:16'),
(292, 'stats:succeeded:2023-08-06-02', 4, '2023-08-07 02:45:12'),
(296, 'stats:succeeded:2023-08-06-03', 4, '2023-08-07 03:45:15'),
(300, 'stats:succeeded:2023-08-06-04', 2, '2023-08-07 04:16:16'),
(302, 'stats:succeeded:2023-08-06-06', 1, '2023-08-07 06:50:07'),
(303, 'stats:succeeded:2023-08-06-07', 4, '2023-08-07 07:45:16'),
(307, 'stats:succeeded:2023-08-06-08', 4, '2023-08-07 08:45:09'),
(311, 'stats:succeeded:2023-08-06-09', 4, '2023-08-07 09:45:04'),
(315, 'stats:succeeded:2023-08-06-10', 2, '2023-08-07 10:15:07');

-- --------------------------------------------------------

--
-- Table structure for table `hangfirecounter`
--

CREATE TABLE `hangfirecounter` (
  `Id` int(11) NOT NULL,
  `Key` varchar(100) NOT NULL,
  `Value` int(11) NOT NULL,
  `ExpireAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hangfiredistributedlock`
--

CREATE TABLE `hangfiredistributedlock` (
  `Resource` varchar(100) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hangfirehash`
--

CREATE TABLE `hangfirehash` (
  `Id` int(11) NOT NULL,
  `Key` varchar(100) NOT NULL,
  `Field` varchar(40) NOT NULL,
  `Value` longtext DEFAULT NULL,
  `ExpireAt` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hangfirehash`
--

INSERT INTO `hangfirehash` (`Id`, `Key`, `Field`, `Value`, `ExpireAt`) VALUES
(1, 'recurring-job:IScheduleService.ClearFiles', 'Queue', 'default', NULL),
(2, 'recurring-job:IScheduleService.ClearFiles', 'Cron', '*/15 * * * *', NULL),
(3, 'recurring-job:IScheduleService.ClearFiles', 'TimeZoneId', 'UTC', NULL),
(4, 'recurring-job:IScheduleService.ClearFiles', 'Job', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', NULL),
(5, 'recurring-job:IScheduleService.ClearFiles', 'CreatedAt', '2023-07-24T06:39:48.3311497Z', NULL),
(6, 'recurring-job:IScheduleService.ClearFiles', 'NextExecution', '2023-08-06T10:30:00.0000000Z', NULL),
(7, 'recurring-job:IScheduleService.ClearFiles', 'V', '2', NULL),
(8, 'recurring-job:IScheduleService.ClearFiles', 'LastExecution', '2023-08-06T10:15:02.9257811Z', NULL),
(10, 'recurring-job:IScheduleService.ClearFiles', 'LastJobId', '291', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hangfirejob`
--

CREATE TABLE `hangfirejob` (
  `Id` int(11) NOT NULL,
  `StateId` int(11) DEFAULT NULL,
  `StateName` varchar(20) DEFAULT NULL,
  `InvocationData` longtext NOT NULL,
  `Arguments` longtext NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `ExpireAt` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hangfirejob`
--

INSERT INTO `hangfirejob` (`Id`, `StateId`, `StateName`, `InvocationData`, `Arguments`, `CreatedAt`, `ExpireAt`) VALUES
(245, 735, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 10:40:19.847091', '2023-08-06 10:40:40.123180'),
(246, 738, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 10:50:50.415148', '2023-08-06 10:50:50.588455'),
(247, 741, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 11:00:11.519614', '2023-08-06 11:00:13.100438'),
(248, 744, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 11:20:25.796422', '2023-08-06 11:20:35.783702'),
(249, 747, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 11:30:04.159648', '2023-08-06 11:30:12.896426'),
(250, 750, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 11:45:08.704830', '2023-08-06 11:45:14.031337'),
(251, 753, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 12:01:09.786464', '2023-08-06 12:01:14.963759'),
(252, 756, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 14:03:13.752732', '2023-08-06 14:03:23.792842'),
(253, 759, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 14:15:29.458187', '2023-08-06 14:15:34.482927'),
(254, 762, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 14:30:30.379585', '2023-08-06 14:30:35.279908'),
(255, 765, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 14:45:31.287416', '2023-08-06 14:45:36.020104'),
(256, 768, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 15:00:17.223255', '2023-08-06 15:00:26.813647'),
(257, 771, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 15:15:18.138893', '2023-08-06 15:15:27.649735'),
(258, 774, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-05 15:30:15.216800', '2023-08-06 15:30:20.198717'),
(259, 777, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 00:04:43.371459', '2023-08-07 00:04:53.405510'),
(260, 780, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 00:15:04.369104', '2023-08-07 00:15:13.923825'),
(261, 783, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 00:30:05.336411', '2023-08-07 00:30:05.796416'),
(262, 786, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 00:45:04.268198', '2023-08-07 00:45:04.635275'),
(263, 789, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 01:00:02.008844', '2023-08-07 01:00:02.372562'),
(264, 792, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 01:15:01.272676', '2023-08-07 01:15:05.220757'),
(265, 795, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 01:30:02.929878', '2023-08-07 01:30:06.059350'),
(266, 798, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 01:45:12.381317', '2023-08-07 01:45:16.984712'),
(267, 801, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 02:00:03.300574', '2023-08-07 02:00:08.150802'),
(268, 804, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 02:15:12.195236', '2023-08-07 02:15:18.906308'),
(269, 807, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 02:30:04.864223', '2023-08-07 02:30:11.327334'),
(270, 810, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 02:45:04.636865', '2023-08-07 02:45:12.077687'),
(271, 813, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 03:00:09.061141', '2023-08-07 03:00:12.835047'),
(272, 816, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 03:15:07.192696', '2023-08-07 03:15:13.558096'),
(273, 819, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 03:30:07.424773', '2023-08-07 03:30:14.317907'),
(274, 822, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 03:45:06.380046', '2023-08-07 03:45:15.097754'),
(275, 825, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 04:01:07.382470', '2023-08-07 04:01:15.929501'),
(276, 828, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 04:16:08.336336', '2023-08-07 04:16:16.719066'),
(277, 831, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 06:49:57.890333', '2023-08-07 06:50:07.936856'),
(278, 834, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 07:00:19.165700', '2023-08-07 07:00:24.120080'),
(279, 837, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 07:15:20.011512', '2023-08-07 07:15:24.934176'),
(280, 840, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 07:30:20.907926', '2023-08-07 07:30:25.731320'),
(281, 843, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 07:45:06.856564', '2023-08-07 07:45:16.522982'),
(282, 846, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 08:00:07.852645', '2023-08-07 08:00:17.403372'),
(283, 849, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 08:15:08.743093', '2023-08-07 08:15:18.179077'),
(284, 852, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 08:30:05.287011', '2023-08-07 08:30:09.005800'),
(285, 855, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 08:45:02.835650', '2023-08-07 08:45:09.822626'),
(286, 858, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 09:00:05.158546', '2023-08-07 09:00:10.646594'),
(287, 861, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 09:20:32.816653', '2023-08-07 09:20:42.843358'),
(288, 864, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 09:30:01.608356', '2023-08-07 09:30:03.887709'),
(289, 867, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 09:45:01.288141', '2023-08-07 09:45:04.759782'),
(290, 870, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 10:00:01.251661', '2023-08-07 10:00:05.550266'),
(291, 873, 'Succeeded', '{\"Type\":\"MISA.WebFresher052023.CTM.Application.IScheduleService, MISA.WebFresher052023.CTM.Application\",\"Method\":\"ClearFiles\",\"ParameterTypes\":\"[\\\"System.String\\\"]\",\"Arguments\":\"[\\\"\\\\\\\"C:\\\\\\\\\\\\\\\\Users\\\\\\\\\\\\\\\\thean\\\\\\\\\\\\\\\\OneDrive\\\\\\\\\\\\\\\\Desktop\\\\\\\\\\\\\\\\misa\\\\\\\\\\\\\\\\web202305\\\\\\\\\\\\\\\\mf1666-ttanh\\\\\\\\\\\\\\\\aspnetcore\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\\\\\\\\\client-files\\\\\\\"\\\"]\"}', '[\"\\\"C:\\\\\\\\Users\\\\\\\\thean\\\\\\\\OneDrive\\\\\\\\Desktop\\\\\\\\misa\\\\\\\\web202305\\\\\\\\mf1666-ttanh\\\\\\\\aspnetcore\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\MISA.WebFresher052023.CTM\\\\\\\\client-files\\\"\"]', '2023-08-06 10:15:02.929888', '2023-08-07 10:15:07.032681');

-- --------------------------------------------------------

--
-- Table structure for table `hangfirejobparameter`
--

CREATE TABLE `hangfirejobparameter` (
  `Id` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hangfirejobparameter`
--

INSERT INTO `hangfirejobparameter` (`Id`, `JobId`, `Name`, `Value`) VALUES
(977, 245, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(978, 245, 'Time', '1691232019'),
(979, 245, 'CurrentCulture', '\"en-US\"'),
(980, 245, 'CurrentUICulture', '\"en-US\"'),
(981, 246, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(982, 246, 'Time', '1691232650'),
(983, 246, 'CurrentCulture', '\"en-US\"'),
(984, 246, 'CurrentUICulture', '\"en-US\"'),
(985, 247, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(986, 247, 'Time', '1691233211'),
(987, 247, 'CurrentCulture', '\"en-US\"'),
(988, 247, 'CurrentUICulture', '\"en-US\"'),
(989, 248, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(990, 248, 'Time', '1691234425'),
(991, 248, 'CurrentCulture', '\"en-US\"'),
(992, 248, 'CurrentUICulture', '\"en-US\"'),
(993, 249, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(994, 249, 'Time', '1691235004'),
(995, 249, 'CurrentCulture', '\"en-US\"'),
(996, 249, 'CurrentUICulture', '\"en-US\"'),
(997, 250, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(998, 250, 'Time', '1691235908'),
(999, 250, 'CurrentCulture', '\"en-US\"'),
(1000, 250, 'CurrentUICulture', '\"en-US\"'),
(1001, 251, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1002, 251, 'Time', '1691236869'),
(1003, 251, 'CurrentCulture', '\"en-US\"'),
(1004, 251, 'CurrentUICulture', '\"en-US\"'),
(1005, 252, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1006, 252, 'Time', '1691244193'),
(1007, 252, 'CurrentCulture', '\"en-US\"'),
(1008, 252, 'CurrentUICulture', '\"en-US\"'),
(1009, 253, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1010, 253, 'Time', '1691244929'),
(1011, 253, 'CurrentCulture', '\"en-US\"'),
(1012, 253, 'CurrentUICulture', '\"en-US\"'),
(1013, 254, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1014, 254, 'Time', '1691245830'),
(1015, 254, 'CurrentCulture', '\"en-US\"'),
(1016, 254, 'CurrentUICulture', '\"en-US\"'),
(1017, 255, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1018, 255, 'Time', '1691246731'),
(1019, 255, 'CurrentCulture', '\"en-US\"'),
(1020, 255, 'CurrentUICulture', '\"en-US\"'),
(1021, 256, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1022, 256, 'Time', '1691247617'),
(1023, 256, 'CurrentCulture', '\"en-US\"'),
(1024, 256, 'CurrentUICulture', '\"en-US\"'),
(1025, 257, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1026, 257, 'Time', '1691248518'),
(1027, 257, 'CurrentCulture', '\"en-US\"'),
(1028, 257, 'CurrentUICulture', '\"en-US\"'),
(1029, 258, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1030, 258, 'Time', '1691249415'),
(1031, 258, 'CurrentCulture', '\"en-US\"'),
(1032, 258, 'CurrentUICulture', '\"en-US\"'),
(1033, 259, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1034, 259, 'Time', '1691280283'),
(1035, 259, 'CurrentCulture', '\"en-US\"'),
(1036, 259, 'CurrentUICulture', '\"en-US\"'),
(1037, 260, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1038, 260, 'Time', '1691280904'),
(1039, 260, 'CurrentCulture', '\"en-US\"'),
(1040, 260, 'CurrentUICulture', '\"en-US\"'),
(1041, 261, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1042, 261, 'Time', '1691281805'),
(1043, 261, 'CurrentCulture', '\"en-US\"'),
(1044, 261, 'CurrentUICulture', '\"en-US\"'),
(1045, 262, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1046, 262, 'Time', '1691282704'),
(1047, 262, 'CurrentCulture', '\"en-US\"'),
(1048, 262, 'CurrentUICulture', '\"en-US\"'),
(1049, 263, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1050, 263, 'Time', '1691283602'),
(1051, 263, 'CurrentCulture', '\"en-US\"'),
(1052, 263, 'CurrentUICulture', '\"en-US\"'),
(1053, 264, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1054, 264, 'Time', '1691284501'),
(1055, 264, 'CurrentCulture', '\"en-US\"'),
(1056, 264, 'CurrentUICulture', '\"en-US\"'),
(1057, 265, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1058, 265, 'Time', '1691285402'),
(1059, 265, 'CurrentCulture', '\"en-US\"'),
(1060, 265, 'CurrentUICulture', '\"en-US\"'),
(1061, 266, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1062, 266, 'Time', '1691286312'),
(1063, 266, 'CurrentCulture', '\"en-US\"'),
(1064, 266, 'CurrentUICulture', '\"en-US\"'),
(1065, 267, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1066, 267, 'Time', '1691287203'),
(1067, 267, 'CurrentCulture', '\"en-US\"'),
(1068, 267, 'CurrentUICulture', '\"en-US\"'),
(1069, 268, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1070, 268, 'Time', '1691288112'),
(1071, 268, 'CurrentCulture', '\"en-US\"'),
(1072, 268, 'CurrentUICulture', '\"en-US\"'),
(1073, 269, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1074, 269, 'Time', '1691289004'),
(1075, 269, 'CurrentCulture', '\"en-US\"'),
(1076, 269, 'CurrentUICulture', '\"en-US\"'),
(1077, 270, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1078, 270, 'Time', '1691289904'),
(1079, 270, 'CurrentCulture', '\"en-US\"'),
(1080, 270, 'CurrentUICulture', '\"en-US\"'),
(1081, 271, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1082, 271, 'Time', '1691290809'),
(1083, 271, 'CurrentCulture', '\"en-US\"'),
(1084, 271, 'CurrentUICulture', '\"en-US\"'),
(1085, 272, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1086, 272, 'Time', '1691291707'),
(1087, 272, 'CurrentCulture', '\"en-US\"'),
(1088, 272, 'CurrentUICulture', '\"en-US\"'),
(1089, 273, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1090, 273, 'Time', '1691292607'),
(1091, 273, 'CurrentCulture', '\"en-US\"'),
(1092, 273, 'CurrentUICulture', '\"en-US\"'),
(1093, 274, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1094, 274, 'Time', '1691293506'),
(1095, 274, 'CurrentCulture', '\"en-US\"'),
(1096, 274, 'CurrentUICulture', '\"en-US\"'),
(1097, 275, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1098, 275, 'Time', '1691294467'),
(1099, 275, 'CurrentCulture', '\"en-US\"'),
(1100, 275, 'CurrentUICulture', '\"en-US\"'),
(1101, 276, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1102, 276, 'Time', '1691295368'),
(1103, 276, 'CurrentCulture', '\"en-US\"'),
(1104, 276, 'CurrentUICulture', '\"en-US\"'),
(1105, 277, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1106, 277, 'Time', '1691304597'),
(1107, 277, 'CurrentCulture', '\"en-US\"'),
(1108, 277, 'CurrentUICulture', '\"en-US\"'),
(1109, 278, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1110, 278, 'Time', '1691305219'),
(1111, 278, 'CurrentCulture', '\"en-US\"'),
(1112, 278, 'CurrentUICulture', '\"en-US\"'),
(1113, 279, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1114, 279, 'Time', '1691306120'),
(1115, 279, 'CurrentCulture', '\"en-US\"'),
(1116, 279, 'CurrentUICulture', '\"en-US\"'),
(1117, 280, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1118, 280, 'Time', '1691307020'),
(1119, 280, 'CurrentCulture', '\"en-US\"'),
(1120, 280, 'CurrentUICulture', '\"en-US\"'),
(1121, 281, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1122, 281, 'Time', '1691307906'),
(1123, 281, 'CurrentCulture', '\"en-US\"'),
(1124, 281, 'CurrentUICulture', '\"en-US\"'),
(1125, 282, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1126, 282, 'Time', '1691308807'),
(1127, 282, 'CurrentCulture', '\"en-US\"'),
(1128, 282, 'CurrentUICulture', '\"en-US\"'),
(1129, 283, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1130, 283, 'Time', '1691309708'),
(1131, 283, 'CurrentCulture', '\"en-US\"'),
(1132, 283, 'CurrentUICulture', '\"en-US\"'),
(1133, 284, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1134, 284, 'Time', '1691310605'),
(1135, 284, 'CurrentCulture', '\"en-US\"'),
(1136, 284, 'CurrentUICulture', '\"en-US\"'),
(1137, 285, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1138, 285, 'Time', '1691311502'),
(1139, 285, 'CurrentCulture', '\"en-US\"'),
(1140, 285, 'CurrentUICulture', '\"en-US\"'),
(1141, 286, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1142, 286, 'Time', '1691312405'),
(1143, 286, 'CurrentCulture', '\"en-US\"'),
(1144, 286, 'CurrentUICulture', '\"en-US\"'),
(1145, 287, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1146, 287, 'Time', '1691313632'),
(1147, 287, 'CurrentCulture', '\"en-US\"'),
(1148, 287, 'CurrentUICulture', '\"en-US\"'),
(1149, 288, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1150, 288, 'Time', '1691314201'),
(1151, 288, 'CurrentCulture', '\"en-US\"'),
(1152, 288, 'CurrentUICulture', '\"en-US\"'),
(1153, 289, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1154, 289, 'Time', '1691315101'),
(1155, 289, 'CurrentCulture', '\"en-US\"'),
(1156, 289, 'CurrentUICulture', '\"en-US\"'),
(1157, 290, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1158, 290, 'Time', '1691316001'),
(1159, 290, 'CurrentCulture', '\"en-US\"'),
(1160, 290, 'CurrentUICulture', '\"en-US\"'),
(1161, 291, 'RecurringJobId', '\"IScheduleService.ClearFiles\"'),
(1162, 291, 'Time', '1691316902'),
(1163, 291, 'CurrentCulture', '\"en-US\"'),
(1164, 291, 'CurrentUICulture', '\"en-US\"');

-- --------------------------------------------------------

--
-- Table structure for table `hangfirejobqueue`
--

CREATE TABLE `hangfirejobqueue` (
  `Id` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `FetchedAt` datetime(6) DEFAULT NULL,
  `Queue` varchar(50) NOT NULL,
  `FetchToken` varchar(36) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hangfirejobstate`
--

CREATE TABLE `hangfirejobstate` (
  `Id` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Reason` varchar(100) DEFAULT NULL,
  `Data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hangfirelist`
--

CREATE TABLE `hangfirelist` (
  `Id` int(11) NOT NULL,
  `Key` varchar(100) NOT NULL,
  `Value` longtext DEFAULT NULL,
  `ExpireAt` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hangfireserver`
--

CREATE TABLE `hangfireserver` (
  `Id` varchar(100) NOT NULL,
  `Data` longtext NOT NULL,
  `LastHeartbeat` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hangfireserver`
--

INSERT INTO `hangfireserver` (`Id`, `Data`, `LastHeartbeat`) VALUES
('trtheanh:18480:7eb10850-56dc-463b-813f-d626583ed6dc', '{\"WorkerCount\":20,\"Queues\":[\"default\"],\"StartedAt\":\"2023-08-06T09:20:32.5931158Z\"}', '2023-08-06 10:16:34.406548');

-- --------------------------------------------------------

--
-- Table structure for table `hangfireset`
--

CREATE TABLE `hangfireset` (
  `Id` int(11) NOT NULL,
  `Key` varchar(100) NOT NULL,
  `Value` varchar(256) NOT NULL,
  `Score` float NOT NULL,
  `ExpireAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hangfireset`
--

INSERT INTO `hangfireset` (`Id`, `Key`, `Value`, `Score`, `ExpireAt`) VALUES
(1, 'recurring-jobs', 'IScheduleService.ClearFiles', 1691320000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hangfirestate`
--

CREATE TABLE `hangfirestate` (
  `Id` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Reason` varchar(100) DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `Data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `hangfirestate`
--

INSERT INTO `hangfirestate` (`Id`, `JobId`, `Name`, `Reason`, `CreatedAt`, `Data`) VALUES
(733, 245, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 10:40:19.864606', '{\"EnqueuedAt\":\"2023-08-05T10:40:19.8621142Z\",\"Queue\":\"default\"}'),
(734, 245, 'Processing', NULL, '2023-08-05 10:40:40.107951', '{\"StartedAt\":\"2023-08-05T10:40:40.1041913Z\",\"ServerId\":\"trtheanh:15824:f31991f9-7207-4d9f-95be-388f79046b2c\",\"WorkerId\":\"b37f107f-7e4e-45c0-92d9-6c917368b404\"}'),
(735, 245, 'Succeeded', NULL, '2023-08-05 10:40:40.120243', '{\"SucceededAt\":\"2023-08-05T10:40:40.1160633Z\",\"PerformanceDuration\":\"3\",\"Latency\":\"20265\"}'),
(736, 246, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 10:50:50.425137', '{\"EnqueuedAt\":\"2023-08-05T10:50:50.4242057Z\",\"Queue\":\"default\"}'),
(737, 246, 'Processing', NULL, '2023-08-05 10:50:50.577017', '{\"StartedAt\":\"2023-08-05T10:50:50.5743742Z\",\"ServerId\":\"trtheanh:15824:f31991f9-7207-4d9f-95be-388f79046b2c\",\"WorkerId\":\"eef4f13e-385e-4b68-a08a-e4ee6c3ce2da\"}'),
(738, 246, 'Succeeded', NULL, '2023-08-05 10:50:50.586643', '{\"SucceededAt\":\"2023-08-05T10:50:50.5818533Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"164\"}'),
(739, 247, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 11:00:11.534469', '{\"EnqueuedAt\":\"2023-08-05T11:00:11.5339420Z\",\"Queue\":\"default\"}'),
(740, 247, 'Processing', NULL, '2023-08-05 11:00:13.084402', '{\"StartedAt\":\"2023-08-05T11:00:13.0799584Z\",\"ServerId\":\"trtheanh:15824:f31991f9-7207-4d9f-95be-388f79046b2c\",\"WorkerId\":\"def45da9-3f4d-4f9b-8414-b3a419dde514\"}'),
(741, 247, 'Succeeded', NULL, '2023-08-05 11:00:13.099906', '{\"SucceededAt\":\"2023-08-05T11:00:13.0935671Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"1572\"}'),
(742, 248, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 11:20:25.838508', '{\"EnqueuedAt\":\"2023-08-05T11:20:25.8174795Z\",\"Queue\":\"default\"}'),
(743, 248, 'Processing', NULL, '2023-08-05 11:20:35.742899', '{\"StartedAt\":\"2023-08-05T11:20:35.7307074Z\",\"ServerId\":\"trtheanh:19524:b3f591d1-174a-411a-9bb2-36ffb4cfc2ab\",\"WorkerId\":\"f6985fdf-ba88-4142-a54a-fcfa21f66eb1\"}'),
(744, 248, 'Succeeded', NULL, '2023-08-05 11:20:35.777977', '{\"SucceededAt\":\"2023-08-05T11:20:35.7645288Z\",\"PerformanceDuration\":\"15\",\"Latency\":\"9952\"}'),
(745, 249, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 11:30:04.216073', '{\"EnqueuedAt\":\"2023-08-05T11:30:04.2030156Z\",\"Queue\":\"default\"}'),
(746, 249, 'Processing', NULL, '2023-08-05 11:30:12.829420', '{\"StartedAt\":\"2023-08-05T11:30:12.8189556Z\",\"ServerId\":\"trtheanh:28336:16e816c1-79db-4542-b4d9-c76d15ec2ce7\",\"WorkerId\":\"2e6ce5aa-1e82-4bf6-93e2-090b0de9ebe6\"}'),
(747, 249, 'Succeeded', NULL, '2023-08-05 11:30:12.872474', '{\"SucceededAt\":\"2023-08-05T11:30:12.8549173Z\",\"PerformanceDuration\":\"13\",\"Latency\":\"8681\"}'),
(748, 250, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 11:45:08.721120', '{\"EnqueuedAt\":\"2023-08-05T11:45:08.7204751Z\",\"Queue\":\"default\"}'),
(749, 250, 'Processing', NULL, '2023-08-05 11:45:14.009322', '{\"StartedAt\":\"2023-08-05T11:45:14.0039516Z\",\"ServerId\":\"trtheanh:28336:16e816c1-79db-4542-b4d9-c76d15ec2ce7\",\"WorkerId\":\"10304930-7882-4b7d-8cc4-697421bfb994\"}'),
(750, 250, 'Succeeded', NULL, '2023-08-05 11:45:14.025269', '{\"SucceededAt\":\"2023-08-05T11:45:14.0193637Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"5312\"}'),
(751, 251, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 12:01:09.794924', '{\"EnqueuedAt\":\"2023-08-05T12:01:09.7943353Z\",\"Queue\":\"default\"}'),
(752, 251, 'Processing', NULL, '2023-08-05 12:01:14.950490', '{\"StartedAt\":\"2023-08-05T12:01:14.9475653Z\",\"ServerId\":\"trtheanh:28336:16e816c1-79db-4542-b4d9-c76d15ec2ce7\",\"WorkerId\":\"548d1235-4770-4ae4-a373-c08acc6509a3\"}'),
(753, 251, 'Succeeded', NULL, '2023-08-05 12:01:14.961832', '{\"SucceededAt\":\"2023-08-05T12:01:14.9570204Z\",\"PerformanceDuration\":\"3\",\"Latency\":\"5167\"}'),
(754, 252, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 14:03:13.792343', '{\"EnqueuedAt\":\"2023-08-05T14:03:13.7704641Z\",\"Queue\":\"default\"}'),
(755, 252, 'Processing', NULL, '2023-08-05 14:03:23.761499', '{\"StartedAt\":\"2023-08-05T14:03:23.7510827Z\",\"ServerId\":\"trtheanh:25012:29616a7b-8b85-41ad-b72a-70fa9bb2cdb0\",\"WorkerId\":\"5da68d3d-fc30-4a50-b0d0-bb6f949c72fa\"}'),
(756, 252, 'Succeeded', NULL, '2023-08-05 14:03:23.788706', '{\"SucceededAt\":\"2023-08-05T14:03:23.7770653Z\",\"PerformanceDuration\":\"9\",\"Latency\":\"10015\"}'),
(757, 253, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 14:15:29.466980', '{\"EnqueuedAt\":\"2023-08-05T14:15:29.4659638Z\",\"Queue\":\"default\"}'),
(758, 253, 'Processing', NULL, '2023-08-05 14:15:34.469736', '{\"StartedAt\":\"2023-08-05T14:15:34.4662799Z\",\"ServerId\":\"trtheanh:25012:29616a7b-8b85-41ad-b72a-70fa9bb2cdb0\",\"WorkerId\":\"ccc3dad9-7640-450e-b31b-46c62d38e459\"}'),
(759, 253, 'Succeeded', NULL, '2023-08-05 14:15:34.480582', '{\"SucceededAt\":\"2023-08-05T14:15:34.4766077Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"5016\"}'),
(760, 254, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 14:30:30.389845', '{\"EnqueuedAt\":\"2023-08-05T14:30:30.3888609Z\",\"Queue\":\"default\"}'),
(761, 254, 'Processing', NULL, '2023-08-05 14:30:35.262539', '{\"StartedAt\":\"2023-08-05T14:30:35.2598761Z\",\"ServerId\":\"trtheanh:25012:29616a7b-8b85-41ad-b72a-70fa9bb2cdb0\",\"WorkerId\":\"3c16de05-e96e-4046-bcdc-2dc8a140a161\"}'),
(762, 254, 'Succeeded', NULL, '2023-08-05 14:30:35.277497', '{\"SucceededAt\":\"2023-08-05T14:30:35.2721500Z\",\"PerformanceDuration\":\"3\",\"Latency\":\"4888\"}'),
(763, 255, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 14:45:31.297606', '{\"EnqueuedAt\":\"2023-08-05T14:45:31.2968737Z\",\"Queue\":\"default\"}'),
(764, 255, 'Processing', NULL, '2023-08-05 14:45:36.005919', '{\"StartedAt\":\"2023-08-05T14:45:36.0032934Z\",\"ServerId\":\"trtheanh:25012:29616a7b-8b85-41ad-b72a-70fa9bb2cdb0\",\"WorkerId\":\"90d4caf2-c9fb-4846-86c8-02ecad267d15\"}'),
(765, 255, 'Succeeded', NULL, '2023-08-05 14:45:36.018130', '{\"SucceededAt\":\"2023-08-05T14:45:36.0127765Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"4723\"}'),
(766, 256, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 15:00:17.231923', '{\"EnqueuedAt\":\"2023-08-05T15:00:17.2312710Z\",\"Queue\":\"default\"}'),
(767, 256, 'Processing', NULL, '2023-08-05 15:00:26.798513', '{\"StartedAt\":\"2023-08-05T15:00:26.7947477Z\",\"ServerId\":\"trtheanh:25012:29616a7b-8b85-41ad-b72a-70fa9bb2cdb0\",\"WorkerId\":\"00bd8d0a-6f44-4991-808e-9822250fe86e\"}'),
(768, 256, 'Succeeded', NULL, '2023-08-05 15:00:26.810679', '{\"SucceededAt\":\"2023-08-05T15:00:26.8062709Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"9580\"}'),
(769, 257, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 15:15:18.149522', '{\"EnqueuedAt\":\"2023-08-05T15:15:18.1489384Z\",\"Queue\":\"default\"}'),
(770, 257, 'Processing', NULL, '2023-08-05 15:15:27.636523', '{\"StartedAt\":\"2023-08-05T15:15:27.6342875Z\",\"ServerId\":\"trtheanh:25012:29616a7b-8b85-41ad-b72a-70fa9bb2cdb0\",\"WorkerId\":\"d85e812b-ea6a-4c07-a54e-5432cf7a07ff\"}'),
(771, 257, 'Succeeded', NULL, '2023-08-05 15:15:27.647515', '{\"SucceededAt\":\"2023-08-05T15:15:27.6427325Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"9501\"}'),
(772, 258, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-05 15:30:15.248070', '{\"EnqueuedAt\":\"2023-08-05T15:30:15.2333009Z\",\"Queue\":\"default\"}'),
(773, 258, 'Processing', NULL, '2023-08-05 15:30:20.169179', '{\"StartedAt\":\"2023-08-05T15:30:20.1604780Z\",\"ServerId\":\"trtheanh:13772:a811126b-be72-4c64-9575-bd9fa64f9462\",\"WorkerId\":\"c1ea4d7d-1ae5-4308-83fd-08118738517b\"}'),
(774, 258, 'Succeeded', NULL, '2023-08-05 15:30:20.194926', '{\"SucceededAt\":\"2023-08-05T15:30:20.1841920Z\",\"PerformanceDuration\":\"8\",\"Latency\":\"4958\"}'),
(775, 259, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 00:04:43.403963', '{\"EnqueuedAt\":\"2023-08-06T00:04:43.3866576Z\",\"Queue\":\"default\"}'),
(776, 259, 'Processing', NULL, '2023-08-06 00:04:53.373771', '{\"StartedAt\":\"2023-08-06T00:04:53.3649805Z\",\"ServerId\":\"trtheanh:27892:108b48dd-8dcd-46c5-9027-972f95755226\",\"WorkerId\":\"add5338f-e5f4-47f9-bbd1-f4237fbaf127\"}'),
(777, 259, 'Succeeded', NULL, '2023-08-06 00:04:53.401257', '{\"SucceededAt\":\"2023-08-06T00:04:53.3883823Z\",\"PerformanceDuration\":\"7\",\"Latency\":\"10009\"}'),
(778, 260, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 00:15:04.379297', '{\"EnqueuedAt\":\"2023-08-06T00:15:04.3787285Z\",\"Queue\":\"default\"}'),
(779, 260, 'Processing', NULL, '2023-08-06 00:15:13.909372', '{\"StartedAt\":\"2023-08-06T00:15:13.9061193Z\",\"ServerId\":\"trtheanh:27892:108b48dd-8dcd-46c5-9027-972f95755226\",\"WorkerId\":\"b1b898d9-387f-4257-819e-047f3afb7a52\"}'),
(780, 260, 'Succeeded', NULL, '2023-08-06 00:15:13.921050', '{\"SucceededAt\":\"2023-08-06T00:15:13.9154190Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"9544\"}'),
(781, 261, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 00:30:05.346706', '{\"EnqueuedAt\":\"2023-08-06T00:30:05.3457447Z\",\"Queue\":\"default\"}'),
(782, 261, 'Processing', NULL, '2023-08-06 00:30:05.785440', '{\"StartedAt\":\"2023-08-06T00:30:05.7820841Z\",\"ServerId\":\"trtheanh:27892:108b48dd-8dcd-46c5-9027-972f95755226\",\"WorkerId\":\"37c42f28-62a4-40d6-bc9d-21804d6a3a7e\"}'),
(783, 261, 'Succeeded', NULL, '2023-08-06 00:30:05.795806', '{\"SucceededAt\":\"2023-08-06T00:30:05.7916863Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"453\"}'),
(784, 262, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 00:45:04.278376', '{\"EnqueuedAt\":\"2023-08-06T00:45:04.2773722Z\",\"Queue\":\"default\"}'),
(785, 262, 'Processing', NULL, '2023-08-06 00:45:04.615668', '{\"StartedAt\":\"2023-08-06T00:45:04.6115506Z\",\"ServerId\":\"trtheanh:27892:108b48dd-8dcd-46c5-9027-972f95755226\",\"WorkerId\":\"8fbbb09d-07c2-428f-bab7-6471dc40f8a7\"}'),
(786, 262, 'Succeeded', NULL, '2023-08-06 00:45:04.634357', '{\"SucceededAt\":\"2023-08-06T00:45:04.6267641Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"356\"}'),
(787, 263, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 01:00:02.016332', '{\"EnqueuedAt\":\"2023-08-06T01:00:02.0157523Z\",\"Queue\":\"default\"}'),
(788, 263, 'Processing', NULL, '2023-08-06 01:00:02.357969', '{\"StartedAt\":\"2023-08-06T01:00:02.3541120Z\",\"ServerId\":\"trtheanh:27892:108b48dd-8dcd-46c5-9027-972f95755226\",\"WorkerId\":\"d8c71301-b3da-4ad0-9d6f-a9c64b55dd44\"}'),
(789, 263, 'Succeeded', NULL, '2023-08-06 01:00:02.372175', '{\"SucceededAt\":\"2023-08-06T01:00:02.3682156Z\",\"PerformanceDuration\":\"3\",\"Latency\":\"355\"}'),
(790, 264, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 01:15:01.299654', '{\"EnqueuedAt\":\"2023-08-06T01:15:01.2906572Z\",\"Queue\":\"default\"}'),
(791, 264, 'Processing', NULL, '2023-08-06 01:15:05.189742', '{\"StartedAt\":\"2023-08-06T01:15:05.1794720Z\",\"ServerId\":\"trtheanh:17016:7df0f650-c785-4984-838b-b944d1fe4773\",\"WorkerId\":\"cd5f3d4b-e264-4fd3-8144-d0af87d90f7a\"}'),
(792, 264, 'Succeeded', NULL, '2023-08-06 01:15:05.217002', '{\"SucceededAt\":\"2023-08-06T01:15:05.2055175Z\",\"PerformanceDuration\":\"9\",\"Latency\":\"3922\"}'),
(793, 265, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 01:30:02.937737', '{\"EnqueuedAt\":\"2023-08-06T01:30:02.9369838Z\",\"Queue\":\"default\"}'),
(794, 265, 'Processing', NULL, '2023-08-06 01:30:06.047663', '{\"StartedAt\":\"2023-08-06T01:30:06.0447839Z\",\"ServerId\":\"trtheanh:17016:7df0f650-c785-4984-838b-b944d1fe4773\",\"WorkerId\":\"125cf6e3-9577-43f5-9cb5-2eaf52c994a0\"}'),
(795, 265, 'Succeeded', NULL, '2023-08-06 01:30:06.058720', '{\"SucceededAt\":\"2023-08-06T01:30:06.0547713Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"3123\"}'),
(796, 266, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 01:45:12.397489', '{\"EnqueuedAt\":\"2023-08-06T01:45:12.3967821Z\",\"Queue\":\"default\"}'),
(797, 266, 'Processing', NULL, '2023-08-06 01:45:16.948698', '{\"StartedAt\":\"2023-08-06T01:45:16.9441243Z\",\"ServerId\":\"trtheanh:17016:7df0f650-c785-4984-838b-b944d1fe4773\",\"WorkerId\":\"4cd0b6c6-3682-475b-aba1-2be7b44032ee\"}'),
(798, 266, 'Succeeded', NULL, '2023-08-06 01:45:16.978928', '{\"SucceededAt\":\"2023-08-06T01:45:16.9729277Z\",\"PerformanceDuration\":\"6\",\"Latency\":\"4584\"}'),
(799, 267, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 02:00:03.332126', '{\"EnqueuedAt\":\"2023-08-06T02:00:03.3249957Z\",\"Queue\":\"default\"}'),
(800, 267, 'Processing', NULL, '2023-08-06 02:00:08.113704', '{\"StartedAt\":\"2023-08-06T02:00:08.1006622Z\",\"ServerId\":\"trtheanh:25556:ef046163-b267-4d4c-8010-13c5c65a8c3f\",\"WorkerId\":\"f0ff6821-e14b-442a-9a33-ea1a6fe9ba0b\"}'),
(801, 267, 'Succeeded', NULL, '2023-08-06 02:00:08.144323', '{\"SucceededAt\":\"2023-08-06T02:00:08.1336285Z\",\"PerformanceDuration\":\"8\",\"Latency\":\"4824\"}'),
(802, 268, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 02:15:12.210593', '{\"EnqueuedAt\":\"2023-08-06T02:15:12.2100473Z\",\"Queue\":\"default\"}'),
(803, 268, 'Processing', NULL, '2023-08-06 02:15:18.880616', '{\"StartedAt\":\"2023-08-06T02:15:18.8749251Z\",\"ServerId\":\"trtheanh:25556:ef046163-b267-4d4c-8010-13c5c65a8c3f\",\"WorkerId\":\"e5e67bb1-d0a9-41b3-9275-2f01c9f4d085\"}'),
(804, 268, 'Succeeded', NULL, '2023-08-06 02:15:18.900990', '{\"SucceededAt\":\"2023-08-06T02:15:18.8945371Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"6697\"}'),
(805, 269, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 02:30:04.899365', '{\"EnqueuedAt\":\"2023-08-06T02:30:04.8887575Z\",\"Queue\":\"default\"}'),
(806, 269, 'Processing', NULL, '2023-08-06 02:30:11.283030', '{\"StartedAt\":\"2023-08-06T02:30:11.2732400Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"40ba188c-397e-4b0a-93b5-19f0f50feff8\"}'),
(807, 269, 'Succeeded', NULL, '2023-08-06 02:30:11.321146', '{\"SucceededAt\":\"2023-08-06T02:30:11.3057803Z\",\"PerformanceDuration\":\"9\",\"Latency\":\"6432\"}'),
(808, 270, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 02:45:04.653306', '{\"EnqueuedAt\":\"2023-08-06T02:45:04.6525317Z\",\"Queue\":\"default\"}'),
(809, 270, 'Processing', NULL, '2023-08-06 02:45:12.058283', '{\"StartedAt\":\"2023-08-06T02:45:12.0546178Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"c003cd93-a66f-4c38-894e-f0eed2e4b625\"}'),
(810, 270, 'Succeeded', NULL, '2023-08-06 02:45:12.074359', '{\"SucceededAt\":\"2023-08-06T02:45:12.0688728Z\",\"PerformanceDuration\":\"3\",\"Latency\":\"7428\"}'),
(811, 271, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 03:00:09.075088', '{\"EnqueuedAt\":\"2023-08-06T03:00:09.0745041Z\",\"Queue\":\"default\"}'),
(812, 271, 'Processing', NULL, '2023-08-06 03:00:12.814669', '{\"StartedAt\":\"2023-08-06T03:00:12.8103020Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"c037f751-f673-4270-b754-668ebf85989c\"}'),
(813, 271, 'Succeeded', NULL, '2023-08-06 03:00:12.834561', '{\"SucceededAt\":\"2023-08-06T03:00:12.8283487Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"3765\"}'),
(814, 272, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 03:15:07.208660', '{\"EnqueuedAt\":\"2023-08-06T03:15:07.2079604Z\",\"Queue\":\"default\"}'),
(815, 272, 'Processing', NULL, '2023-08-06 03:15:13.532357', '{\"StartedAt\":\"2023-08-06T03:15:13.5270554Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"f06f22ed-3f0a-40d4-b5e8-e0bdf2807d51\"}'),
(816, 272, 'Succeeded', NULL, '2023-08-06 03:15:13.552492', '{\"SucceededAt\":\"2023-08-06T03:15:13.5463830Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"6351\"}'),
(817, 273, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 03:30:07.439987', '{\"EnqueuedAt\":\"2023-08-06T03:30:07.4393726Z\",\"Queue\":\"default\"}'),
(818, 273, 'Processing', NULL, '2023-08-06 03:30:14.298207', '{\"StartedAt\":\"2023-08-06T03:30:14.2944234Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"d522843c-9f69-462a-a937-1c0183769867\"}'),
(819, 273, 'Succeeded', NULL, '2023-08-06 03:30:14.317198', '{\"SucceededAt\":\"2023-08-06T03:30:14.3119678Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"6885\"}'),
(820, 274, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 03:45:06.395945', '{\"EnqueuedAt\":\"2023-08-06T03:45:06.3952435Z\",\"Queue\":\"default\"}'),
(821, 274, 'Processing', NULL, '2023-08-06 03:45:15.081626', '{\"StartedAt\":\"2023-08-06T03:45:15.0771372Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"08112bd2-b27e-492a-a09c-a5c8a3f81f92\"}'),
(822, 274, 'Succeeded', NULL, '2023-08-06 03:45:15.096925', '{\"SucceededAt\":\"2023-08-06T03:45:15.0914561Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"8709\"}'),
(823, 275, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 04:01:07.390786', '{\"EnqueuedAt\":\"2023-08-06T04:01:07.3903460Z\",\"Queue\":\"default\"}'),
(824, 275, 'Processing', NULL, '2023-08-06 04:01:15.918292', '{\"StartedAt\":\"2023-08-06T04:01:15.9154572Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"f06f22ed-3f0a-40d4-b5e8-e0bdf2807d51\"}'),
(825, 275, 'Succeeded', NULL, '2023-08-06 04:01:15.926771', '{\"SucceededAt\":\"2023-08-06T04:01:15.9229443Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"8538\"}'),
(826, 276, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 04:16:08.343428', '{\"EnqueuedAt\":\"2023-08-06T04:16:08.3429751Z\",\"Queue\":\"default\"}'),
(827, 276, 'Processing', NULL, '2023-08-06 04:16:16.710154', '{\"StartedAt\":\"2023-08-06T04:16:16.7077493Z\",\"ServerId\":\"trtheanh:7540:ddf35066-f353-4811-a91f-9a30ffd7caa7\",\"WorkerId\":\"f06f22ed-3f0a-40d4-b5e8-e0bdf2807d51\"}'),
(828, 276, 'Succeeded', NULL, '2023-08-06 04:16:16.718392', '{\"SucceededAt\":\"2023-08-06T04:16:16.7143435Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"8376\"}'),
(829, 277, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 06:49:57.937800', '{\"EnqueuedAt\":\"2023-08-06T06:49:57.9093510Z\",\"Queue\":\"default\"}'),
(830, 277, 'Processing', NULL, '2023-08-06 06:50:07.891191', '{\"StartedAt\":\"2023-08-06T06:50:07.8803901Z\",\"ServerId\":\"trtheanh:22168:011f32bd-dfb6-4a55-947b-e77e6da1455e\",\"WorkerId\":\"8fbb4f6d-abe9-41ca-8948-16c93f2ee744\"}'),
(831, 277, 'Succeeded', NULL, '2023-08-06 06:50:07.932179', '{\"SucceededAt\":\"2023-08-06T06:50:07.9171266Z\",\"PerformanceDuration\":\"18\",\"Latency\":\"10008\"}'),
(832, 278, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 07:00:19.203809', '{\"EnqueuedAt\":\"2023-08-06T07:00:19.1855137Z\",\"Queue\":\"default\"}'),
(833, 278, 'Processing', NULL, '2023-08-06 07:00:24.094816', '{\"StartedAt\":\"2023-08-06T07:00:24.0849648Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"ea6d3f1f-24a7-4a42-b28d-37850182ba97\"}'),
(834, 278, 'Succeeded', NULL, '2023-08-06 07:00:24.116020', '{\"SucceededAt\":\"2023-08-06T07:00:24.1074712Z\",\"PerformanceDuration\":\"7\",\"Latency\":\"4934\"}'),
(835, 279, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 07:15:20.021002', '{\"EnqueuedAt\":\"2023-08-06T07:15:20.0202953Z\",\"Queue\":\"default\"}'),
(836, 279, 'Processing', NULL, '2023-08-06 07:15:24.920509', '{\"StartedAt\":\"2023-08-06T07:15:24.9165190Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"60681e69-59e9-44b1-9dff-b5b0b2653e7f\"}'),
(837, 279, 'Succeeded', NULL, '2023-08-06 07:15:24.931882', '{\"SucceededAt\":\"2023-08-06T07:15:24.9272027Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"4913\"}'),
(838, 280, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 07:30:20.918098', '{\"EnqueuedAt\":\"2023-08-06T07:30:20.9173126Z\",\"Queue\":\"default\"}'),
(839, 280, 'Processing', NULL, '2023-08-06 07:30:25.717901', '{\"StartedAt\":\"2023-08-06T07:30:25.7144823Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"f4037386-c149-4ff9-8ac5-b80bbabb3639\"}'),
(840, 280, 'Succeeded', NULL, '2023-08-06 07:30:25.729573', '{\"SucceededAt\":\"2023-08-06T07:30:25.7251556Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"4815\"}'),
(841, 281, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 07:45:06.866314', '{\"EnqueuedAt\":\"2023-08-06T07:45:06.8657263Z\",\"Queue\":\"default\"}'),
(842, 281, 'Processing', NULL, '2023-08-06 07:45:16.510519', '{\"StartedAt\":\"2023-08-06T07:45:16.5076137Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"a2eeecf1-4a8f-41f2-a608-5993f09d96bf\"}'),
(843, 281, 'Succeeded', NULL, '2023-08-06 07:45:16.521038', '{\"SucceededAt\":\"2023-08-06T07:45:16.5164243Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"9658\"}'),
(844, 282, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 08:00:07.861451', '{\"EnqueuedAt\":\"2023-08-06T08:00:07.8607544Z\",\"Queue\":\"default\"}'),
(845, 282, 'Processing', NULL, '2023-08-06 08:00:17.390696', '{\"StartedAt\":\"2023-08-06T08:00:17.3871399Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"a2eeecf1-4a8f-41f2-a608-5993f09d96bf\"}'),
(846, 282, 'Succeeded', NULL, '2023-08-06 08:00:17.401003', '{\"SucceededAt\":\"2023-08-06T08:00:17.3965491Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"9542\"}'),
(847, 283, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 08:15:08.751308', '{\"EnqueuedAt\":\"2023-08-06T08:15:08.7505713Z\",\"Queue\":\"default\"}'),
(848, 283, 'Processing', NULL, '2023-08-06 08:15:18.167788', '{\"StartedAt\":\"2023-08-06T08:15:18.1650723Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"c814c5d6-d7cc-4b57-bb32-2c6ae585d0aa\"}'),
(849, 283, 'Succeeded', NULL, '2023-08-06 08:15:18.176895', '{\"SucceededAt\":\"2023-08-06T08:15:18.1727915Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"9428\"}'),
(850, 284, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 08:30:05.295768', '{\"EnqueuedAt\":\"2023-08-06T08:30:05.2951087Z\",\"Queue\":\"default\"}'),
(851, 284, 'Processing', NULL, '2023-08-06 08:30:08.991758', '{\"StartedAt\":\"2023-08-06T08:30:08.9894818Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"22730e86-38c2-4377-b1be-f8cbd2e0e89e\"}'),
(852, 284, 'Succeeded', NULL, '2023-08-06 08:30:09.003517', '{\"SucceededAt\":\"2023-08-06T08:30:08.9986769Z\",\"PerformanceDuration\":\"3\",\"Latency\":\"3707\"}'),
(853, 285, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 08:45:02.843318', '{\"EnqueuedAt\":\"2023-08-06T08:45:02.8427434Z\",\"Queue\":\"default\"}'),
(854, 285, 'Processing', NULL, '2023-08-06 08:45:09.812196', '{\"StartedAt\":\"2023-08-06T08:45:09.8099659Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"9f28e6a1-3622-4ca5-9734-6ad6fd22ee2f\"}'),
(855, 285, 'Succeeded', NULL, '2023-08-06 08:45:09.822052', '{\"SucceededAt\":\"2023-08-06T08:45:09.8187553Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"6982\"}'),
(856, 286, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 09:00:05.164773', '{\"EnqueuedAt\":\"2023-08-06T09:00:05.1642740Z\",\"Queue\":\"default\"}'),
(857, 286, 'Processing', NULL, '2023-08-06 09:00:10.633526', '{\"StartedAt\":\"2023-08-06T09:00:10.6174535Z\",\"ServerId\":\"trtheanh:27180:11e056e5-004e-44f5-a16e-c65c1d071701\",\"WorkerId\":\"a9dea6b9-e156-4124-ba8e-eb0ebc8f373a\"}'),
(858, 286, 'Succeeded', NULL, '2023-08-06 09:00:10.644394', '{\"SucceededAt\":\"2023-08-06T09:00:10.6394933Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"5479\"}'),
(859, 287, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 09:20:32.875782', '{\"EnqueuedAt\":\"2023-08-06T09:20:32.8376902Z\",\"Queue\":\"default\"}'),
(860, 287, 'Processing', NULL, '2023-08-06 09:20:42.805879', '{\"StartedAt\":\"2023-08-06T09:20:42.7968707Z\",\"ServerId\":\"trtheanh:18480:7eb10850-56dc-463b-813f-d626583ed6dc\",\"WorkerId\":\"c0b0cc1d-36ce-4984-82ae-e4cad2672421\"}'),
(861, 287, 'Succeeded', NULL, '2023-08-06 09:20:42.839489', '{\"SucceededAt\":\"2023-08-06T09:20:42.8257277Z\",\"PerformanceDuration\":\"13\",\"Latency\":\"9995\"}'),
(862, 288, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 09:30:01.616633', '{\"EnqueuedAt\":\"2023-08-06T09:30:01.6159373Z\",\"Queue\":\"default\"}'),
(863, 288, 'Processing', NULL, '2023-08-06 09:30:03.871044', '{\"StartedAt\":\"2023-08-06T09:30:03.8683574Z\",\"ServerId\":\"trtheanh:18480:7eb10850-56dc-463b-813f-d626583ed6dc\",\"WorkerId\":\"d4abc796-557d-4523-a2c1-d75a27a75d8d\"}'),
(864, 288, 'Succeeded', NULL, '2023-08-06 09:30:03.886519', '{\"SucceededAt\":\"2023-08-06T09:30:03.8807740Z\",\"PerformanceDuration\":\"4\",\"Latency\":\"2267\"}'),
(865, 289, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 09:45:01.303801', '{\"EnqueuedAt\":\"2023-08-06T09:45:01.3028120Z\",\"Queue\":\"default\"}'),
(866, 289, 'Processing', NULL, '2023-08-06 09:45:04.733399', '{\"StartedAt\":\"2023-08-06T09:45:04.7288868Z\",\"ServerId\":\"trtheanh:18480:7eb10850-56dc-463b-813f-d626583ed6dc\",\"WorkerId\":\"a5c900b1-2df1-4e74-94dd-2ef3277bb434\"}'),
(867, 289, 'Succeeded', NULL, '2023-08-06 09:45:04.753323', '{\"SucceededAt\":\"2023-08-06T09:45:04.7444324Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"3453\"}'),
(868, 290, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 10:00:01.268599', '{\"EnqueuedAt\":\"2023-08-06T10:00:01.2680974Z\",\"Queue\":\"default\"}'),
(869, 290, 'Processing', NULL, '2023-08-06 10:00:05.517978', '{\"StartedAt\":\"2023-08-06T10:00:05.5119007Z\",\"ServerId\":\"trtheanh:18480:7eb10850-56dc-463b-813f-d626583ed6dc\",\"WorkerId\":\"51dbf3c6-bb0c-462b-b602-4b8b71a05006\"}'),
(870, 290, 'Succeeded', NULL, '2023-08-06 10:00:05.539405', '{\"SucceededAt\":\"2023-08-06T10:00:05.5305193Z\",\"PerformanceDuration\":\"2\",\"Latency\":\"4276\"}'),
(871, 291, 'Enqueued', 'Triggered by recurring job scheduler', '2023-08-06 10:15:02.945379', '{\"EnqueuedAt\":\"2023-08-06T10:15:02.9446210Z\",\"Queue\":\"default\"}'),
(872, 291, 'Processing', NULL, '2023-08-06 10:15:07.015372', '{\"StartedAt\":\"2023-08-06T10:15:07.0112393Z\",\"ServerId\":\"trtheanh:18480:7eb10850-56dc-463b-813f-d626583ed6dc\",\"WorkerId\":\"51dbf3c6-bb0c-462b-b602-4b8b71a05006\"}'),
(873, 291, 'Succeeded', NULL, '2023-08-06 10:15:07.032140', '{\"SucceededAt\":\"2023-08-06T10:15:07.0258327Z\",\"PerformanceDuration\":\"1\",\"Latency\":\"4094\"}');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DepartmentId`),
  ADD UNIQUE KEY `UK_department_DepartmentCode` (`DepartmentCode`),
  ADD KEY `IDX_department_DepartmentName` (`DepartmentName`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmployeeId`),
  ADD UNIQUE KEY `UK_employee_EmployeeCode` (`EmployeeCode`),
  ADD KEY `FK_employee_DepartmentId` (`DepartmentId`),
  ADD KEY `IDX_employee_EmployeeName` (`FullName`);

--
-- Indexes for table `employeelayout`
--
ALTER TABLE `employeelayout`
  ADD PRIMARY KEY (`EmployeeLayoutId`),
  ADD UNIQUE KEY `UK_EmployeeLayout_EmployeeLayoutId` (`EmployeeLayoutId`);

--
-- Indexes for table `hangfireaggregatedcounter`
--
ALTER TABLE `hangfireaggregatedcounter`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_HangfireCounterAggregated_Key` (`Key`);

--
-- Indexes for table `hangfirecounter`
--
ALTER TABLE `hangfirecounter`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_HangfireCounter_Key` (`Key`);

--
-- Indexes for table `hangfirehash`
--
ALTER TABLE `hangfirehash`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_HangfireHash_Key_Field` (`Key`,`Field`);

--
-- Indexes for table `hangfirejob`
--
ALTER TABLE `hangfirejob`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_HangfireJob_StateName` (`StateName`);

--
-- Indexes for table `hangfirejobparameter`
--
ALTER TABLE `hangfirejobparameter`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_HangfireJobParameter_JobId_Name` (`JobId`,`Name`),
  ADD KEY `FK_HangfireJobParameter_Job` (`JobId`);

--
-- Indexes for table `hangfirejobqueue`
--
ALTER TABLE `hangfirejobqueue`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_HangfireJobQueue_QueueAndFetchedAt` (`Queue`,`FetchedAt`);

--
-- Indexes for table `hangfirejobstate`
--
ALTER TABLE `hangfirejobstate`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `FK_HangfireJobState_Job` (`JobId`);

--
-- Indexes for table `hangfirelist`
--
ALTER TABLE `hangfirelist`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `hangfireserver`
--
ALTER TABLE `hangfireserver`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `hangfireset`
--
ALTER TABLE `hangfireset`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_HangfireSet_Key_Value` (`Key`,`Value`);

--
-- Indexes for table `hangfirestate`
--
ALTER TABLE `hangfirestate`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `FK_HangfireHangFire_State_Job` (`JobId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hangfireaggregatedcounter`
--
ALTER TABLE `hangfireaggregatedcounter`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=317;

--
-- AUTO_INCREMENT for table `hangfirecounter`
--
ALTER TABLE `hangfirecounter`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=874;

--
-- AUTO_INCREMENT for table `hangfirehash`
--
ALTER TABLE `hangfirehash`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=884;

--
-- AUTO_INCREMENT for table `hangfirejob`
--
ALTER TABLE `hangfirejob`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=292;

--
-- AUTO_INCREMENT for table `hangfirejobparameter`
--
ALTER TABLE `hangfirejobparameter`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1165;

--
-- AUTO_INCREMENT for table `hangfirejobqueue`
--
ALTER TABLE `hangfirejobqueue`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=292;

--
-- AUTO_INCREMENT for table `hangfirejobstate`
--
ALTER TABLE `hangfirejobstate`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hangfirelist`
--
ALTER TABLE `hangfirelist`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hangfireset`
--
ALTER TABLE `hangfireset`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=456751;

--
-- AUTO_INCREMENT for table `hangfirestate`
--
ALTER TABLE `hangfirestate`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=874;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `FK_employee_DepartmentId` FOREIGN KEY (`DepartmentId`) REFERENCES `department` (`DepartmentId`) ON DELETE NO ACTION;

--
-- Constraints for table `hangfirejobparameter`
--
ALTER TABLE `hangfirejobparameter`
  ADD CONSTRAINT `FK_HangfireJobParameter_Job` FOREIGN KEY (`JobId`) REFERENCES `hangfirejob` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hangfirejobstate`
--
ALTER TABLE `hangfirejobstate`
  ADD CONSTRAINT `FK_HangfireJobState_Job` FOREIGN KEY (`JobId`) REFERENCES `hangfirejob` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hangfirestate`
--
ALTER TABLE `hangfirestate`
  ADD CONSTRAINT `FK_HangfireHangFire_State_Job` FOREIGN KEY (`JobId`) REFERENCES `hangfirejob` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
