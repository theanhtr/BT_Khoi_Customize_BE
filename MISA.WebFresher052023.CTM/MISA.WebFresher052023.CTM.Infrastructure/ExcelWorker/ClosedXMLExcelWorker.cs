
using ClosedXML.Excel;
using MISA.WebFresher052023.CTM.Domain;
using MISA.WebFresher052023.CTM.Application;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Wordprocessing;
using Microsoft.AspNetCore.Http;
using System.Globalization;
using DocumentFormat.OpenXml.VariantTypes;

namespace MISA.WebFresher052023.CTM.Infrastructure
{
    public abstract class ClosedXMLExcelWorker<TEntityDto, TEntityExcelDto, TEntityLayoutDto> : IExcelWorker<TEntityDto, TEntityExcelDto, TEntityLayoutDto> where TEntityLayoutDto : ILayoutGetInfo
    {
        #region Methods
        /// <summary>
        /// hàm chuyển đổi dữ liệu đầu vào từ entities thành dữ liệu excel
        /// </summary>
        /// <param name="entitiesDto">Các đối tượng cần chuyển</param>
        /// <param name="titleExport">Tên tiêu đề và tên sheet của file</param>
        /// <param name="headersInfo">Thông tin của các tiêu đề</param>
        /// <returns>Dữ liệu excel</returns>
        /// CreatedBy: TTANH (17/07/2023)
        public byte[] ConvertDataToExcelData(List<TEntityDto> entitiesDto, string? titleExport, List<TEntityLayoutDto> headersInfo)
        {
            using var workbook = new XLWorkbook();

            var worksheet = workbook.Worksheets.Add(titleExport);

            var currentRow = 3;
            var currentColumn = 1;

            // thêm tiêu đề
            var type = typeof(TEntityDto);
            var properties = type.GetProperties();

            foreach (var property in properties)
            {
                // đặt tên tiêu đề
                var propertyName = property.Name;

                var headerInfo = headersInfo.Where(e => propertyName == e.GetServerColumnName()).FirstOrDefault();

                if (headerInfo != null)
                {
                    var headerEle = worksheet.Cell(currentRow, currentColumn);

                    headerEle.Value = headerInfo.GetClientColumnName(Resource.Lang_Code);

                    // tên màu nền và chữ in đậm cho màu nền
                    headerEle.Style.Fill.BackgroundColor = XLColor.FromHtml("#D8D8D8");
                    headerEle.Style.Font.Bold = true;
                    
                    // căn giữa
                    headerEle.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    headerEle.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;

                    //thêm border
                    headerEle.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                    headerEle.Style.Border.OutsideBorderColor = XLColor.Black;

                    currentColumn++;
                }
            }

            currentColumn = 1;

            foreach (var entity in entitiesDto)
            {
                currentRow++;

                foreach (var property in properties)
                {
                    var propertyName = property.Name;
                    var propertyValue = property.GetValue(entity);

                    var headerInfo = headersInfo.Where(e => propertyName == e.GetServerColumnName()).FirstOrDefault();

                    var cell = worksheet.Cell(currentRow, currentColumn);

                    if (propertyName.Contains("Gender"))
                    {
                        var propertyValueStr = propertyValue?.ToString();

                        if (propertyValueStr != null)
                        {
                            if (propertyValueStr.Contains("Female"))
                            {
                                cell.Value = Resource.Gender_Female;
                            }
                            else if (propertyValueStr.Contains("Male"))
                            {
                                cell.Value = Resource.Gender_Male;
                            }
                            else if (propertyValueStr.Contains("Other"))
                            {
                                cell.Value = Resource.Gender_Other;
                            }
                        }
                        else
                        {
                            cell.Value = "";
                        }

                        currentColumn++;
                    }
                    else if (propertyName.Contains("Date"))
                    {
                        var dateTimeTemp = (DateTime?)propertyValue;
                        cell.Value = dateTimeTemp?.ToString(AppConst.FormatDate) ?? "";

                        currentColumn++;
                    }
                    else if (headerInfo != null)
                    {
                        cell.Value = propertyValue?.ToString();

                        currentColumn++;
                    }

                    //thêm border
                    cell.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                    cell.Style.Border.OutsideBorderColor = XLColor.Black;
                }

                currentColumn = 1;
            }

            // cho chiều rộng cột bằng fit content
            worksheet.Columns().AdjustToContents();

            //thêm tên sheet
            var lastColumnUsed = worksheet.LastColumnUsed().ColumnNumber();
            var rangeTitle = worksheet.Range(worksheet.Cell(1, 1), worksheet.Cell(1, lastColumnUsed));

            worksheet.Cell(1, 1).Value = titleExport?.ToUpper();

            rangeTitle.Merge();
            rangeTitle.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            rangeTitle.Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
            rangeTitle.Style.Font.FontSize = 16;
            rangeTitle.Style.Font.Bold = true;


            //tăng chiều cao cho dòng 1: tên sheet và dòng 3: tên cột
            worksheet.Row(1).Height = 35;
            worksheet.Row(3).Height = 30;

            var lastRowUsed = worksheet.LastRowUsed().RowNumber();
            for (var i = 4; i <= lastRowUsed; i++)
            {
                worksheet.Row(i).Height = 26;
            }

            using var stream = new MemoryStream();
            workbook.SaveAs(stream);
            var content = stream.ToArray();
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
            using var workbook = new XLWorkbook(filePath);

            var importExcelSettingData = new ExcelImportSettingData();
            importExcelSettingData.Sheets = new List<string> { };
            importExcelSettingData.HeaderRowIndex = 1;

            foreach (IXLWorksheet worksheet in workbook.Worksheets)
            {
                string sheetName = worksheet.Name;
                importExcelSettingData.Sheets.Add(sheetName);
            }

            var firstWorksheet = workbook.Worksheet(importExcelSettingData.Sheets[0]);
            int lastColumnIndex = firstWorksheet.LastColumnUsed().ColumnNumber();
            int lastRowIndex = firstWorksheet.LastRowUsed().RowNumber();

            for (var r = 1; r <= lastRowIndex; r++)
            {
                var row = firstWorksheet.Row(r);
                var isFindCodeNameHeader = false;

                for (var c = 1; c <= lastColumnIndex; c++)
                {
                    var cell = row.Cell(c);
                    string cellName = cell.GetValue<string>();

                    if (cellName.Contains(headerFind))
                    {
                        importExcelSettingData.HeaderRowIndex = r;
                        isFindCodeNameHeader = true;
                        break;
                    }
                }

                if (isFindCodeNameHeader)
                {
                    break;
                }
            }

            return importExcelSettingData;
        }

        /// <summary>
        /// Kiểm tra xem worksheet có trống không
        /// </summary>
        /// <param name="worksheet">worksheet muốn kiểm tra</param>
        /// <returns>true nếu trống, false nếu không</returns>
        public static bool IsWorksheetEmpty(IXLWorksheet worksheet)
        {
            foreach (var row in worksheet.RowsUsed())
            {
                foreach (var cell in row.CellsUsed())
                {
                    if (!string.IsNullOrWhiteSpace(cell.GetString()))
                    {
                        return false;
                    }
                }
            }

            return true;
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
            using var workbook = new XLWorkbook(filePath);
            var worksheet = workbook.Worksheet(sheetContainsData);

            if (IsWorksheetEmpty(worksheet))
            {
                throw new ValidateException(StatusErrorCode.SheetIsEmpty, Resource.Sheet_Is_Empty, null);
            }

            var columnIndex = 1;
            var headerRow = worksheet.Row(headerRowIndex);
            int lastColumnIndex = worksheet.LastColumnUsed().ColumnNumber();

            var headersInfo = new List<ExcelHeadersInfo> { };

            for (int colIndex = columnIndex; colIndex <= lastColumnIndex; colIndex++)
            {
                var cell = headerRow.Cell(colIndex);
                string headerName = cell.GetValue<string>();

                if (!string.IsNullOrEmpty(headerName))
                {
                    headersInfo.Add(new ExcelHeadersInfo(colIndex, headerName));
                }
            }

            return headersInfo;
        }

        /// <summary>
        /// Đọc dữ liệu từ file excel
        /// </summary>
        /// <param name="filePath">đường dẫn tới file</param>
        /// <param name="sheetUsed">sheet tương tác</param>
        /// <param name="headerRowIndex">vị trí của tiêu đề</param>
        /// <param name="excelHeadersMapColumns">cột header ứng với dữ liệu</param>
        /// <returns>Trả về list dữ liệu insert, update excel</returns>
        /// CreatedBy: TTANH (19/07/2023)
        public List<TEntityExcelDto> ReadExcelFile(string filePath, string sheetUsed, int headerRowIndex, List<ExcelHeaderMapColumn> excelHeadersMapColumns)
        {
            using var workbook = new XLWorkbook(filePath);
            var worksheet = workbook.Worksheet(sheetUsed);

            var rowIndex = headerRowIndex + 1;
            var lastRowUsed = worksheet.LastRowUsed().RowNumber();

            var totalRecord = lastRowUsed - rowIndex + 1;

            var entities = new List<TEntityExcelDto>();

            for (int i = 0; i < totalRecord; i++)
            {
                var entity = (TEntityExcelDto)Activator.CreateInstance(typeof(TEntityExcelDto));

                entities.Add(entity);
            }

            var currentEntityIndex = 0;
            var indexColumn = 0;

            foreach (var excelHeaderMapColumn in excelHeadersMapColumns)
            {
                currentEntityIndex = 0;

                for (int r = rowIndex; r <= lastRowUsed; r++)
                {
                    var currentRow = worksheet.Row(r);
                    var cell = currentRow.Cell(excelHeaderMapColumn.HeaderColumnIndex);

                    var propertyInfo = entities[currentEntityIndex].GetType().GetProperty(excelHeaderMapColumn.ServerColumnName);

                    if (propertyInfo != null)
                    {
                        var typeOfProperty = propertyInfo.PropertyType;

                        var cellValueRaw = cell.Value;

                        var cellValueString = cell.GetValue<string>();

                        if (!string.IsNullOrEmpty(cellValueString))
                        {
                            if (propertyInfo.Name == "Gender")
                            {
                                if (cellValueString.Contains(Resource.Gender_Male))
                                {
                                    propertyInfo.SetValue(entities[currentEntityIndex], Gender.Male, null);
                                }
                                else if (cellValueString.Contains(Resource.Gender_Female))
                                {
                                    propertyInfo.SetValue(entities[currentEntityIndex], Gender.Female, null);
                                }
                                else if (cellValueString.Contains(Resource.Gender_Other))
                                {
                                    propertyInfo.SetValue(entities[currentEntityIndex], Gender.Other, null);
                                }
                                else
                                {
                                    propertyInfo.SetValue(entities[currentEntityIndex], null, null);
                                }
                            }
                            else if (propertyInfo.Name.Contains("Date"))
                            {
                                try
                                {
                                    var formatValue = DateTime.ParseExact(cellValueString, AppConst.FormatDate, CultureInfo.InvariantCulture);

                                    propertyInfo.SetValue(entities[currentEntityIndex], formatValue, null);
                                }
                                catch
                                {
                                    var messageError = string.Format(Resource.Wrong_Format_Date, AppConst.FormatDate);

                                    throw new ValidateException(StatusErrorCode.WrongFormatDate, messageError, null);
                                }
                            }
                            else
                            {
                                try
                                {
                                    var cellValueFormat = new object();

                                    if (typeOfProperty == typeof(bool) || typeOfProperty == typeof(bool?))
                                    {
                                        bool booleanValue;
                                        cellValueRaw.TryConvert(out booleanValue);
                                        cellValueFormat = booleanValue;
                                    }
                                    else if (typeOfProperty == typeof(byte) || typeOfProperty == typeof(byte?))
                                    {
                                        cellValueFormat = cell.GetValue<byte?>();
                                    }
                                    else if (typeOfProperty == typeof(short) || typeOfProperty == typeof(short?))
                                    {
                                        cellValueFormat = cell.GetValue<short?>();
                                    }
                                    else if (typeOfProperty == typeof(int) || typeOfProperty == typeof(int?))
                                    {
                                        cellValueFormat = cell.GetValue<int?>();
                                    }
                                    else if (typeOfProperty == typeof(long) || typeOfProperty == typeof(long?))
                                    {
                                        cellValueFormat = cell.GetValue<long?>();
                                    }
                                    else if (typeOfProperty == typeof(float) || typeOfProperty == typeof(float?))
                                    {
                                        cellValueFormat = cell.GetValue<float?>();
                                    }
                                    else if (typeOfProperty == typeof(double) || typeOfProperty == typeof(double?))
                                    {
                                        cellValueFormat = cell.GetValue<double?>();
                                    }
                                    else if (typeOfProperty == typeof(decimal) || typeOfProperty == typeof(decimal?))
                                    {
                                        cellValueFormat = cell.GetValue<decimal?>();
                                    }
                                    else
                                    {
                                        cellValueFormat = cellValueString;
                                    }

                                    propertyInfo.SetValue(entities[currentEntityIndex], cellValueFormat, null);
                                }
                                catch
                                {
                                    throw new ValidateException();
                                }
                            }
                        }
                        else
                        {
                            try
                            {
                                propertyInfo.SetValue(entities[currentEntityIndex], null, null);
                            }
                            catch
                            {
                                throw new ValidateException(StatusErrorCode.ExcelHeaderRequiredNotMap, Resource.Excel_Header_Required_Not_Map, null);
                            }
                        }
                    }

                    // dùng để set dòng chứa dữ liệu này, index = 0 vì chỉ set lần đầu duyệt qua
                    if (indexColumn == 0)
                    {
                        var excelRowIndexProperty = entities[currentEntityIndex].GetType().GetProperty("ExcelRowIndex");

                        if (propertyInfo != null)
                        {
                            excelRowIndexProperty.SetValue(entities[currentEntityIndex], r, null);
                        }
                    }

                    currentEntityIndex++;
                }

                indexColumn++;
            }

            return entities;
        }
        #endregion
    }
}
