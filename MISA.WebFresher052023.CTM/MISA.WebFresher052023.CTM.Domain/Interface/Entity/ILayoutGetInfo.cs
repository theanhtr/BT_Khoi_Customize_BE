namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Dùng để lấy thông tin tiêu đề
    /// </summary>
    /// CreatedBy: TTANH (02/08/2023)
    public interface ILayoutGetInfo
    {
        /// <summary>
        /// Lấy ra tên cột trong server
        /// </summary>
        /// CreatedBy: TTANH (02/08/2023)
        string GetServerColumnName();

        /// <summary>
        /// Lấy ra tên cột hiển thị của người dùng bằng đa ngôn ngữ
        /// </summary>
        /// CreatedBy: TTANH (06/08/2023)
        string GetClientColumnName(string langCode);
    }
}
