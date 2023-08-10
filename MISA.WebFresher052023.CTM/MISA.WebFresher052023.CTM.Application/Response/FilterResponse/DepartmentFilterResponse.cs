namespace MISA.WebFresher052023.CTM.Application
{
    public class DepartmentFilterResponse : BaseFilterResponse<DepartmentDto>
    {
        public DepartmentFilterResponse(int? totalPage, int? totalRecord, int? currentPage, int? currentPageRecords, List<DepartmentDto>? data) : base(totalPage, totalRecord, currentPage, currentPageRecords, data)
        {
        }
    }
}
