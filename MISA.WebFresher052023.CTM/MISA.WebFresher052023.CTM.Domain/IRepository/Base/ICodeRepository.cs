namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Base để xử lý đối tượng có thêm mã code
    /// </summary>
    /// CreatedBy: TTANH (18/07/2023)
    public interface ICodeRepository<TEntity> : IBaseRepository<TEntity>
    {
        #region Methods
        /// <summary>
        /// Hàm lấy một bản ghi theo mã code
        /// </summary>
        /// <param name="code">Mã code của bản ghi</param>
        /// <returns>Bản ghi</returns>
        /// Created by: TTANH (18/07/2023)
        Task<TEntity> GetByCodeAsync(string code);

        /// <summary>
        /// Hàm lấy một bản ghi theo mã code
        /// </summary>
        /// <param name="code">Mã code của bản ghi</param>
        /// <returns>Bản ghi, null nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        Task<TEntity> FindByCodeAsync(string code);

        /// <summary>
        /// Hàm lấy các bản ghi theo chuỗi code
        /// </summary>
        /// <param name="codes">chuỗi code</param>
        /// Created by: TTANH (27/07/2023)
        Task<List<TEntity>> GetListByCodesAsync(List<Guid> codes);

        /// <summary>
        /// Hàm lấy một mã code mới không trùng
        /// </summary>
        /// <returns>Mã code mới</returns>
        /// Created by: TTANH (18/07/2023)
        Task<string> GetNewCodeAsync();
        #endregion
    }
}
