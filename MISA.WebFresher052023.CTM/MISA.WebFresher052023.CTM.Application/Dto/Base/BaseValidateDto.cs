using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Base để lưu trữ các dto cần kiểm tra bản ghi
    /// </summary>
    /// CreatedBy: TTANH (20/07/2023)
    public class BaseValidateDto
    {
        /// <summary>
        /// Kiểm tra xem bản ghi có hợp lệ không
        /// </summary>
        public RecordCheck ValidCheck { get; set; }

        /// <summary>
        /// Chi tiết lỗi của dữ liệu
        /// </summary>
        public string? ValidateDescription { get; set; }
    }
}
