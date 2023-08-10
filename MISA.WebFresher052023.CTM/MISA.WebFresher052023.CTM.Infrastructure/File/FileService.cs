using Microsoft.AspNetCore.Http;
using MISA.WebFresher052023.CTM.Application;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    public class FileService : IFileService
    {
        /// <summary>
        /// Hàm lấy ra đường dẫn tới file
        /// </summary>
        /// <param name="folderPath">đường dẫn tới folder</param>
        /// <param name="fileName">tên file</param>
        /// <returns>Đường dẫn tới file</returns>
        /// CreatedBy: TTANH (19/07/2023)
        public string GetFilePath(string folderPath, string fileName)
        {
            var filePath = Path.Combine(folderPath, fileName);

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            return filePath;
        }

        /// <summary>
        /// Hàm tạo file mới và truyền dữ liệu vào file
        /// </summary>
        /// <param name="folderPath">đường dẫn tới folder cần lưu trữ file</param>
        /// <param name="fileName">tên của file</param>
        /// <param name="fileName">dữ liệu của file</param>
        /// <returns>Trả ra đường dẫn đến file</returns>
        /// CreatedBy: TTANH (19/07/2023)
        public string CreateFile(string folderPath, string fileName, IFormFile file)
        {
            var filePath = GetFilePath(folderPath, fileName);

            using var fileStream = File.Create(filePath);

            file.CopyTo(fileStream);

            fileStream.Close();

            return filePath;
        }

        /// <summary>
        /// Hàm xóa file
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// CreatedBy: TTANH (19/07/2023)
        public void DeleteFile(string filePath)
        {
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }
        }
    }
}
