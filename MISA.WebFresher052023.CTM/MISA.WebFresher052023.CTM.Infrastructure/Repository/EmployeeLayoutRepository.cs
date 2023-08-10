using Dapper;
using MISA.WebFresher052023.CTM.Domain;
using System.Data;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    /// <summary>
    /// Triển khai bằng dapper và mysql
    /// </summary>
    /// Created By: TTANH (02/08/2023)
    public class EmployeeLayoutRepository : CodeRepository<EmployeeLayout>, IEmployeeLayoutRepository
    {
        #region Constructor
        public EmployeeLayoutRepository(IUnitOfWork unitOfWork) : base(unitOfWork)
        {
        }
        #endregion

        #region Methods

        /// <summary>
        /// Hàm lấy lại dữ liệu mặc định
        /// </summary>
        /// CreatedBy: TTANH (03/08/2023)
        public async Task SetDefault()
        {
            var procedure = "Proc_EmployeeLayout_SetDefault";

            await _unitOfWork.Connection.QueryAsync(procedure, null, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// Hàm cập nhật nhiều bản ghi
        /// </summary>
        /// <param name="employeeLayoutsStrConvert">Dữ liệu lại thành chuỗi để truyền vào truy vấn</param>
        /// CreatedBy: TTANH (02/08/2023)
        public async Task<int> UpdateMultipleAsync(string employeeLayoutsStrConvert)
        {
            var procedure = "Proc_EmployeeLayout_UpdateList";

            var param = new DynamicParameters();
            param.Add("values", employeeLayoutsStrConvert);

            var rowUpdate = await _unitOfWork.Connection.ExecuteScalarAsync<int>(procedure, param, commandType: CommandType.StoredProcedure);

            return rowUpdate;
        } 
        #endregion
    }
}
