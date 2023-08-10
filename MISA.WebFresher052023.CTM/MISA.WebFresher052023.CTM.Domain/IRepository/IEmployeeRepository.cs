namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Interface để tương tác với DB Employee
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public interface IEmployeeRepository : ICodeRepository<Employee>
    {
        #region Methods
        /// <summary>
        /// Hàm thêm nhiều bản ghi
        /// </summary>
        /// <param name="employeesStrConvert">Dữ liệu lại thành chuỗi để truyền vào truy vấn</param>
        /// CreatedBy: TTANH (27/07/2023)
        Task<int> InsertMultipleAsync(string employeesStrConvert);

        /// <summary>
        /// Hàm cập nhật nhiều bản ghi
        /// </summary>
        /// <param name="employeesStrConvert">Dữ liệu lại thành chuỗi để truyền vào truy vấn</param>
        /// CreatedBy: TTANH (28/07/2023)
        Task<int> UpdateMultipleAsync(string employeesStrConvert);
        #endregion
    }
}
