using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;
using MISA.WebFresher052023.CTM.Application;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    public class ExcelService<TEntity, TEntityDto, TExcelDto, TEntityLayoutDto> : IExcelService<TExcelDto, TEntityLayoutDto>
    {
        #region Fields
        protected readonly IBaseRepository<TEntity> _baseRepository;
        protected readonly IMapper _mapper;
        protected readonly IExcelWorker<TEntityDto, TExcelDto, TEntityLayoutDto> _excelWorker;
        #endregion

        #region Constructor
        public ExcelService(IBaseRepository<TEntity> baseRepository, IMapper mapper, IExcelWorker<TEntityDto, TExcelDto, TEntityLayoutDto> excelWorker)
        {
            _baseRepository = baseRepository;
            _mapper = mapper;
            _excelWorker = excelWorker;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Export dữ liệu ra file excel (xlsx)
        /// </summary>
        /// <param name="searchText">Nội dung tìm kiếm</param>
        /// <param name="titleExport">Tên tiêu đề và tên sheet của file</param>
        /// <param name="headersInfo">Thông tin của các tiêu đề</param>
        /// <returns>Dữ liệu trong file excel</returns>
        /// CreatedBy: TTANH (16/07/2023)
        public async Task<byte[]> ExportToExcelAsync(string? searchText, string? titleExport, List<TEntityLayoutDto> headersInfo)
        {
            var entities = await _baseRepository.GetAsync();

            if (searchText != null)
            {
                entities = await _baseRepository.FilterAsync(999999, 1, searchText);
            }

            var entitiesDto = _mapper.Map<List<TEntityDto>>(entities);

            var content = _excelWorker.ConvertDataToExcelData(entitiesDto, titleExport, headersInfo);
            
            return content;
        }

        /// <summary>
        /// Đọc file excel để lấy dữ liệu cho setting
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="headerFind">cột để xác định headerRowIndex</param>
        /// CreatedBy: TTANH (17/07/2023)
        public ExcelImportSettingData GetExcelSettingData(string filePath, string headerFind)
        {
            var importExcelSettingData = _excelWorker.GetExcelSettingData(filePath, headerFind);

            return importExcelSettingData;
        }

        /// <summary>
        /// Lấy ra các thông tin của các tiêu đề
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="sheetContainsData">sheet tương tác</param>
        /// <param name="headerRowIndex">vị trí của tiêu đề</param>
        /// <returns>thông tin các cột trong sheet</returns>
        /// CreatedBy: TTANH (17/07/2023)
        public List<ExcelHeadersInfo> GetHeadersInfo(string filePath, string sheetContainsData, int headerRowIndex)
        {
            var headersInfo = _excelWorker.GetHeadersInfo(filePath, sheetContainsData, headerRowIndex);

            if (headersInfo.Count() == 0)
            {
                throw new ValidateException(StatusErrorCode.ExcelHeaderEmpty, Resource.Excel_Header_Empty, null);
            }

            //Xử lý trùng cột header
            var headerExists = new List<string>();

            foreach (var header in headersInfo)
            {
                if (string.IsNullOrEmpty(header.HeaderName))
                {
                    throw new ValidateException(StatusErrorCode.ExcelHeaderEmpty, Resource.Excel_Header_Empty, null);
                }

                if (headerExists.Contains(header.HeaderName))
                {
                    var messageError = string.Format(Resource.Excel_Header_Duplicate, header.HeaderName);
                    throw new ValidateException(StatusErrorCode.ExcelHeaderDuplicate, messageError, null);
                }

                headerExists.Add(header.HeaderName);
            }

            return headersInfo;
        }

        /// <summary>
        /// Đọc dữ liệu từ file excel, validate và insert vào bảng tạm
        /// </summary>
        /// <param name="fileId">id của file</param>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="sheetUsed">sheet tương tác</param>
        /// <param name="headerRowIndex">vị trí của tiêu đề</param>
        /// <param name="excelHeadersMapColumns">cột header ứng với dữ liệu</param>
        /// CreatedBy: TTANH (19/07/2023)
        public async Task<List<TExcelDto>> ReadExcelFile(string fileId, string filePath, string sheetUsed, int headerRowIndex, List<ExcelHeaderMapColumn> excelHeadersMapColumns)
        {
            var entities = _excelWorker.ReadExcelFile(filePath, sheetUsed, headerRowIndex, excelHeadersMapColumns);

            return entities;
        }
        #endregion
    }
}
