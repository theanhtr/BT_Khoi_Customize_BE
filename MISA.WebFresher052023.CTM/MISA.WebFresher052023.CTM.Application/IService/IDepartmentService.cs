using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Interface service cho department để controller gọi đến
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public interface IDepartmentService : ICodeService<Department, DepartmentDto, DepartmentCreateDto, DepartmentUpdateDto>
    {
    }
}
