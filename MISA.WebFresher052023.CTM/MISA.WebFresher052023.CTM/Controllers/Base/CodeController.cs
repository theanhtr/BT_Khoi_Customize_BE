using Microsoft.AspNetCore.Mvc;
using MISA.WebFresher052023.CTM.Application;

namespace MISA.WebFresher052023.CTM.Controllers
{
    /// <summary>
    /// Controller base gồm CRUD có code
    /// </summary>
    /// CreatedBy: TTANH (18/07/2023)
    [ApiController]
    public class CodeController<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> : BaseController<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto>
    {
        #region Fields
        private readonly ICodeService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> _codeService;
        #endregion

        #region Constructor
        public CodeController(ICodeService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> codeService) : base(codeService)
        {
            _codeService = codeService;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm lấy dữ liệu bản ghi theo mã code
        /// </summary>
        /// <param name="code">mã code bản ghi</param>
        /// <returns>Bản ghi</returns>
        /// CreatedBy: TTANH (18/07/2023)
        [HttpGet("code/{code}")]
        public async Task<IActionResult> GetByCodeAsync(string code)
        {
            var entity = await _codeService.GetByCodeAsync(code);

            return StatusCode(StatusCodes.Status200OK, entity);
        }

        /// <summary>
        /// Hàm lấy một entity code mới không trùng
        /// </summary>
        /// <returns>Entity code mới</returns>
        /// Created by: TTANH (18/07/2023)
        [HttpGet("new-code")]
        public async Task<IActionResult> GetNewCodeAsync()
        {
            var newCode = await _codeService.GetNewCodeAsync();

            return StatusCode(StatusCodes.Status200OK, newCode);
        }

        /// <summary>
        /// Hàm thêm bản ghi
        /// </summary>
        /// <param name="entityCreateDto">dữ liệu bản ghi được thêm</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// CreatedBy: TTANH (18/07/2023)
        [HttpPost]
        public override async Task<IActionResult> InsertAsync([FromBody] TEntityCreateDto entityCreateDto)
        {
            var result = await _codeService.InsertAsync(entityCreateDto);

            return StatusCode(StatusCodes.Status201Created, result);
        }

        /// <summary>
        /// Hàm update thông tin bản ghi
        /// </summary>
        /// <param name="id">id của bản ghi</param>
        /// <param name="entityUpdateDto">dữ liệu update</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// CreatedBy: TTANH (18/07/2023)
        [HttpPut("{id}")]
        public override async Task<IActionResult> UpdateAsync(Guid id, [FromBody] TEntityUpdateDto entityUpdateDto)
        {
            var result = await _codeService.UpdateAsync(id, entityUpdateDto);

            return StatusCode(StatusCodes.Status200OK, result);
        }
        #endregion
    }
}
