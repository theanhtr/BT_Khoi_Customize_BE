using Microsoft.AspNetCore.Http;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Interface để tương tác với file trong hệ thống
    /// </summary>
    /// CreatedBy: TTANH (19/07/2023)
    public interface IFileService
    {
        /// <summary>
        /// Hàm lấy ra đường dẫn tới file
        /// </summary>
        /// <param name="folderPath">đường dẫn tới folder</param>
        /// <param name="fileName">tên file</param>
        /// <returns>Đường dẫn tới file</returns>
        /// CreatedBy: TTANH (19/07/2023)
        string GetFilePath(string folderPath, string fileName);

        /// <summary>
        /// Hàm tạo file mới và truyền dữ liệu vào file
        /// </summary>
        /// <param name="folderPath">đường dẫn tới folder cần lưu trữ file</param>
        /// <param name="fileName">tên của file</param>
        /// <param name="fileName">dữ liệu của file</param>
        /// <returns>Trả ra đường dẫn đến file</returns>
        /// CreatedBy: TTANH (19/07/2023)
        string CreateFile(string folderPath, string fileName, IFormFile file);

        /// <summary>
        /// Hàm xóa file
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// CreatedBy: TTANH (19/07/2023)
        void DeleteFile(string filePath);
    }
}
