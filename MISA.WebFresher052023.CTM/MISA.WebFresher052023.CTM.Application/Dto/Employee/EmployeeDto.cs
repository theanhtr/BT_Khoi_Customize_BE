using MISA.WebFresher052023.CTM.Domain;
using System.ComponentModel.DataAnnotations;

namespace MISA.WebFresher052023.CTM.Application
{
    /// <summary>
    /// Dto trả về của nhân viên
    /// </summary>
    public class EmployeeDto
    {
        #region Property
        /// <summary>
        /// Id của nhân viên
        /// </summary>
        public Guid EmployeeId { get; set; }

        /// <summary>
        /// Mã code của nhân viên
        /// </summary>
        public string EmployeeCode { get; set; }

        /// <summary>
        /// Tên của nhân viên
        /// </summary>
        public string FullName { get; set; }

        /// <summary>
        /// Id của phòng ban
        /// </summary>
        public Guid DepartmentId { get; set; }

        /// <summary>
        /// Mã code của phòng ban
        /// </summary>
        public string DepartmentCode { get; set; }

        /// <summary>
        /// Tên của phòng ban
        /// </summary>
        public string DepartmentName { get; set; }

        /// <summary>
        /// Giới tính của nhân viên
        /// </summary>
        public Gender? Gender { get; set; }

        /// <summary>
        /// Ngày sinh của nhân viên
        /// </summary>
        public DateTime? DateOfBirth { get; set; }

        /// <summary>
        /// Chức danh của nhân viên
        /// </summary>
        public string? Position { get; set; }

        /// <summary>
        /// Thuộc tính là khách hàng, nhà cung cấp của nhân viên
        /// </summary>
        public string? SupplierCustomerGroup { get; set; }

        /// <summary>
        /// Số CMND của nhân viên
        /// </summary>
        public string? IdentityNumber { get; set; }

        /// <summary>
        /// Ngày cấp CMND của nhân viên
        /// </summary>
        public DateTime? IdentityDate { get; set; }

        /// <summary>
        /// Nơi cấp CMND của nhân viên
        /// </summary>
        public string? IdentityPlace { get; set; }

        /// <summary>
        /// TK công nợ phải trả của nhân viên
        /// </summary>
        public string? PayAccount { get; set; }

        /// <summary>
        /// TK công nợ phải thu của nhân viên
        /// </summary>
        public string? ReceiveAccount { get; set; }

        /// <summary>
        /// Lương thỏa thuận của nhân viên
        /// </summary>
        public double? Salary { get; set; }

        /// <summary>
        /// Hệ số lương của nhân viên
        /// </summary>
        public double? SalaryCoefficients { get; set; }

        /// <summary>
        /// Lương đóng bảo hiểm của nhân viên
        /// </summary>
        public double? SalaryPaidForInsurance { get; set; }

        /// <summary>
        /// Mã số thuế của nhân viên
        /// </summary>
        public string? PersonalTaxCode { get; set; }

        /// <summary>
        /// Loại hợp đồng của nhân viên
        /// </summary>
        public string? TypeOfContract { get; set; }

        /// <summary>
        /// Số người phụ thuộc
        /// </summary>
        public int? NumberOfDependents { get; set; }

        /// <summary>
        /// Số tài khoản ngân hàng của nhân viên
        /// </summary>
        public string? AccountNumber { get; set; }

        /// <summary>
        /// Tên ngân hàng
        /// </summary>
        public string? BankName { get; set; }

        /// <summary>
        /// Chi nhánh ngân hàng
        /// </summary>
        public string? BankBranch { get; set; }

        /// <summary>
        /// Tỉnh/TP của ngân hàng
        /// </summary>
        public string? BankProvince { get; set; }

        /// <summary>
        /// Địa chỉ của nhân viên
        /// </summary>
        public string? ContactAddress { get; set; }

        /// <summary>
        /// Điện thoại di động của nhân viên
        /// </summary>
        public string? ContactPhoneNumber { get; set; }

        /// <summary>
        /// ĐT cố định của nhân viên
        /// </summary>
        public string? ContactLandlinePhoneNumber { get; set; }

        /// <summary>
        /// Email của nhân viên
        /// </summary>
        public string? ContactEmail { get; set; }
        #endregion
    }
}
