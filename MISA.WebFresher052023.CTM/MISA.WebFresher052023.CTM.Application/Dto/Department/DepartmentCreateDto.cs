using System.ComponentModel.DataAnnotations;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Dto tạo phòng ban
    /// </summary>
    public class DepartmentCreateDto
    {
        #region Property
        /// <summary>
        /// Mã code của phòng ban
        /// </summary>
        [Required]
        [StringLength(20)]
        public string DepartmentCode { get; set; }

        /// <summary>
        /// Tên của phòng ban
        /// </summary>
        [Required]
        [StringLength(100)]
        public string DepartmentName { get; set; }
        #endregion
    }
}
