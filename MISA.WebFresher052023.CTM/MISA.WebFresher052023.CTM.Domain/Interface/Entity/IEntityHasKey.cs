namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Interface để tương tác với key của các entity
    /// </summary>
    /// CreatedBy: TTANH (18/07/2023)
    public interface IEntityHasKey
    {
        /// <summary>
        /// Lấy ra key của phần tử
        /// </summary>
        /// CreatedBy: TTANH (18/07/2023)
        Guid GetKey();

        /// <summary>
        /// Hàm set key cho phần tử
        /// </summary>
        /// <param name="key">giá trị của key</param>
        /// CreatedBy: TTANH (18/07/2023)
        void SetKey(Guid key);
    }
}
