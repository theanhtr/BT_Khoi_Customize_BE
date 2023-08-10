namespace MISA.WebFresher052023.CTM.Domain
{
    public class EmployeeLayoutValidate : BaseValidate<EmployeeLayout>, IEmployeeLayoutValidate
    {
        public EmployeeLayoutValidate(IEmployeeLayoutRepository employeeLayoutRepository) : base(employeeLayoutRepository)
        {
        }
    }
}
