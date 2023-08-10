namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Enum của mã lỗi
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public enum StatusErrorCode
    {
        /// <summary>
        /// Lỗi trùng code, code đã tồn tại trong hệ thống
        /// </summary>
        CodeDuplicate = 1407,

        /// <summary>
        /// Lỗi sai định dạng của code
        /// </summary>
        WrongFormatCode = 1408,

        /// <summary>
        /// Lỗi không tìm thấy dữ liệu
        /// </summary>
        NotFoundData = 1409,

        /// <summary>
        /// Phiên làm việc đã hết
        /// </summary>
        SessionIsOver = 1410,

        /// <summary>
        /// không cho xóa nhiều mà truyền mảng rỗng
        /// </summary>
        DeleteEmptyError = 1411,

        /// <summary>
        /// Lỗi sai định dạng ngày tháng
        /// </summary>
        WrongFormatDate = 1412,

        /// <summary>
        /// Tên tiêu đề bị trùng
        /// </summary>
        ExcelHeaderDuplicate = 1425,

        /// <summary>
        /// Tên tiêu đề bị rỗng
        /// </summary>
        ExcelHeaderEmpty = 1426,

        /// <summary>
        /// Sheet không có dữ liệu
        /// </summary>
        SheetIsEmpty = 1427,

        /// <summary>
        /// Không đúng định dạng xlsx
        /// </summary>
        FormatExcelError = 1428,

        /// <summary>
        /// Vượt quá kích thước cho phép
        /// </summary>
        MaxSizeFileError = 1429,

        /// <summary>
        /// Những trường bắt buộc trong tiêu đề chưa được điền
        /// </summary>
        ExcelHeaderRequiredNotMap = 1430
    }
}
