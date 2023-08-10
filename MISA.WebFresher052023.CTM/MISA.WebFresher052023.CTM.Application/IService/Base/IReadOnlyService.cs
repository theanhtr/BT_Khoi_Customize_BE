namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Base xử lý việc đọc với id và filter
    /// </summary>
    /// CreatedBy: TTANH (18/07/2023)
    public interface IReadOnlyService<TEntity, TEntityDto>
    {
        #region Methods
        /// <summary>
        /// Hàm lấy tất cả bản ghi
        /// </summary>
        /// <returns>Mảng chứa các bản ghi</returns>
        /// Created by: TTANH (18/07/2023)
        Task<IEnumerable<TEntityDto>?> GetAsync();

        /// <summary>
        /// Hàm lấy một bản ghi theo id
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Bản ghi, throw exception nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        Task<TEntityDto> GetByIdAsync(Guid id);

        /// <summary>
        /// Hàm lọc dữ liệu bản ghi
        /// </summary>
        /// <param name="pageSize">Số bản ghi trên 1 trang</param>
        /// <param name="pageNumber">Thứ tự trang bao nhiêu</param>
        /// <param name="searchText">Chuỗi tìm kiếm</param>
        /// <returns>Các bản lọc theo các tiêu chí</returns>
        /// Created by: TTANH (18/07/2023)
        Task<BaseFilterResponse<TEntityDto>> FilterAsync(int? pageSize, int? pageNumber, string? searchText);
        #endregion
    }
}
