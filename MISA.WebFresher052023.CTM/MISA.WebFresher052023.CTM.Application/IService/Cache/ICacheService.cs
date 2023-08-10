namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Interface điều khiển việc cache với redis
    /// </summary>
    /// CreatedBy: TTANH (20/07/2023)
    public interface ICacheService
    {
        #region Methods
        /// <summary>
        /// Lấy dữ liệu trong cache bằng key
        /// </summary>
        /// <param name="key">key của cache</param>
        /// <returns>dữ liệu ứng với key</returns>
        /// CreatedBy: TTANH (20/07/2023)
        TCacheData Get<TCacheData>(string key);

        /// <summary>
        /// Lấy dữ liệu trong cache bằng key bất đồng bộ
        /// </summary>
        /// <param name="key">key của cache</param>
        /// <returns>dữ liệu ứng với key</returns>
        /// CreatedBy: TTANH (20/07/2023)
        Task<TCacheData> GetAsync<TCacheData>(string key);

        /// <summary>
        /// Gán dữ liệu cho key cùng với thời gian hết hạn
        /// </summary>
        /// <param name="key">key muốn gán</param>
        /// <param name="value">giá trị muốn gán</param>
        /// <param name="expirationTime">thời gian hết hạn</param>
        /// <returns>true - thành công, false - thất bại</returns>
        /// CreatedBy: TTANH (20/07/2023)
        bool Set<TCacheData>(string key, TCacheData value, DateTimeOffset expirationTime);

        /// <summary>
        /// Gán dữ liệu cho key cùng với thời gian hết hạn bất đồng bộ
        /// </summary>
        /// <param name="key">key muốn gán</param>
        /// <param name="value">giá trị muốn gán</param>
        /// <param name="expirationTime">thời gian hết hạn</param>
        /// <returns>true - thành công, false - thất bại</returns>
        /// CreatedBy: TTANH (20/07/2023)
        Task<bool> SetAsync<TCacheData>(string key, TCacheData value, DateTimeOffset expirationTime);

        /// <summary>
        /// Xóa data bằng key
        /// </summary>
        /// <param name="key">key của cache</param>
        /// <returns></returns>
        /// CreatedBy: TTANH (20/07/2023)
        object Remove(string key);

        /// <summary>
        /// Xóa data bằng key bất đồng bộ
        /// </summary>
        /// <param name="key">key của cache</param>
        /// <returns></returns>
        /// CreatedBy: TTANH (20/07/2023)
        Task<object> RemoveAsync(string key);
        #endregion
    }
}
