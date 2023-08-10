using Dapper;
using DocumentFormat.OpenXml.Office2010.Excel;
using MISA.WebFresher052023.CTM.Application;
using MISA.WebFresher052023.CTM.Domain;
using System.Data;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    public abstract class CodeRepository<TEntity> : BaseRepository<TEntity>, ICodeRepository<TEntity> where TEntity : IEntityHasKey
    {
        #region Fields
        public virtual string tableCode { get; protected set; } = typeof(TEntity).Name + "Code";
        #endregion

        #region Constructor
        public CodeRepository(IUnitOfWork unitOfWork) : base(unitOfWork)
        {
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm lấy một bản ghi theo mã code
        /// </summary>
        /// <param name="code">Mã code của bản ghi</param>
        /// <returns>Bản ghi, throw exception nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<TEntity> GetByCodeAsync(string code)
        {
            var entity = await FindByCodeAsync(code);

            if (entity == null)
            {
                throw new NotFoundException();
            }

            return entity;
        }

        /// <summary>
        /// Hàm lấy một bản ghi theo mã code
        /// </summary>
        /// <param name="code">Mã code của bản ghi</param>
        /// <returns>Bản ghi, null nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<TEntity> FindByCodeAsync(string code)
        {
            var procedure = $"Proc_AllTable_GetByCode";

            var param = new DynamicParameters();
            param.Add("tableName", tableName);
            param.Add("tableCode", tableCode);
            param.Add("code", code);

            var entity = await _unitOfWork.Connection.QueryFirstOrDefaultAsync<TEntity>(procedure, param, commandType: CommandType.StoredProcedure);

            return entity;
        }

        /// <summary>
        /// Hàm lấy các bản ghi theo chuỗi code
        /// </summary>
        /// <param name="codes">chuỗi code</param>
        /// Created by: TTANH (27/07/2023)
        public async Task<List<TEntity>> GetListByCodesAsync(List<Guid> codes)
        {
            var procedure = "Proc_AllTable_GetListByColumnValues";

            var codesFormat = HelperApplication.ConvertArrayToStringWithSeparatorElement<Guid>(codes, ",");

            var param = new DynamicParameters();
            param.Add("tableName", tableName);
            param.Add("columnName", tableCode);
            param.Add("values", codesFormat);

            var entities = await _unitOfWork.Connection.QueryAsync<TEntity>(procedure, param, commandType: CommandType.StoredProcedure);

            return entities.ToList();
        }

        /// <summary>
        /// Hàm lấy một mã code mới không trùng
        /// </summary>
        /// <returns>Mã code mới</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<string> GetNewCodeAsync()
        {
            var procedure = $"Proc_{tableName}_NewCode";

            var newCode = await _unitOfWork.Connection.ExecuteScalarAsync<string>(procedure, null, commandType: CommandType.StoredProcedure);

            if (string.IsNullOrEmpty(newCode))
            {
                return "NV-1001";
            }

            return newCode;
        }
        #endregion
    }
}
