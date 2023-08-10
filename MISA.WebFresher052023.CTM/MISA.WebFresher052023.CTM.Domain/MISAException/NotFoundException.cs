namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Exception đại diện cho lỗi không tìm thấy tài nguyên
    /// </summary>
    /// Created By: TTANH (12/07/2023)
    public class NotFoundException : Exception
    {
        #region Property
        /// <summary>
        /// Mã lỗi
        /// </summary>
        public StatusErrorCode ErrorCode { get; set; }

        /// <summary>
        /// Thông tin lỗi
        /// </summary>
        public string? ErrorMessage { get; set; }
        #endregion

        #region Constructor
        public NotFoundException()
        {
            ErrorCode = StatusErrorCode.NotFoundData;
        }
        public NotFoundException(StatusErrorCode errorCode, string? errorMessage)
        {
            ErrorCode = errorCode;
            ErrorMessage = errorMessage;
        }
        #endregion
    }
}
