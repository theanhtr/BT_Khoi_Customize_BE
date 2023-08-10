using System.ComponentModel.DataAnnotations;

namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Thực thể của Department
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public class Department : BaseAuditEntity, IEntityHasKey
    {
        #region Property
        /// <summary>
        /// Id của phòng ban
        /// </summary>
        [Required]
        public Guid DepartmentId { get; set; }

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

        #region Methods
        /// <summary>
        /// Lấy ra key của phần tử
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        public Guid GetKey()
        {
            return DepartmentId;
        }

        /// <summary>
        /// Hàm set key cho phần tử
        /// </summary>
        /// <param name="key">giá trị của key</param>
        /// CreatedBy: TTANH (18/07/2023)
        public void SetKey(Guid key)
        {
            DepartmentId = key;
        }
        #endregion
    }
}
