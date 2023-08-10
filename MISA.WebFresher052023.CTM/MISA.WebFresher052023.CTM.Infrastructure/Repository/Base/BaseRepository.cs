using Dapper;
using DocumentFormat.OpenXml.Office2010.Excel;
using MISA.WebFresher052023.CTM.Application;
using MISA.WebFresher052023.CTM.Domain;
using System.Data;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    /// <summary>
    /// Base để xử lý CRUD căn bản và filter
    /// </summary>
    /// Created by: TTANH (18/07/2023)
    public abstract class BaseRepository<TEntity> : ReadOnlyRepository<TEntity>, IBaseRepository<TEntity> where TEntity : IEntityHasKey
    {
        #region Constructor
        protected BaseRepository(IUnitOfWork unitOfWork) : base(unitOfWork)
        {
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm thêm bản ghi
        /// </summary>
        /// <param name="entity">Dữ liệu của bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<int> InsertAsync(TEntity entity)
        {
            var procedure = $"Proc_{tableName}_Insert";

            var param = new DynamicParameters();

            var type = typeof(TEntity);
            var properties = type.GetProperties();

            foreach (var property in properties)
            {
                var propertyName = "@" + property.Name;
                var propertyValue = property.GetValue(entity);

                param.Add(propertyName, propertyValue);
            }

            var result = await _unitOfWork.Connection.ExecuteAsync(procedure, param, commandType: CommandType.StoredProcedure);

            return result;
        }

        /// <summary>
        /// Hàm cập nhật thông tin bản ghi
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <param name="entity">Dữ liệu update bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<int> UpdateAsync(Guid id, TEntity entity)
        {
            var procedure = $"Proc_{tableName}_Update";

            var param = new DynamicParameters();
            param.Add("id", id);

            var type = typeof(TEntity);
            var properties = type.GetProperties();

            foreach (var property in properties)
            {
                var propertyName = "@" + property.Name;
                var propertyValue = property.GetValue(entity);

                param.Add(propertyName, propertyValue);
            }

            var result = await _unitOfWork.Connection.ExecuteAsync(procedure, param, commandType: CommandType.StoredProcedure);

            return result;
        }

        /// <summary>
        /// Hàm xóa bản ghi
        /// </summary>
        /// <param name="entity">Thực thể muốn xóa</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<int> DeleteAsync(TEntity entity)
        {
            var procedure = $"Proc_AllTable_Delete";

            var param = new DynamicParameters();
            param.Add("tableName", tableName);
            param.Add("tableId", tableId);
            param.Add("id", entity.GetKey());

            var result = await _unitOfWork.Connection.ExecuteAsync(procedure, param, commandType: CommandType.StoredProcedure);

            return result;
        }

        /// <summary>
        /// Hàm xóa nhiều bản ghi
        /// </summary>
        /// <param name="entities">List các thực thể muốn xóa</param>
        /// <returns>Số bản ghi đã xóa</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<int> DeleteMultipleAsync(List<TEntity> entities)
        {
            var procedure = "Proc_AllTable_DeleteList";

            var ids = entities.Select(x => x.GetKey()).ToList();

            var idsFormat = HelperApplication.ConvertArrayToStringWithSeparatorElement(ids, ",");

            var param = new DynamicParameters();
            param.Add("tableName", tableName);
            param.Add("tableId", tableId);
            param.Add("ids", idsFormat);

            var result = await _unitOfWork.Connection.ExecuteAsync(procedure, param, commandType: CommandType.StoredProcedure);

            return result;
        }
        #endregion
    }
}
