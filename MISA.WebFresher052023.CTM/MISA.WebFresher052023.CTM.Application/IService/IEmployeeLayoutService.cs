using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Interface service cho employee layout để controller gọi đến
    /// </summary>
    /// Created by: TTANH (02/08/2023)
    public interface IEmployeeLayoutService : IBaseService<EmployeeLayout, EmployeeLayoutDto, EmployeeLayoutCreateDto, EmployeeLayoutUpdateDto>
    {
        /// <summary>
        /// Hàm cập nhật nhiều bản ghi
        /// </summary>
        /// <param name="employeeLayoutsUpdate">Dữ liệu của các bản ghi cập nhật</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (02/08/2023)
        Task<int> UpdateMultipleAsync(List<EmployeeLayoutUpdateDto> employeeLayoutsUpdate);

        /// <summary>
        /// Hàm lấy lại dữ liệu mặc định
        /// </summary>
        /// CreatedBy: TTANH (03/08/2023)
        Task SetDefault();
    }
}
