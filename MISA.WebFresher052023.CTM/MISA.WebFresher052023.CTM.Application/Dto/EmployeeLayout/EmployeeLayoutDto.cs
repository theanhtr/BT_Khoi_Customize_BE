using MISA.WebFresher052023.CTM.Domain;
using System.ComponentModel.DataAnnotations;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Dto trả về của thông tin cột nhân viên
    /// </summary>
    public class EmployeeLayoutDto : ILayoutGetInfo
    {
        #region Property
        /// <summary>
        /// Khóa chính theo Guid.
        /// </summary>
        public Guid EmployeeLayoutId { get; set; }

        /// <summary>
        /// Tên của cột trên server để lấy dữ liệu từ api.
        /// </summary>
        [Required]
        [StringLength(255)]
        public string ServerColumnName { get; set; }

        /// <summary>
        /// Tooltip của cột bằng tiếng việt
        /// </summary>
        [Required]
        [StringLength(255)]
        public string viTooltip { get; set; }

        /// <summary>
        /// Tên cột hiển thị trên màn hình bằng tiếng việt
        /// </summary>
        [Required]
        [StringLength(255)]
        public string viClientColumnName { get; set; }

        /// <summary>
        /// Tên cột hiển thị trên màn hình mặc định bằng tiếng việt
        /// </summary>
        [Required]
        [StringLength(255)]
        public string viClientColumnNameDefault { get; set; }

        /// <summary>
        /// Tooltip của cột bằng tiếng anh
        /// </summary>
        [Required]
        [StringLength(255)]
        public string enTooltip { get; set; }

        /// <summary>
        /// Tên cột hiển thị trên màn hình bằng tiếng anh
        /// </summary>
        [Required]
        [StringLength(255)]
        public string enClientColumnName { get; set; }

        /// <summary>
        /// Tên cột hiển thị trên màn hình mặc định bằng tiếng anh
        /// </summary>
        [Required]
        [StringLength(255)]
        public string enClientColumnNameDefault { get; set; }

        /// <summary>
        /// Kích thước cột hiển thị trên màn hình.
        /// </summary>
        [Required]
        public int ColumnWidth{ get; set; }

        /// <summary>
        /// Kích thước cột hiển thị trên màn hình mặc định
        /// </summary>
        [Required]
        public int ColumnWidthDefault{ get; set; }


        /// <summary>
        /// Loại căn giữa của cột hiển thị trên màn hình (center - căn giữa{ get; set; } left - căn trái{ get; set; } right - căn phải)
        /// </summary>
        [Required]
        public string ColumnTextAlign{ get; set; }

        /// <summary>
        /// Loại format của các phần tử trong cột (text - chữ{ get; set; } date - ngày tháng{ get; set; } currency - tiền tệ)
        /// </summary>
        [Required]
        public string ColumnFormat{ get; set; }

        /// <summary>
        /// Xác định xem cột này có được hiển thị không.
        /// </summary>
        [Required]
        public bool ColumnIsShow{ get; set; }

        /// <summary>
        /// Xác định xem cột này có được hiển thị không mặc định.
        /// </summary>
        [Required]
        public bool ColumnIsShowDefault{ get; set; }

        /// <summary>
        /// Xác định xem cột có được ghim không.
        /// </summary>
        [Required]
        public bool ColumnIsPin{ get; set; }

        /// <summary>
        /// Xác định xem cột có được ghim không mặc định.
        /// </summary>
        [Required]
        public bool ColumnIsPinDefault{ get; set; }

        /// <summary>
        /// Xác định số thứ tự của cột.
        /// </summary>
        [Required]
        public int OrderNumber{ get; set; }

        /// <summary>
        /// Xác định số thứ tự của cột mặc định.
        /// </summary>
        [Required]
        public int OrderNumberDefault{ get; set; }
        #endregion

        #region Methods
        /// <summary>
        /// Lấy ra tên cột trong server
        /// </summary>
        /// CreatedBy: TTANH (02/08/2023)
        public string GetServerColumnName()
        {
            return ServerColumnName;
        }

        /// <summary>
        /// Lấy ra tên cột hiển thị của người dùng bằng tiếng anh
        /// </summary>
        /// CreatedBy: TTANH (06/08/2023)
        public string GetClientColumnName(string langCode)
        {
            if (langCode.Contains("vi"))
            {
                return viClientColumnName;
            }
            else
            {
                return enClientColumnName;
            }
        }
        #endregion
    }
}
