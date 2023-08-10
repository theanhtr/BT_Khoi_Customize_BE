using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM.Application
{
    public abstract class ReadOnlyService<TEntity, TEntityDto> : IReadOnlyService<TEntity, TEntityDto>
    {
        #region Fields
        protected readonly IReadOnlyRepository<TEntity> _readOnlyRepository;
        protected readonly IMapper _mapper;
        protected readonly IBaseValidate<TEntity> _baseValidate;

        public virtual string tableName { get; protected set; } = typeof(TEntity).Name;
        public virtual string tableId { get; protected set; } = typeof(TEntity).Name + "Id";
        #endregion

        #region Constructor
        public ReadOnlyService(IBaseRepository<TEntity> readOnlyRepository, IMapper mapper, IBaseValidate<TEntity> baseValidate)
        {
            _readOnlyRepository = readOnlyRepository;
            _mapper = mapper;
            _baseValidate = baseValidate;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm lấy tất cả bản ghi
        /// </summary>
        /// <returns>Mảng chứa các bản ghi</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<IEnumerable<TEntityDto>?> GetAsync()
        {
            var entities = await _readOnlyRepository.GetAsync();

            if (entities == null)
            {
                throw new NotFoundException();
            }

            var entitiesDto = _mapper.Map<List<TEntityDto>>(entities);

            return entitiesDto;
        }

        /// <summary>
        /// Hàm lấy một bản ghi theo id
        /// </summary>
        /// <param name="id">Id của bản ghi</param>
        /// <returns>Bản ghi, throw exception nếu không tìm thấy</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<TEntityDto> GetByIdAsync(Guid id)
        {
            var entity = await _readOnlyRepository.GetByIdAsync(id);

            var entityDto = _mapper.Map<TEntityDto>(entity);

            return entityDto;
        }

        /// <summary>
        /// Hàm lọc dữ liệu bản ghi
        /// </summary>
        /// <param name="pageSize">Số bản ghi trên 1 trang</param>
        /// <param name="pageNumber">Thứ tự trang bao nhiêu</param>
        /// <param name="searchText">Chuỗi tìm kiếm</param>
        /// <returns>Các bản lọc theo các tiêu chí</returns>
        /// Created by: TTANH (18/07/2023)
        public async Task<BaseFilterResponse<TEntityDto>> FilterAsync(int? pageSize, int? pageNumber, string? searchText)
        {
            if (pageSize == null || pageSize < 0) { pageSize = 999999; }
            if (pageNumber == null || pageNumber < 1) { pageNumber = 1; }

            var entitiesNotPagging = await _readOnlyRepository.FilterAsync(int.MaxValue, 1, searchText);

            var totalRecord = entitiesNotPagging.Count();
            var totalPage = Convert.ToInt32(Math.Ceiling((double)totalRecord / (double)pageSize));

            if (pageNumber > totalPage)
            {
                pageNumber = totalPage;
            }

            var entities = await _readOnlyRepository.FilterAsync(pageSize, pageNumber, searchText);

            if (entities == null)
            {
                throw new NotFoundException();
            }

            var currentPage = pageNumber;
            var currentPageRecords = entities.Count();

            var entitiesDto = _mapper.Map<List<TEntityDto>>(entities);

            var filterData = new BaseFilterResponse<TEntityDto>(totalPage, totalRecord, currentPage, currentPageRecords, entitiesDto);

            return filterData;
        }
        #endregion
    }
}
