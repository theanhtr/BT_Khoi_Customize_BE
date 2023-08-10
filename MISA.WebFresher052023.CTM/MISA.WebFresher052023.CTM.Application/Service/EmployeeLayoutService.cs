using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;
using System.Reflection;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Class triển khai employeeLayout service được gọi từ controller
    /// </summary>
    /// Created by: TTANH (12/07/2023)
    public class EmployeeLayoutService : BaseService<EmployeeLayout, EmployeeLayoutDto, EmployeeLayoutCreateDto, EmployeeLayoutUpdateDto>, IEmployeeLayoutService
    {
        IEmployeeLayoutRepository _employeeLayoutRepository;

        #region Constructor
        public EmployeeLayoutService(IEmployeeLayoutRepository employeeLayoutRepository, IMapper mapper, IEmployeeLayoutValidate employeeLayoutValidate) : base(employeeLayoutRepository, mapper, employeeLayoutValidate)
        {
            _employeeLayoutRepository = employeeLayoutRepository;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm lấy lại dữ liệu mặc định
        /// </summary>
        /// CreatedBy: TTANH (03/08/2023)
        public async Task SetDefault()
        {
            await _employeeLayoutRepository.SetDefault();
        }

        /// <summary>
        /// Thêm thông tin sửa cho một chuỗi nhân viên
        /// </summary>
        /// <param name="employeeLayouts">chuỗi nhân viên</param>
        /// CreatedBy: TTANH (02/08/2023)
        public void AddModifiedInforToEmployeeLayouts(List<EmployeeLayout> employeeLayouts)
        {
            foreach (EmployeeLayout employeeLayout in employeeLayouts)
            {
                employeeLayout.ModifiedDate = DateTime.Now;
                employeeLayout.ModifiedBy = "TTANH Cập nhật";
            }
        }

        /// <summary>
        /// Chuyển đổi một object element thành một chuỗi string với phần tử ngăn cách
        /// để truyền dữ liệu cho truy vấn trong procedure
        /// </summary>
        /// <param name="employeeLayout">Mảng muốn chuyển</param>
        /// <returns>Đã được chuyển thành chuỗi với phần tử ngăn cách</returns>
        /// <example>IN: { a: 1, b: 2, c: 3} -> "'1','2','3'"</example>
        /// CreatedBy: TTANH (02/08/2023)
        public string ConvertEmployeeLayoutToStringForQuery(EmployeeLayoutUpdateDto employeeLayoutUpdate)
        {
            var strConvert = "";

            foreach (PropertyInfo propertyInfo in employeeLayoutUpdate.GetType().GetProperties())
            {
                var valueFormat = "";

                var valueRaw = propertyInfo.GetValue(employeeLayoutUpdate);

                if (valueRaw != null)
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
                else
                {
                    valueFormat = "null";
                }
                    
                strConvert = strConvert + valueFormat + ",";
            }

            //Thêm thông tin người sửa và ngày sửa.
            strConvert = strConvert + "\'" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "\'" + ",";
            strConvert = strConvert + "\'Thế Anh\'";

            return strConvert;
        }

        /// <summary>
        /// Gộp dữ liệu lại thành chuỗi để truyền vào truy vấn
        /// Mảng phải lớn hơn 0
        /// </summary>
        /// <param name="employeeLayoutsUpdate">chuỗi nhân viên</param>
        /// CreatedBy: TTANH (02/08/2023)
        public string ConvertEmployeesToStringForQuerySQL(List<EmployeeLayoutUpdateDto> employeeLayoutsUpdate)
        {
            var employeeLayoutsUpdateStrConvert = "";

            foreach (var employeeLayoutUpdate in employeeLayoutsUpdate)
            {
                var employeeLayoutStrMerge = ConvertEmployeeLayoutToStringForQuery(employeeLayoutUpdate);

                employeeLayoutsUpdateStrConvert = employeeLayoutsUpdateStrConvert + "(" + employeeLayoutStrMerge + ")" + ",";
            }

            // Xóa phần tử ngăn cách thừa ở cuối
            employeeLayoutsUpdateStrConvert = employeeLayoutsUpdateStrConvert.Substring(0, employeeLayoutsUpdateStrConvert.Length - 1);

            return employeeLayoutsUpdateStrConvert;
        }

        /// <summary>
        /// Thêm những thông tin không được thay đổi vào mảng thông tin update
        /// </summary>
        /// <param name="employeeLayoutsUpdate">Mảng thông tin update</param>
        /// <returns>Mảng bao gồm dữ liệu cũ + dữ liệu mới</returns>
        /// CreatedBy: TTANH (02/08/2023)
        public async Task<List<EmployeeLayout>> AddOldInforToEmployeeLayouts(List<EmployeeLayoutUpdateDto> employeeLayoutsUpdate)
        {
            var oldEmployeeLayouts = await _employeeLayoutRepository.GetAsync();

            foreach (var employeeLayoutUpdate in employeeLayoutsUpdate)
            {
                var oldEmployeeLayout = oldEmployeeLayouts.Where(e => e.EmployeeLayoutId == employeeLayoutUpdate.EmployeeLayoutId).FirstOrDefault();

                if (oldEmployeeLayout != null)
                {
                    foreach (PropertyInfo propertyInfo in employeeLayoutUpdate.GetType().GetProperties())
                    {
                        var valueNew = propertyInfo.GetValue(employeeLayoutUpdate);

                        propertyInfo.SetValue(oldEmployeeLayout, valueNew, null);
                    }
                }
                else
                {
                    throw new ValidateException();
                }
            }

            return oldEmployeeLayouts.ToList();
        }

        /// <summary>
        /// Hàm cập nhật nhiều bản ghi
        /// </summary>
        /// <param name="employeeLayoutsUpdate">Dữ liệu của các bản ghi cập nhật</param>
        /// <returns>Số hàng bị ảnh hưởng</returns>
        /// Created by: TTANH (02/08/2023)
        public async Task<int> UpdateMultipleAsync(List<EmployeeLayoutUpdateDto> employeeLayoutsUpdate)
        {
            if (employeeLayoutsUpdate.Count() > 0)
            {
                // Gộp dữ liệu lại thành chuỗi để truyền vào truy vấn
                var employeesStrConvert = ConvertEmployeesToStringForQuerySQL(employeeLayoutsUpdate);

                await _employeeLayoutRepository.UpdateMultipleAsync(employeesStrConvert);

                var rowUpdate = employeeLayoutsUpdate.Count();

                return rowUpdate;
            }
            else
            {
                return 0;
            }
        }
        #endregion
    }
}
