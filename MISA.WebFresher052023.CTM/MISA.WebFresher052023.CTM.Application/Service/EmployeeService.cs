using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;
using System.ComponentModel.DataAnnotations;
using System.Reflection;
using System.Text.RegularExpressions;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Class triển khai employee service được gọi từ controller
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public class EmployeeService : CodeService<Employee, EmployeeDto, EmployeeCreateDto, EmployeeUpdateDto>, IEmployeeService
    {
        #region Fields
        private readonly IEmployeeRepository _employeeRepository;
        private readonly IDepartmentRepository _departmentRepository;
        private readonly IEmployeeLayoutService _employeeLayoutService;
        private readonly IEmployeeValidate _employeeValidate;
        #endregion

        #region Constructors
        public EmployeeService(IEmployeeRepository employeeRepository, IMapper mapper, IEmployeeValidate employeeValidate, IDepartmentRepository departmentRepository, IEmployeeLayoutService employeeLayoutService) : base(employeeRepository, mapper, employeeValidate)
        {
            _employeeRepository = employeeRepository;
            _departmentRepository = departmentRepository;
            _employeeValidate = employeeValidate;
            _employeeLayoutService = employeeLayoutService;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm kiểm tra phòng ban
        /// </summary>
        /// <param name="departmentCode">mã code của phòng ban</param>
        /// <returns>phòng ban</returns>
        /// <exception cref="ValidateException">Lỗi validate</exception>
        /// CreatedBy: TTANH (20/07/2023)
        public async Task<Department> DepartmentValidate(string departmentCode)
        {
            var department = await _departmentRepository.FindByCodeAsync(departmentCode);

            if (department == null)
            {
                var messageError = string.Format(Resource.Department_Not_Exist, departmentCode);
                throw new ValidateException(StatusErrorCode.NotFoundData, messageError, null);
            }

            return department;
        }

        /// <summary>
        /// Ghi đè hàm thêm xử lý khi thêm bản ghi ở code base
        /// </summary>
        /// CreatedBy: TTANH (21/07/2023)
        public override async Task CodeServiceMoreProcessInsertAsync(EmployeeCreateDto employeeCreateDto)
        {
            var department = await DepartmentValidate(employeeCreateDto.DepartmentCode);

            employeeCreateDto.DepartmentId = department.DepartmentId;
            employeeCreateDto.DepartmentName = department.DepartmentName;
        }

        /// <summary>
        /// Ghi đè hàm thêm xử lý khi cập nhật bản ghi ở code base
        /// </summary>
        /// CreatedBy: TTANH (21/07/2023)
        public override async Task CodeServiceMoreProcessUpdateAsync(Guid id, EmployeeUpdateDto employeeUpdateDto)
        {
            if (!string.IsNullOrEmpty(employeeUpdateDto.DepartmentCode))
            {
                var department = await DepartmentValidate(employeeUpdateDto.DepartmentCode);

                employeeUpdateDto.DepartmentId = department.DepartmentId;
                employeeUpdateDto.DepartmentName = department.DepartmentName;
            }
        }

        /// <summary>
        /// Kiểm tra độ dài của từng field trong employeeExcel và gán lỗi nếu có
        /// </summary>
        /// <param name="employeeExcel">nhân viên trong file excel cần kiểm tra</param>
        /// <param name="employeeLayouts">mảng lưu trữ thông tin cột</param>
        /// CreatedBy: TTANH (01/08/2023)
        public void ValidateLengthExcel(EmployeeExcelDto employeeExcel, List<EmployeeLayoutDto> employeeLayouts)
        {
            foreach (var property in employeeExcel.GetType().GetProperties())
            {
                var propertyName = property?.Name;
                var propertyValue = property?.GetValue(employeeExcel);

                if ((propertyName != null) && (propertyValue != null))
                {
                    var maxLength = 0;

                    var attribute = property?
                            .GetCustomAttributes(typeof(StringLengthAttribute), false).Cast<StringLengthAttribute>().SingleOrDefault();

                    if (attribute != null)
                    {
                        var propertyLength = propertyValue.ToString().Length;
                        maxLength = attribute.MaximumLength;

                        if (propertyLength > maxLength)
                        {
                            var employeeLayout = employeeLayouts.Where(e => e.ServerColumnName.Contains(propertyName) || propertyName.Contains(e.ServerColumnName)).FirstOrDefault();

                            var messageError = string.Format(Resource.Wrong_Length, employeeLayout.GetClientColumnName(Resource.Lang_Code) ?? propertyName, maxLength);

                            HelperApplication.SetValidateError(messageError, employeeExcel);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Kiểm tra và gán dữ liệu hợp lệ hay không
        /// </summary>
        /// <param name="employeeExcels">Dữ liệu muốn kiểm tra</param>
        /// <param name="importMode">Loại nhập khẩu</param>
        /// <returns>Dữ liệu đã được kiểm tra</returns>
        /// CreatedBy: TTANH (20/07/2023)
        public async Task<List<EmployeeExcelDto>> ExcelDataValidCheck(List<EmployeeExcelDto> employeeExcels, ImportMode importMode)
        {
            var employeeCodeExists = await _employeeRepository.GetAllWithOneColumnAsync<string>("EmployeeCode");

            var departmentCodeExists = await _departmentRepository.GetAllWithOneColumnAsync<string>("DepartmentCode");

            var employeeLayouts = await _employeeLayoutService.GetAsync();

            // Lưu lại dữ liệu đã duyệt qua
            var employeesCheck = new List<EmployeeExcelDto>();

            foreach (var employeeExcel in employeeExcels)
            {
                employeeExcel.ValidCheck = RecordCheck.Valid;
                employeeExcel.ValidateDescription = "";

                // Không tìm thấy phòng ban
                if (!departmentCodeExists.Contains(employeeExcel.DepartmentCode))
                {
                    var messageError = string.Format(Resource.Department_Not_Exist, employeeExcel.DepartmentCode);

                    HelperApplication.SetValidateError(messageError, employeeExcel);
                }

                var regexCode = new Regex(Resource.Code_Regex);

                // Sai code format
                if (!regexCode.IsMatch(employeeExcel.EmployeeCode))
                {
                    var messageError = string.Format(Resource.Wrong_Format_Code, employeeExcel.EmployeeCode);

                    HelperApplication.SetValidateError(messageError, employeeExcel);
                }

                if (employeesCheck.Count() > 0)
                {
                    // Trùng mã với những dòng ở trên
                    var employeesDuplicate = employeesCheck.Where(employee => employee.EmployeeCode == employeeExcel.EmployeeCode);

                    if (employeesDuplicate.Count() > 0)
                    {
                        var messageError = string.Format(Resource.Excel_Row_Duplicate, employeesDuplicate.First().ExcelRowIndex);

                        HelperApplication.SetValidateError(messageError, employeeExcel);
                    }
                }

                // Chiều dài không đúng
                ValidateLengthExcel(employeeExcel, employeeLayouts.ToList());

                if (importMode == ImportMode.Add)
                {
                    // Mã nhân viên đã tồn tại
                    if (employeeCodeExists.Contains(employeeExcel.EmployeeCode))
                    {
                        var messageError = string.Format(Resource.Employee_Exist, employeeExcel.EmployeeCode);

                        HelperApplication.SetValidateError(messageError, employeeExcel);
                    }
                    else
                    {
                        employeeExcel.ImportMode = ImportMode.Add;
                    }
                }
                else if (importMode == ImportMode.Update)
                {
                    if (employeeCodeExists.Contains(employeeExcel.EmployeeCode))
                    {
                        employeeExcel.ImportMode = ImportMode.Update;
                    }
                    else
                    {
                        employeeExcel.ImportMode = ImportMode.Add;
                    }
                }
                else
                {
                    throw new ValidateException();
                }

                employeesCheck.Add(employeeExcel);
            }

            return employeeExcels;
        }

        /// <summary>
        /// Hàm lọc dữ liệu trong file excel
        /// </summary>
        /// <param name="employeesExcel">Dữ liệu muốn lọc</param>
        /// <param name="filterExcelDataValidateType">Loại dữ liệu muốn lọc</param>
        /// <param name="pageSize">Số bản ghi trên trang</param>
        /// <param name="pageNumber">Vị trí trang</param>
        /// <returns>Dữ liệu đã được lọc</returns>
        /// CreatedBy: TTANH (24/07/2023)
        public EmployeeExcelFilterResponse FilterExcelData(List<EmployeeExcelDto> employeesExcel, FilterExcelDataValidateType filterExcelDataValidateType, int pageSize, int pageNumber)
        {
            if (pageSize < 0) { pageSize = 999999; }
            if (pageNumber < 1) { pageNumber = 1; }

            var employeesExcelFilter = employeesExcel;

            if (filterExcelDataValidateType == FilterExcelDataValidateType.Invalid)
            {
                employeesExcelFilter = employeesExcel.Where(employeeExcel => employeeExcel.ValidCheck == RecordCheck.Invalid).ToList();
            }
            else if (filterExcelDataValidateType == FilterExcelDataValidateType.Valid)
            {
                employeesExcelFilter = employeesExcel.Where(employeeExcel => employeeExcel.ValidCheck == RecordCheck.Valid).ToList();
            }

            var totalRecord = employeesExcelFilter.Count();
            var totalPage = Convert.ToInt32(Math.Ceiling((double)totalRecord / (double)pageSize));

            if (pageNumber > totalPage)
            {
                pageNumber = totalPage;
            }

            var startIndex = (pageNumber - 1) * pageSize;
            employeesExcelFilter = employeesExcelFilter.Skip(startIndex).Take(pageSize).ToList();

            var currentPage = pageNumber;
            var currentPageRecords = employeesExcelFilter.Count();

            var filterData = new EmployeeExcelFilterResponse(totalPage, totalRecord, currentPage, currentPageRecords, employeesExcelFilter);

            return filterData;
        }

        /// <summary>
        /// Thêm thông tin phòng ban cho một chuỗi nhân viên
        /// </summary>
        /// <param name="employees">chuỗi nhân viên</param>
        /// CreatedBy: TTANH (27/07/2023)
        public async Task AddDepartmentInforToEmployees(List<Employee> employees)
        {
            // dùng để lấy tất cả phòng ban
            var departments = (await _departmentRepository.GetAsync()).ToList();

            foreach (Employee employee in employees)
            {
                // lấy ra phòng ban khớp với departmentCode trong employee
                var departmentMatch = departments.Where(department =>
                {
                    return department.DepartmentCode == employee.DepartmentCode;
                }).First();

                employee.DepartmentId = departmentMatch.DepartmentId;
                employee.DepartmentName = departmentMatch.DepartmentName;
            }
        }

        /// <summary>
        /// Thêm thông tin EmployeeId cho một chuỗi nhân viên
        /// </summary>
        /// <param name="employees">chuỗi nhân viên</param>
        /// CreatedBy: TTANH (27/07/2023)
        public void AddEmployeeIdToEmployees(List<Employee> employees)
        {
            foreach (Employee employee in employees)
            {
                employee.EmployeeId = Guid.NewGuid();
            }
        }

        /// <summary>
        /// Thêm thông tin tạo cho một chuỗi nhân viên
        /// </summary>
        /// <param name="employees">chuỗi nhân viên</param>
        /// CreatedBy: TTANH (27/07/2023)
        public void AddCreatedInforToEmployees(List<Employee> employees)
        {
            foreach (Employee employee in employees)
            {
                employee.CreatedDate = DateTime.Now;
                employee.CreatedBy = "TTANH Tạo mới";
            }
        }

        /// <summary>
        /// Thêm thông tin sửa cho một chuỗi nhân viên
        /// </summary>
        /// <param name="employees">chuỗi nhân viên</param>
        /// CreatedBy: TTANH (27/07/2023)
        public void AddModifiedInforToEmployees(List<Employee> employees)
        {
            foreach (Employee employee in employees)
            {
                employee.ModifiedDate = DateTime.Now;
                employee.ModifiedBy = "TTANH Cập nhật";
            }
        }

        /// <summary>
        /// Chuyển đổi một object element thành một chuỗi string với phần tử ngăn cách
        /// để truyền dữ liệu cho truy vấn trong procedure
        /// Lưu ý: chuyển đổi để truyền dữ liệu cho procedure nên Gender, Date sẽ có format
        ///         và "" sẽ thành "null"
        /// </summary>
        /// <param name="employee">Nhân viên muốn chuyển</param>
        /// <param name="importMode">
        ///     +) Add: ghép hết dữ liệu
        ///     +) Update: bỏ trường: EmployeeId, CreatedDate, CreatedBy để không bị ảnh hưởng
        /// </param>
        /// <returns>Đã được chuyển thành chuỗi với phần tử ngăn cách</returns>
        /// <example>IN: { a: 1, b: 2, c: 3} -> "'1','2','3'"</example>
        /// CreatedBy: TTANH (28/07/2023)
        public string ConvertEmployeeToStringForQuery(Employee employee, ImportMode importMode)
        {
            var strConvert = "";

            foreach (PropertyInfo propertyInfo in employee.GetType().GetProperties())
            {
                var valueFormat = "";

                var valueRaw = propertyInfo.GetValue(employee);

                if (valueRaw != null)
                {
                    if (propertyInfo.Name.Contains("Gender"))
                    {
                        valueFormat = ((int)propertyInfo.GetValue(employee)).ToString();
                    }
                    else if (propertyInfo.Name.Contains("Date"))
                    {
                        var formatValue = ((DateTime)valueRaw).ToString("yyyy-MM-dd HH:mm:ss");

                        valueFormat = "\'" + formatValue + "\'";
                    }
                    else
                    {
                        var typeOfValueRaw = valueRaw.GetType();

                        if (typeOfValueRaw.Name == "Boolean")
                        {
                            valueFormat = valueRaw.ToString();
                        }
                        else
                        {
                            valueFormat = "\'" + valueRaw + "\'";
                        }
                    }
                }
                else
                {
                    valueFormat = "null";
                }

                ///+) Add: ghép hết dữ liệu
                ///+) Update: bỏ trường: EmployeeId, CreatedDate, CreatedBy để không bị ảnh hưởng
                if (propertyInfo.Name.Contains("EmployeeId") || propertyInfo.Name.Contains("CreatedBy") || propertyInfo.Name.Contains("CreatedDate"))
                {
                    if (importMode == ImportMode.Add)
                    {
                        strConvert = strConvert + valueFormat + ",";
                    }
                    else if (importMode == ImportMode.Update)
                    {
                    }
                }
                else
                {
                    strConvert = strConvert + valueFormat + ",";
                }
            }

            // Xóa phần tử ngăn cách thừa ở cuối
            strConvert = strConvert.Substring(0, strConvert.Length - 1);

            return strConvert;
        }

        /// <summary>
        /// Gộp dữ liệu lại thành chuỗi để truyền vào truy vấn
        /// Mảng phải lớn hơn 0
        /// </summary>
        /// <param name="employees">chuỗi nhân viên</param>
        /// CreatedBy: TTANH (27/07/2023)
        public string ConvertEmployeesToStringForQuerySQL(List<Employee> employees, ImportMode importMode)
        {
            var employeesStrConvert = "";

            foreach (Employee employee in employees)
            {
                var employeeStrMerge = ConvertEmployeeToStringForQuery(employee, importMode);

                employeesStrConvert = employeesStrConvert + "(" + employeeStrMerge + ")" + ",";
            }

            // Xóa phần tử ngăn cách thừa ở cuối
            employeesStrConvert = employeesStrConvert.Substring(0, employeesStrConvert.Length - 1);

            return employeesStrConvert;
        }

        /// <summary>
        /// Hàm thêm nhiều bản ghi
        /// </summary>
        /// <param name="employeesCreateValid">Dữ liệu của các bản ghi thêm mới "đã hợp lệ"</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (27/07/2023)
        public async Task<int> InsertMultipleValidAsync(List<EmployeeCreateDto> employeesCreateValid)
        {
            if (employeesCreateValid.Count() > 0)
            {
                var employeesValid = _mapper.Map<List<Employee>>(employeesCreateValid);

                // Thêm thông tin phòng ban
                await AddDepartmentInforToEmployees(employeesValid);

                // Thêm thông tin EmployeeId
                AddEmployeeIdToEmployees(employeesValid);

                // Thêm thông tin CreatedBy, CreatedDate
                AddCreatedInforToEmployees(employeesValid);

                // Gộp dữ liệu lại thành chuỗi để truyền vào truy vấn
                var employeesStrConvert = ConvertEmployeesToStringForQuerySQL(employeesValid, ImportMode.Add);

                await _employeeRepository.InsertMultipleAsync(employeesStrConvert);

                var rowAdd = employeesValid.Count();

                return rowAdd;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Hàm yêu cầu thêm dữ liệu từ file excel vào
        /// </summary>
        /// <param name="employeesExcel">dữ liệu trong file excel</param>
        /// <returns>số hàng được thêm</returns>
        /// CreatedBy: TTANH (21/07/2023)
        public async Task<int> InsertExcelDataAsync(List<EmployeeExcelDto> employeesExcel)
        {
            var employeesExcelValid = employeesExcel.Where(x => x.ValidCheck == RecordCheck.Valid);

            var employeesCreateValid = _mapper.Map<List<EmployeeCreateDto>>(employeesExcelValid);

            var result = await InsertMultipleValidAsync(employeesCreateValid);

            return result;
        }

        /// <summary>
        /// Hàm cập nhật nhiều bản ghi
        /// </summary>
        /// <param name="employeesUpdateValid">Dữ liệu của các bản ghi cập nhật "đã hợp lệ"</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (27/07/2023)
        public async Task<int> UpdateMultipleValidAsync(List<EmployeeUpdateDto> employeesUpdateValid)
        {
            if (employeesUpdateValid.Count() > 0)
            {
                var employeesValid = _mapper.Map<List<Employee>>(employeesUpdateValid);

                // Thêm thông tin phòng ban
                await AddDepartmentInforToEmployees(employeesValid);

                // Thêm thông tin ModifiedBy, ModifiedDate
                AddModifiedInforToEmployees(employeesValid);

                // Gộp dữ liệu lại thành chuỗi để truyền vào truy vấn
                var employeesStrConvert = ConvertEmployeesToStringForQuerySQL(employeesValid, ImportMode.Update);

                await _employeeRepository.UpdateMultipleAsync(employeesStrConvert);

                var rowUpdate = employeesUpdateValid.Count();

                return rowUpdate;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Hàm yêu cầu thêm hoặc cập nhật dữ liệu từ file excel vào
        /// </summary>
        /// <param name="employeesExcel">dữ liệu trong file excel</param>
        /// <returns>số hàng ảnh hưởng</returns>
        /// CreatedBy: TTANH (24/07/2023)
        public async Task<int> UpsertExcelDataAsync(List<EmployeeExcelDto> employeesExcel)
        {
            var employeesCreateValid = employeesExcel.Where(x => x.ValidCheck == RecordCheck.Valid && x.ImportMode == ImportMode.Add);

            var employeesUpdateValid = employeesExcel.Where(x => x.ValidCheck == RecordCheck.Valid && x.ImportMode == ImportMode.Update);

            var employeesCreate = _mapper.Map<List<EmployeeCreateDto>>(employeesCreateValid);

            var employeesUpdate = _mapper.Map<List<EmployeeUpdateDto>>(employeesUpdateValid);

            var rowEffect = 0;

            rowEffect += await InsertMultipleValidAsync(employeesCreate);
            rowEffect += await UpdateMultipleValidAsync(employeesUpdate);

            return rowEffect;
        }
        #endregion
    }
}
