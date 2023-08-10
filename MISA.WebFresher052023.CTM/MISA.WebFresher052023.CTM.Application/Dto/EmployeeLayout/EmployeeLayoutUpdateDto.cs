using MISA.WebFresher052023.CTM.Domain;
using System.ComponentModel.DataAnnotations;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Dto cập nhật 1 cột hiển thị 1 thông tin cột nhân viên
    /// </summary>
    public class EmployeeLayoutUpdateDto
    {
        #region Properties
        /// <summary>
        /// Khóa chính theo Guid.
        /// </summary>
        [Required]
        public Guid EmployeeLayoutId { get; set; }

        /// <summary>
        /// Tên cột hiển thị trên màn hình bằng tiếng việt
        /// </summary>
        [Required]
        [StringLength(255)]
        public string viClientColumnName { get; set; }

        /// <summary>
        /// Tên cột hiển thị trên màn hình bằng tiếng anh
        /// </summary>
        [Required]
        [StringLength(255)]
        public string enClientColumnName { get; set; }

        /// <summary>
        /// Kích thước cột hiển thị trên màn hình.
        /// </summary>
        [Required]
        public int ColumnWidth{ get; set; }
        
        /// <summary>
        /// Xác định xem cột này có được hiển thị không.
        /// </summary>
        [Required]
        public bool ColumnIsShow{ get; set; }

        /// <summary>
        /// Xác định xem cột có được ghim không.
        /// </summary>
        [Required]
        public bool ColumnIsPin{ get; set; }

        /// <summary>
        /// Xác định số thứ tự của cột.
        /// </summary>
        [Required]
        public int OrderNumber{ get; set; }
        #endregion
    }
}
