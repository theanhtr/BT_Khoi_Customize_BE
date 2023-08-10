namespace MISA.WebFresher052023.CTM.Application
{
    public class EmployeeLayoutFilterResponse : BaseFilterResponse<EmployeeLayoutDto>
    {
        public EmployeeLayoutFilterResponse(int? totalPage, int? totalRecord, int? currentPage, int? currentPageRecords, List<EmployeeLayoutDto>? data) : base(totalPage, totalRecord, currentPage, currentPageRecords, data)
        {
        }
    }
}
