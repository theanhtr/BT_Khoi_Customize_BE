namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Model để thêm setting khi nhập khẩu excel
    /// </summary>
    /// CreatedBy: TTANH (17/07/2023)
    public class ExcelImportSetting
    {
        #region Property
        /// <summary>
        /// Sheet chứa dữ liệu
        /// </summary>
        public string SheetContainsData { get; set; }

        /// <summary>
        /// Vị trí của dòng tiêu đề
        /// </summary>
        public int HeaderRowIndex { get; set; }

        /// <summary>
        /// Phương thức nhập
        /// </summary>
        public ImportMode ImportMode { get; set; }
        #endregion
    }
}
