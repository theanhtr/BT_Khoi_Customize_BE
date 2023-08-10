using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Interface để làm việc với excel
    /// </summary>
    /// CreatedBy: TTANH (16/07/2023)
    public interface IExcelService<TExcelDto, TEntityLayoutDto>
    {
        #region Methods
        /// <summary>
        /// Export dữ liệu ra file excel (xlsx)
        /// </summary>
        /// <param name="searchText">Nội dung tìm kiếm</param>
        /// <param name="titleExport">Tên tiêu đề và tên sheet của file</param>
        /// <param name="headersInfo">Thông tin của các tiêu đề</param>
        /// <returns>Dữ liệu trong file excel</returns>
        /// CreatedBy: TTANH (16/07/2023)
        Task<byte[]> ExportToExcelAsync(string? searchText, string? titleExport, List<TEntityLayoutDto> headersInfo);

        /// <summary>
        /// Đọc file excel để lấy dữ liệu cho setting
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="headerFind">cột để xác định headerRowIndex</param>
        /// CreatedBy: TTANH (17/07/2023)
        ExcelImportSettingData GetExcelSettingData(string filePath, string headerFind);

        /// <summary>
        /// Lấy ra các thông tin của các tiêu đề
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="sheetContainsData">sheet tương tác</param>
        /// <param name="headerRowIndex">vị trí của tiêu đề</param>
        /// <returns>thông tin các cột trong sheet</returns>
        /// CreatedBy: TTANH (17/07/2023)
        List<ExcelHeadersInfo> GetHeadersInfo(string filePath, string sheetContainsData, int headerRowIndex);

        /// <summary>
        /// Đọc dữ liệu từ file excel, validate và insert vào bảng tạm
        /// </summary>
        /// <param name="fileId">id của file</param>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="sheetUsed">sheet tương tác</param>
        /// <param name="headerRowIndex">vị trí của tiêu đề</param>
        /// <param name="excelHeadersMapColumns">cột header ứng với dữ liệu</param>
        /// CreatedBy: TTANH (19/07/2023)
        Task<List<TExcelDto>> ReadExcelFile(string fileId, string filePath, string sheetUsed, int headerRowIndex, List<ExcelHeaderMapColumn> excelHeadersMapColumns);
        #endregion
    }
}
