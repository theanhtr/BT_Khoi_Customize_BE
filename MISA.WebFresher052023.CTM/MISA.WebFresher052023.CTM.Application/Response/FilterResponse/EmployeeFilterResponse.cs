namespace MISA.WebFresher052023.CTM.Application
{
    public class EmployeeFilterResponse : BaseFilterResponse<EmployeeDto>
    {
        public EmployeeFilterResponse(int? totalPage, int? totalRecord, int? currentPage, int? currentPageRecords, List<EmployeeDto>? data) : base(totalPage, totalRecord, currentPage, currentPageRecords, data)
        {
        }
    }
}
