namespace MISA.WebFresher052023.CTM.Domain
{
    public class EmployeeValidate : BaseValidate<Employee>, IEmployeeValidate
    {
        public EmployeeValidate(IEmployeeRepository employeeRepository) : base(employeeRepository)
        {
        }
    }
}
