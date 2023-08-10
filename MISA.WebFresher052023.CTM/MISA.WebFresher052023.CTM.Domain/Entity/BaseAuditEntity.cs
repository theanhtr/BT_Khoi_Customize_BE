namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Base để lưu trữ audit lock
    /// </summary>
    public abstract class BaseAuditEntity
    {
        #region Property
        /// <summary>
        /// Thời gian tạo
        /// </summary>
        public DateTime? CreatedDate { get; set; }

        /// <summary>
        /// Người tạo
        /// </summary>
        public string? CreatedBy { get; set; }

        /// <summary>
        /// Thời gian sửa
        /// </summary>
        public DateTime? ModifiedDate { get; set; }

        /// <summary>
        /// Người sửa
        /// </summary>
        public string? ModifiedBy { get; set; }
        #endregion
    }
}
