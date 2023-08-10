namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Base để xử lý CRUD căn bản và filter
    /// </summary>
    /// Created by: TTANH (18/07/2023)
    public interface IBaseRepository<TEntity> : IReadOnlyRepository<TEntity>
    {
        #region Methods
        /// <summary>
        /// Hàm thêm bản ghi
        /// </summary>
        /// <param name="entity">Dữ liệu của bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> InsertAsync(TEntity entity);

        /// <summary>
        /// Hàm cập nhật thông tin bản ghi
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <param name="entity">Dữ liệu update bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> UpdateAsync(Guid id, TEntity entity);

        /// <summary>
        /// Hàm xóa bản ghi
        /// </summary>
        /// <param name="entity">Thực thể muốn xóa</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> DeleteAsync(TEntity entity);

        /// <summary>
        /// Hàm xóa nhiều bản ghi
        /// </summary>
        /// <param name="entities">List các thực thể muốn xóa</param>
        /// <returns>Số bản ghi đã xóa</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> DeleteMultipleAsync(List<TEntity> entities);
        #endregion
    }
}
