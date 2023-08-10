using Microsoft.AspNetCore.Mvc;
using MISA.WebFresher052023.CTM.Application;
using MISA.WebFresher052023.CTM.Domain;
using MISA.WebFresher052023.CTM.Infrastructure;

namespace MISA.WebFresher052023.CTM.Controllers
{
    /// <summary>
    /// Controller của layout thông tin cột nhân viên
    /// </summary>
    /// CreatedBy: TTANH (02/08/2023)
    [Route("api/v1/[controller]")]
    [ApiController]
    public class EmployeeLayoutsController : BaseController<EmployeeLayout, EmployeeLayoutDto, EmployeeLayoutCreateDto, EmployeeLayoutUpdateDto>
    {
        IEmployeeLayoutService _employeeLayoutService;

        #region Constructors
        public EmployeeLayoutsController(IEmployeeLayoutService employeeLayoutService) : base(employeeLayoutService)
        {
            _employeeLayoutService = employeeLayoutService;
        }
        #endregion
         
        #region 
        /// <summary>
        /// Hàm cập nhật nhiều cột layout nhân viên
        /// </summary>
        /// <param name="employeeLayoutsUpdate">List cần cập nhật</param>
        /// CreatedBy: TTANH (02/08/2023)
        [HttpPut("update-multiple")]
        public async Task<IActionResult> UpdateMultipleAsync([FromBody] List<EmployeeLayoutUpdateDto> employeeLayoutsUpdate)
        {
            var result = await _employeeLayoutService.UpdateMultipleAsync(employeeLayoutsUpdate);

            return StatusCode(StatusCodes.Status200OK, result);
        }

        /// <summary>
        /// Hàm lấy lại dữ liệu mặc định
        /// </summary>
        /// CreatedBy: TTANH (03/08/2023)
        [HttpPost("set-default")]
        public async Task<IActionResult> SetDefault()
        {
            await _employeeLayoutService.SetDefault();

            return StatusCode(StatusCodes.Status200OK);
        }
        #endregion
    }
}
