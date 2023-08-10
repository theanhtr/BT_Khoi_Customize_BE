namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Base để xử lý CRUD căn bản và filter
    /// </summary>
    /// Created by: TTANH (18/07/2023)
    public interface IBaseService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> : IReadOnlyService<TEntity, TEntityDto>
    {
        #region Methods
        /// <summary>
        /// Hàm thêm bản ghi
        /// </summary>
        /// <param name="entityCreateDto">Dữ liệu của bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> InsertAsync(TEntityCreateDto entityCreateDto);

        /// <summary>
        /// Hàm cập nhật thông tin bản ghi
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <param name="entityUpdateDto">Dữ liệu update bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> UpdateAsync(Guid id, TEntityUpdateDto entityUpdateDto);

        /// <summary>
        /// Hàm xóa bản ghi
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> DeleteAsync(Guid id);

        /// <summary>
        /// Hàm xóa nhiều bản ghi
        /// </summary>
        /// <param name="ids">List các id của bản ghi</param>
        /// <returns>Số bản ghi đã xóa</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> DeleteMultipleAsync(List<Guid> ids);
        #endregion
    }
}
