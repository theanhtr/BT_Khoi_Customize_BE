using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Set ánh xạ dto cho employee
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public class EmployeeProfile : Profile
    {
        public EmployeeProfile()
        {
            CreateMap<Employee, EmployeeDto>();
            CreateMap<EmployeeCreateDto, Employee>();
            CreateMap<EmployeeUpdateDto, Employee>();
            CreateMap<EmployeeExcelDto, Employee>();
            CreateMap<EmployeeExcelDto, EmployeeCreateDto>();
            CreateMap<EmployeeExcelDto, EmployeeUpdateDto>();
        }
    }
}
