using Dapper;
using MISA.WebFresher052023.CTM.Domain;
using System.Data;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    /// <summary>
    /// Triển khai bằng dapper và mysql
    /// </summary>
    /// Created By: TTANH (12/07/2023)
    public class EmployeeRepository : CodeRepository<Employee>, IEmployeeRepository
    {
        #region Constructor
        public EmployeeRepository(IUnitOfWork unitOfWork) : base(unitOfWork)
        {
            
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm thêm nhiều bản ghi
        /// </summary>
        /// <param name="employeesStrConvert">Dữ liệu lại thành chuỗi để truyền vào truy vấn</param>
        /// CreatedBy: TTANH (27/07/2023)
        public async Task<int> InsertMultipleAsync(string employeesStrConvert)
        {
            var procedure = "Proc_Employee_InsertList";

            var param = new DynamicParameters();
            param.Add("values", employeesStrConvert);

            var rowAdd = await _unitOfWork.Connection.ExecuteScalarAsync<int>(procedure, param, commandType: CommandType.StoredProcedure);

            return rowAdd;
        }

        /// <summary>
        /// Hàm cập nhật nhiều bản ghi
        /// </summary>
        /// <param name="employeesStrConvert">Dữ liệu lại thành chuỗi để truyền vào truy vấn</param>
        /// CreatedBy: TTANH (28/07/2023)
        public async Task<int> UpdateMultipleAsync(string employeesStrConvert)
        {
            var procedure = "Proc_Employee_UpdateList";

            var param = new DynamicParameters();
            param.Add("values", employeesStrConvert);

            var rowUpdate = await _unitOfWork.Connection.ExecuteScalarAsync<int>(procedure, param, commandType: CommandType.StoredProcedure);

            return rowUpdate;
        }
        #endregion
    }
}
