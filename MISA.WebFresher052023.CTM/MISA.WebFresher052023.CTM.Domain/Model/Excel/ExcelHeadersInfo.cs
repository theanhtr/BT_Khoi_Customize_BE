namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Class lưu thông tin tiêu đề của excel file
    /// </summary>
    /// CreatedBy: TTANH (17/07/2023)
    public class ExcelHeadersInfo
    {
        #region Fields
        /// <summary>
        /// Số thứ tự cột của tiêu đề
        /// </summary>
        public int HeaderColumnIndex { get; set; }

        /// <summary>
        /// Tên của tiêu đề
        /// </summary>
        public string HeaderName { get; set; }
        #endregion

        #region Contructor
        public ExcelHeadersInfo(int headerColumnIndex, string headerName)
        {
            HeaderColumnIndex = headerColumnIndex;
            HeaderName = headerName;
        }
        #endregion
    }
}
