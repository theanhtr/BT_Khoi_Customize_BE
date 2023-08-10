using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    public interface IExcelWorker<TEntityDto, TEntityExcelDto, TEntityLayout>
    {
        /// <summary>
        /// hàm chuyển đổi dữ liệu đầu vào từ entities thành dữ liệu excel
        /// </summary>
        /// <param name="entitiesDto">Các đối tượng cần chuyển</param>
        /// <param name="titleExport">Tên tiêu đề và tên sheet của file</param>
        /// <param name="headersInfo">Thông tin của các tiêu đề</param>
        /// <returns>Dữ liệu excel</returns>
        /// CreatedBy: TTANH (17/07/2023)
        byte[] ConvertDataToExcelData(List<TEntityDto> entitiesDto, string? titleExport, List<TEntityLayout> headersInfo);

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
        /// Đọc dữ liệu từ file excel
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="sheetUsed">sheet tương tác</param>
        /// <param name="headerRowIndex">vị trí của tiêu đề</param>
        /// <param name="excelHeadersMapColumns">cột header ứng với dữ liệu</param>
        /// <returns>Trả về list dữ liệu insert, update excel</returns>
        /// CreatedBy: TTANH (19/07/2023)
        List<TEntityExcelDto> ReadExcelFile(string filePath, string sheetUsed, int headerRowIndex, List<ExcelHeaderMapColumn> excelHeadersMapColumns);
    }
}
