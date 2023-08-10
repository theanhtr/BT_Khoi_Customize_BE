using NSubstitute;
using NUnit.Framework;

namespace MISA.WebFresher052023.CTM.Domain.Tests
{
    public class EmployeeValidateTests
    {
        #region Properties
        private IEmployeeRepository _employeeRepository;

        private IEmployeeValidate _employeeValidate;
        #endregion

        #region SetUp
        [SetUp]
        public void SetUp()
        {
            _employeeRepository = Substitute.For<IEmployeeRepository>();

            _employeeValidate = new EmployeeValidate(_employeeRepository);
        }
        #endregion


        #region Testcases
        /// <summary>
        /// Kiểm tra với code sai định dạng
        /// </summary>
        /// CreatedBy: TTANH (24/07/2023)
        [Test]
        public async Task CodeValidate_CodeRegex_ThrowException()
        {
            //Arrange
            var code = "NV-1001A";
            var expectedMessage = string.Format(Resource.Wrong_Format_Code, code);

            // Act & Assert
            var exception = Assert.ThrowsAsync<ValidateException>(async () => await _employeeValidate.CodeValidate(code));

            Assert.That(exception.ErrorMessage, Is.EqualTo(expectedMessage));
        }

        /// <summary>
        /// Kiểm tra với code đã tồn tại
        /// </summary>
        /// CreatedBy: TTANH (24/07/2023)
        [Test]
        public async Task CodeValidate_CodeExist_ThrowException()
        {
            //Arrange
            var code = "NV-1001";
            var expectedMessage = string.Format(Resource.Code_Exist, code);

            var employee = new Employee();

            _employeeRepository.FindByCodeAsync(code).Returns(employee);

            // Act & Assert
            var exception = Assert.ThrowsAsync<ValidateException>(async () => await _employeeValidate.CodeValidate(code));

            Assert.That(exception.ErrorMessage, Is.EqualTo(expectedMessage));

            await _employeeRepository.Received(1).FindByCodeAsync(code);
        }

        /// <summary>
        /// Kiểm tra không có lỗi
        /// </summary>
        /// CreatedBy: TTANH (24/07/2023)
        [Test]
        public async Task CodeValidate_Success()
        {
            //Arrange
            var code = "NV-1006";

            var employee = new Employee();

            _employeeRepository.FindByCodeAsync(code).Returns(employee);

            // Act & Assert
            var result =  await _employeeValidate.CodeValidate(code);

            Assert.That(result, Is.True);

            await _employeeRepository.Received(1).FindByCodeAsync(code);
        }
        #endregion

    }
}