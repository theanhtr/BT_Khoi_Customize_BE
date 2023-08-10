using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    public abstract class CodeService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> : BaseService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto>, ICodeService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> where TEntity : IEntityHasKey where TEntityUpdateDto : IEntityHasCode
    {
        #region Fields
        protected ICodeRepository<TEntity> _codeRepository;
        public virtual string tableCode { get; protected set; } = typeof(TEntity).Name + "Code";
        #endregion

        #region Constructor
        protected CodeService(ICodeRepository<TEntity> codeRepository, IMapper mapper, IBaseValidate<TEntity> baseValidate) : base(codeRepository, mapper, baseValidate)
        {
            _codeRepository = codeRepository;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm lấy một bản ghi theo mã code
        /// </summary>
        /// <param name="code">Mã code của bản ghi</param>
        /// <returns>Bản ghi</returns>
        /// Created by: TTANH (15/07/2023)
        public async Task<TEntityDto> GetByCodeAsync(string code)
        {
            var entity = await _codeRepository.GetByCodeAsync(code);

            var entityDto = _mapper.Map<TEntityDto>(entity);

            return entityDto;
        }

        /// <summary>
        /// Hàm lấy một mã code mới không trùng
        /// </summary>
        /// <returns>Mã code mới</returns>
        /// Created by: TTANH (15/07/2023)
        public async Task<string> GetNewCodeAsync()
        {
            var newCode = await _codeRepository.GetNewCodeAsync();

            return newCode;
        }

        /// <summary>
        /// Thêm xử lý khi thêm bản ghi ở code base
        /// </summary>
        /// CreatedBy: TTANH (21/07/2023)
        public virtual async Task CodeServiceMoreProcessInsertAsync(TEntityCreateDto entityCreateDto) { }

        /// <summary>
        /// Ghi đè hàm thêm xử lý khi insert
        /// </summary>
        /// <param name="entityCreateDto">Dữ liệu của bản ghi</param>
        /// Created by: TTANH (21/07/2023)
        public override async Task BaseServiceMoreProcessInsertAsync(TEntityCreateDto entityCreateDto)
        {
            await CodeServiceMoreProcessInsertAsync(entityCreateDto);

            var entityCreateDtoCode = entityCreateDto.GetType().GetProperty($"{tableCode}").GetValue(entityCreateDto).ToString();

            await _baseValidate.CodeValidate(entityCreateDtoCode);
        }

        /// <summary>
        /// Thêm xử lý khi cập nhật bản ghi ở code base
        /// </summary>
        /// CreatedBy: TTANH (21/07/2023)
        public virtual async Task CodeServiceMoreProcessUpdateAsync(Guid id, TEntityUpdateDto entityUpdateDto) { }

        /// <summary>
        /// Ghi đè hàm thêm xử lý khi cập nhật thông tin bản ghi
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <param name="entityUpdateDto">Dữ liệu update bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (21/07/2023)
        public override async Task BaseServiceMoreProcessUpdateAsync(Guid id, TEntityUpdateDto entityUpdateDto)
        {
            await CodeServiceMoreProcessUpdateAsync(id, entityUpdateDto);

            var entityUpdateDtoCode = "";

            var typeEntityUpdateDtoCode = entityUpdateDto.GetType().GetProperty($"{tableCode}").GetValue(entityUpdateDto);

            if (typeEntityUpdateDtoCode != null)
            {
                entityUpdateDtoCode = typeEntityUpdateDtoCode.ToString();
            }

            var entityUpdate = await _codeRepository.GetByIdAsync(id);

            var entityUpdateCode = entityUpdate.GetType().GetProperty($"{tableCode}").GetValue(entityUpdate).ToString();

            if ((entityUpdateDtoCode != entityUpdateCode) && (entityUpdateDtoCode != ""))
            {
                await _baseValidate.CodeValidate(entityUpdateDtoCode);
            }
        }
        #endregion
    }
}
