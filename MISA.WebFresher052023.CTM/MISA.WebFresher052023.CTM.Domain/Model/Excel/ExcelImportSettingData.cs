namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Model để lấy ra dữ liệu cho việc setting data
    /// </summary>
    /// CreatedBy: TTANH (17/07/2023)
    public class ExcelImportSettingData
    {
        #region Property
        /// <summary>
        /// Các sheet có trong file excel
        /// </summary>
        public List<string> Sheets { get; set; }
        
        /// <summary>
        /// Dòng chứa tiêu đề
        /// </summary>
        public int HeaderRowIndex { get; set; }
        #endregion
    }
}
