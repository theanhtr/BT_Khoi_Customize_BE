using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Interface để controller gọi đến
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public interface IEmployeeService : ICodeService<Employee, EmployeeDto, EmployeeCreateDto, EmployeeUpdateDto>
    {
        /// <summary>
        /// Kiểm tra và gán dữ liệu hợp lệ hay không
        /// </summary>
        /// <param name="employeeExcels">Dữ liệu muốn kiểm tra</param>
        /// <param name="importMode">Loại nhập khẩu</param>
        /// <returns>Dữ liệu đã được kiểm tra</returns>
        /// CreatedBy: TTANH (20/07/2023)
        Task<List<EmployeeExcelDto>> ExcelDataValidCheck(List<EmployeeExcelDto> employeeExcels, ImportMode importMode);

        /// <summary>
        /// Hàm lọc dữ liệu trong file excel
        /// </summary>
        /// <param name="employeesExcel">Dữ liệu muốn lọc</param>
        /// <param name="filterExcelDataValidateType">Loại dữ liệu muốn lọc</param>
        /// <param name="pageSize">Số bản ghi trên trang</param>
        /// <param name="pageNumber">Vị trí trang</param>
        /// <returns>Dữ liệu đã được lọc</returns>
        /// CreatedBy: TTANH (21/07/2023)
        EmployeeExcelFilterResponse FilterExcelData(List<EmployeeExcelDto> employeesExcel, FilterExcelDataValidateType filterExcelDataValidateType, int pageSize, int pageNumber);

        /// <summary>
        /// Hàm yêu cầu thêm dữ liệu từ file excel vào
        /// </summary>
        /// <param name="employeesExcel">dữ liệu trong file excel</param>
        /// <returns>số hàng được thêm</returns>
        /// CreatedBy: TTANH (21/07/2023)
        Task<int> InsertExcelDataAsync(List<EmployeeExcelDto> employeesExcel);

        /// <summary>
        /// Hàm yêu cầu thêm hoặc cập nhật dữ liệu từ file excel vào
        /// </summary>
        /// <param name="employeesExcel">dữ liệu trong file excel</param>
        /// <returns>số hàng ảnh hưởng</returns>
        /// CreatedBy: TTANH (24/07/2023)
        Task<int> UpsertExcelDataAsync(List<EmployeeExcelDto> employeesExcel);
    }
}
