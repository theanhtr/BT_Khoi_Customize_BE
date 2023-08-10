namespace MISA.WebFresher052023.CTM.Application
{
    public class EmployeeExcelFilterResponse : BaseFilterResponse<EmployeeExcelDto>
    {
        public EmployeeExcelFilterResponse(int? totalPage, int? totalRecord, int? currentPage, int? currentPageRecords, List<EmployeeExcelDto>? data) : base(totalPage, totalRecord, currentPage, currentPageRecords, data)
        {
        }
    }
}
