using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Format lại response thành công trong 1 số th đặc biệt
    ///     + Excel
    /// </summary>
    /// CreatedBy: TTANH (19/07/2023)
    public class SuccessResponseFormat
    {
        #region Fields
        /// <summary>
        /// Thông tin mã code thành công
        /// </summary>
        public StatusSuccessCode SuccessCode { get; set; }

        /// <summary>
        /// Thông báo cho người dùng
        /// </summary>
        public string? UserMessage { get; set; }

        /// <summary>
        /// Data trả về
        /// </summary>
        public Object? Data { get; set; }
        #endregion

        #region Constructor
        public SuccessResponseFormat() { }

        public SuccessResponseFormat(StatusSuccessCode successCode, string? userMessage, object? data)
        {
            SuccessCode = successCode;
            UserMessage = userMessage;
            Data = data;
        }
        #endregion
    }
}
