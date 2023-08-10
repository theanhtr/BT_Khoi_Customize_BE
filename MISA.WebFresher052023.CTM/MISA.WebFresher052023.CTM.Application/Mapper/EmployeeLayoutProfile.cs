using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Set ánh xạ dto cho employee layout
    /// </summary>
    /// Created by: TTANH (02/08/2023)
    public class EmployeeLayoutProfile : Profile
    {
        public EmployeeLayoutProfile()
        {
            CreateMap<EmployeeLayout, EmployeeLayoutDto>();
            CreateMap<EmployeeLayoutCreateDto, EmployeeLayout>();
            CreateMap<EmployeeLayoutUpdateDto, EmployeeLayout>();
        }
    }
}
