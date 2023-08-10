using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    public abstract class BaseService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> : ReadOnlyService<TEntity, TEntityDto>, IBaseService<TEntity, TEntityDto, TEntityCreateDto, TEntityUpdateDto> where TEntity : IEntityHasKey
    {
        #region Fields
        protected readonly IBaseRepository<TEntity> _baseRepository;
        #endregion

        #region Constructor
        protected BaseService(IBaseRepository<TEntity> baseRepository, IMapper mapper, IBaseValidate<TEntity> baseValidate) : base(baseRepository, mapper, baseValidate)
        {
            _baseRepository = baseRepository;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Thêm xử lý khi thêm bản ghi
        /// </summary>
        /// CreatedBy: TTANH (21/07/2023)
        public virtual async Task BaseServiceMoreProcessInsertAsync(TEntityCreateDto entityCreateDto) { }

        /// <summary>
        /// Hàm thêm bản ghi
        /// </summary>
        /// <param name="entityCreateDto">Dữ liệu của bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        public virtual async Task<int> InsertAsync(TEntityCreateDto entityCreateDto)
        {
            await BaseServiceMoreProcessInsertAsync(entityCreateDto);

            var entity = _mapper.Map<TEntity>(entityCreateDto);

            entity.SetKey(Guid.NewGuid());

            if (entity is BaseAuditEntity baseAuditEntity)
            {
                baseAuditEntity.CreatedDate = DateTime.Now;
                baseAuditEntity.CreatedBy = "USER ADD";
            }

            var result = await _baseRepository.InsertAsync(entity);

            return result;
        }

        /// <summary>
        /// Thêm xử lý khi cập nhật bản ghi
        /// </summary>
        /// CreatedBy: TTANH (21/07/2023)
        public virtual async Task BaseServiceMoreProcessUpdateAsync(Guid id, TEntityUpdateDto entityUpdateDto) { }

        /// <summary>
        /// Hàm cập nhật thông tin bản ghi
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <param name="entityUpdateDto">Dữ liệu update bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        public virtual async Task<int> UpdateAsync(Guid id, TEntityUpdateDto entityUpdateDto)
        {
            await BaseServiceMoreProcessUpdateAsync(id, entityUpdateDto);

            var entityUpdate = await _baseRepository.GetByIdAsync(id);

            foreach (var property in entityUpdateDto.GetType().GetProperties())
            {
                var propertyName = property?.Name;
                var propertyValue = property?.GetValue(entityUpdateDto);

                if ((propertyName != null))
                {
                    var propertyInfo = entityUpdate.GetType().GetProperty(propertyName);

                    if (propertyInfo != null)
                    {
                        propertyInfo.SetValue(entityUpdate, propertyValue, null);
                    }
                }
            }

            var entity = _mapper.Map<TEntity>(entityUpdate);

            if (entity is BaseAuditEntity baseAuditEntity)
            {
                baseAuditEntity.ModifiedDate = DateTime.Now;
                baseAuditEntity.ModifiedBy = "USER UPDATE";
            }

            var result = await _baseRepository.UpdateAsync(id, entityUpdate);

            return result;
        }

        /// <summary>
        /// Hàm xóa bản ghi
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (18/07/2023)
        public virtual async Task<int> DeleteAsync(Guid id)
        {
            var entity = await _baseRepository.GetByIdAsync(id);

            var result = await _baseRepository.DeleteAsync(entity);

            return result;
        }

        /// <summary>
        /// Hàm xóa nhiều bản ghi
        /// </summary>
        /// <param name="ids">List các id của bản ghi</param>
        /// <returns>Số bản ghi đã xóa</returns>
        /// Created by: TTANH (18/07/2023)
        public virtual async Task<int> DeleteMultipleAsync(List<Guid> ids)
        {
            if (ids.Count() == 0)
            {
                throw new ValidateException(StatusErrorCode.DeleteEmptyError, Resource.Delete_Empty_Error, null);
            }

            var entities = await _baseRepository.GetListByIdsAsync(ids);

            var result = await _baseRepository.DeleteMultipleAsync(entities);

            return result;
        }
        #endregion
    }
}
