namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Class để format dữ liệu trả về khi filter
    /// </summary>
    /// CreatedBy: TTANH (15/07/2023)
    public class BaseFilterResponse<TEntityDto>
    {
        #region Properties
        /// <summary>
        /// Tổng số trang
        /// </summary>
        public int? TotalPage { get; set; }

        /// <summary>
        /// Tổng số bản ghi
        /// </summary>
        public int? TotalRecord { get; set; }

        /// <summary>
        /// Vị trí page hiện tại
        /// </summary>
        public int? CurrentPage { get; set; }

        /// <summary>
        /// Tổng số bản ghi trên page hiện tại
        /// </summary>
        public int? CurrentPageRecords { get; set; }

        /// <summary>
        /// Dữ liệu trả về theo trang
        /// </summary>
        public List<TEntityDto>? Data { get; set; }
        #endregion

        #region Constructor
        public BaseFilterResponse(int? totalPage, int? totalRecord, int? currentPage, int? currentPageRecords, List<TEntityDto>? data)
        {
            TotalPage = totalPage;
            TotalRecord = totalRecord;
            CurrentPage = currentPage;
            CurrentPageRecords = currentPageRecords;
            Data = data;
        }
        #endregion
    }
}
