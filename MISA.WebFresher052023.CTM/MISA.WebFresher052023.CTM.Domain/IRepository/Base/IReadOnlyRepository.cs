namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Base xử lý việc đọc với id và filter
    /// </summary>
    /// CreatedBy: TTANH (18/07/2023)
    public interface IReadOnlyRepository<TEntity>
    {
        #region Methods
        /// <summary>
        /// Hàm đếm số bản ghi trong db
        /// </summary>
        /// <returns>Số bản ghi trong db</returns>
        /// Created by: TTANH (18/07/2023)
        Task<int> CountAsync();

        /// <summary>
        /// Hàm lấy tất cả bản ghi
        /// </summary>
        /// <returns>Mảng chứa các bản ghi</returns>
        /// Created by: TTANH (18/07/2023)
        Task<IEnumerable<TEntity>?> GetAsync();

        /// <summary>
        /// Hàm lấy các bản ghi
        /// </summary>
        /// <param name="ids">List id</param>
        /// <returns>Các bản ghi, throw exception nếu không tìm thấy</returns>
        /// Created by: TTANH (24/07/2023)
        Task<List<TEntity>> GetListByIdsAsync(List<Guid> ids);

        /// <summary>
        /// Hàm lấy 1 cột của tất cả bản ghi
        /// </summary>
        /// <returns>Mảng chứa các bản ghi</returns>
        /// <param name="columnName">Tên cột muốn lấy</param>
        /// Created by: TTANH (21/07/2023)
        Task<IEnumerable<DataType>?> GetAllWithOneColumnAsync<DataType>(string columnName);

        /// <summary>
        /// Hàm lấy một bản ghi theo id
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Bản ghi, throw exception nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        Task<TEntity> GetByIdAsync(Guid id);

        /// <summary>
        /// Hàm tìm kiếm bản ghi, trả về null nếu không tìm thấy
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Bản ghi, null nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        Task<TEntity?> FindAsync(Guid id);

        /// <summary>
        /// Hàm lọc dữ liệu bản ghi
        /// </summary>
        /// <param name="pageSize">Số bản ghi trên 1 trang</param>
        /// <param name="pageNumber">Thứ tự trang bao nhiêu</param>
        /// <param name="searchText">Chuỗi tìm kiếm</param>
        /// <returns>Các bản lọc theo các tiêu chí</returns>
        /// Created by: TTANH (18/07/2023)
        Task<IEnumerable<TEntity>> FilterAsync(int? pageSize, int? pageNumber, string? searchText);
        #endregion
    }
}
