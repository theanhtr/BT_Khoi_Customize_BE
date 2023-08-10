namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Interface thực hiện các công việc lập lịch
    /// </summary>
    /// CreatedBy: TTANH (21/07/2023)
    public interface IScheduleService
    {
        /// <summary>
        /// Xóa những file đã xử lý bên trong folder
        /// </summary>
        /// <param name="folderPath">Đường dẫn đến folder muốn xóa</param>
        /// CreatedBy: TTANH (22/07/2023)
        void ClearFiles(string folderPath);
    }
}
