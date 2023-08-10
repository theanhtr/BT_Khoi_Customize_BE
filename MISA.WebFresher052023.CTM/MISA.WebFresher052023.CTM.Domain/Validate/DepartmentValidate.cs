namespace MISA.WebFresher052023.CTM.Domain
{
    public class DepartmentValidate : BaseValidate<Department>, IDepartmentValidate
    {
        public DepartmentValidate(IDepartmentRepository departmentRepository) : base(departmentRepository)
        {
        }
    }
}
