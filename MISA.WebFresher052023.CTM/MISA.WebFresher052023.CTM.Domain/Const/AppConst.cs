namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Các hằng số dùng chung cho app
    /// </summary>
    /// CreatedBy: TTANH (22/07/2023)
    public static class AppConst
    {
        /// <summary>
        /// Format date, phải liên kết với client
        /// </summary>
        public const string FormatDate = "dd/MM/yyyy";

        /// <summary>
        /// Tên folder lưu trữ các file client gửi lên
        /// </summary>
        public const string ClientFolderStoreName = "client-files";

        /// <summary>
        /// Tên folder lưu trữ các file của server
        /// </summary>
        public const string ServerFolderStoreName = "server-files";

        /// <summary>
        /// Thời gian hết hạn của session, file gửi lên từ client
        /// </summary>
        public const int ExpiredTime = 15;

        /// <summary>
        /// Thời gian để chạy cron job
        /// Chạy mỗi 15 phút
        /// </summary>
        public const string CronJobTime = "*/15 * * * *";

        /// <summary>
        /// Giới hạn dung lượng file truyền lên - 2mb
        /// </summary>
        public const int MaxSizeFileUpload = 2097152;
    }
}
