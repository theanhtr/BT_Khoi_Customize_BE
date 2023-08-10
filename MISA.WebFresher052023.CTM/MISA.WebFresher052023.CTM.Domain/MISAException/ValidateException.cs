namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Exception đại diện cho lỗi nhập liệu người dùng
    /// </summary>
    /// Created By: TTANH (12/07/2023)
    public class ValidateException : Exception
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

        /// <summary>
        /// Dữ liệu thông báo lỗi (nếu có)
        /// </summary>
        public Object? Data { get; set; }
        #endregion

        #region Constructor
        public ValidateException() { }
        public ValidateException(StatusErrorCode errorCode, string? errors, object? data)
        {
            ErrorCode = errorCode;
            ErrorMessage = errors;
            Data = data;
        }
        #endregion
    }
}
