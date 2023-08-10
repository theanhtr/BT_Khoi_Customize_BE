using Dapper;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Wordprocessing;
using MISA.WebFresher052023.CTM.Application;
using MISA.WebFresher052023.CTM.Domain;
using System.Data;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    /// <summary>
    /// Base xử lý việc đọc với id và filter
    /// </summary>
    /// CreatedBy: TTANH (18/07/2023)
    public abstract class ReadOnlyRepository<TEntity> : IReadOnlyRepository<TEntity>
    {
        #region Fields
        protected readonly IUnitOfWork _unitOfWork;

        public virtual string tableName { get; protected set; } = typeof(TEntity).Name;
        public virtual string tableId { get; protected set; } = typeof(TEntity).Name + "Id";
        #endregion

        #region Constructor
        public ReadOnlyRepository(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm đếm số bản ghi trong db
        /// </summary>
        /// <returns>Số bản ghi trong db</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<int> CountAsync()
        {
            var procedure = $"Proc_AllTable_Count";

            var param = new DynamicParameters();
            param.Add("tableName", tableName);

            var countEntities = await _unitOfWork.Connection.ExecuteScalarAsync<int>(procedure, param, commandType: CommandType.StoredProcedure);

            return countEntities;
        }

        /// <summary>
        /// Hàm lấy tất cả bản ghi
        /// </summary>
        /// <returns>Mảng chứa các bản ghi</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<IEnumerable<TEntity>?> GetAsync()
        {
            var procedure = $"Proc_AllTable_GetAll";

            var param = new DynamicParameters();
            param.Add("tableName", tableName);

            var entities = await _unitOfWork.Connection.QueryAsync<TEntity>(procedure, param, commandType: CommandType.StoredProcedure);

            return entities;
        }

        /// <summary>
        /// Hàm lấy các bản ghi
        /// </summary>
        /// <param name="ids">List id</param>
        /// <returns>Các bản ghi, throw exception nếu không tìm thấy</returns>
        /// Created by: TTANH (24/07/2023)
        public async Task<List<TEntity>> GetListByIdsAsync(List<Guid> ids)
        {
            var procedure = "Proc_AllTable_GetListByColumnValues";

            var idsFormat = HelperApplication.ConvertArrayToStringWithSeparatorElement<Guid>(ids, ",");

            var param = new DynamicParameters();
            param.Add("tableName", tableName);
            param.Add("columnName", tableId);
            param.Add("values", idsFormat);

            var entities = await _unitOfWork.Connection.QueryAsync<TEntity> (procedure, param, commandType:CommandType.StoredProcedure);

            return entities.ToList();
        }

        /// <summary>
        /// Hàm lấy 1 cột của tất cả bản ghi
        /// </summary>
        /// <param name="columnName">Tên cột muốn lấy</param>
        /// <returns>Mảng chứa các bản ghi</returns>
        /// Created by: TTANH (21/07/2023)
        public async Task<IEnumerable<DataType>?> GetAllWithOneColumnAsync<DataType>(string columnName)
        {
            var procedure = $"Proc_AllTable_GetAllByColumnName";

            var param = new DynamicParameters();
            param.Add("tableName", tableName);
            param.Add("columnName", columnName);

            var entities = await _unitOfWork.Connection.QueryAsync<DataType>(procedure, param, commandType: CommandType.StoredProcedure);

            return entities;
        }

        /// <summary>
        /// Hàm lấy một bản ghi theo id
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Bản ghi, throw exception nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<TEntity> GetByIdAsync(Guid id)
        {
            var entity = await FindAsync(id);

            if (entity == null)
            {
                throw new NotFoundException();
            }

            return entity;
        }

        /// <summary>
        /// Hàm tìm kiếm bản ghi, trả về null nếu không tìm thấy
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Bản ghi, null nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<TEntity?> FindAsync(Guid id)
        {
            var procedure = $"Proc_AllTable_GetById";

            var param = new DynamicParameters();
            param.Add("tableName", tableName);
            param.Add("tableId", tableId);
            param.Add("id", id);

            var entity = await _unitOfWork.Connection.QueryFirstOrDefaultAsync<TEntity>(procedure, param, commandType: CommandType.StoredProcedure);

            return entity;
        }

        /// <summary>
        /// Hàm lọc dữ liệu bản ghi
        /// </summary>
        /// <param name="pageSize">Số bản ghi trên 1 trang</param>
        /// <param name="pageNumber">Thứ tự trang bao nhiêu</param>
        /// <param name="searchText">Chuỗi tìm kiếm</param>
        /// <returns>Các bản lọc theo các tiêu chí</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<IEnumerable<TEntity>> FilterAsync(int? pageSize, int? pageNumber, string? searchText)
        {
            var procedure = $"Proc_{tableName}_Filter";

            var param = new DynamicParameters();
            param.Add("pageSize", pageSize);
            param.Add("pageNumber", pageNumber);
            param.Add("searchText", searchText);

            var entities = await _unitOfWork.Connection.QueryAsync<TEntity>(procedure, param, commandType: CommandType.StoredProcedure);

            return entities;
        }
        #endregion
    }
}
