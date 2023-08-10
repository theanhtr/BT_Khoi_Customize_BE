using Microsoft.AspNetCore.Http.Features;
using MISA.WebFresher052023.CTM.Domain;
using System.Globalization;
using System.Reflection;

namespace MISA.WebFresher052023.CTM.Application
{
    public class HelperApplication
    {
        /// <summary>
        /// Hàm để đặt thông tin kiểm tra lỗi
        /// </summary>
        /// <param name="messageError">thông tin lỗi</param>
        /// <param name="entity">đối tượng muốn set</param>
        /// CreatedBy: TTANH (21/07/2023)
        public static void SetValidateError(string messageError, BaseValidateDto entity)
        {
            entity.ValidCheck = RecordCheck.Invalid;

            if (entity.ValidateDescription != "")
            {
                entity.ValidateDescription += "; ";
            }

            entity.ValidateDescription += messageError;
        }

        /// <summary>
        /// Chuyển đổi một mảng thành một chuỗi string với phần tử ngăn cách
        /// </summary>
        /// <typeparam name="TType">Loại kiểu dữ liệu</typeparam>
        /// <param name="values">Mảng muốn chuyển</param>
        /// <param name="separatorElement">Phần tử ngăn cách</param>
        /// <returns>Đã được chuyển thành chuỗi với phần tử ngăn cách</returns>
        /// <example>IN: [1, 2, 3] -> "'1','2','3'"</example>
        /// CreatedBy: TTANH (27/07/2023)
        public static string ConvertArrayToStringWithSeparatorElement<TType>(List<TType> values, string separatorElement)
        {
            var strConvert = "";

            foreach (var value in values)
            {
                var valueFormat = "\'" + value?.ToString() + "\'";
                strConvert = strConvert + valueFormat + separatorElement;
            }

            // Xóa phần tử ngăn cách thừa ở cuối
            strConvert = strConvert.Substring(0, strConvert.Length - 1);

            return strConvert;
        }
    }
}
