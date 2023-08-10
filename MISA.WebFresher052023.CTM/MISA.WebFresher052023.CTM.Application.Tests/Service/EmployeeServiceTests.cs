using AutoMapper;
using MISA.WebFresher052023.CTM.Domain;
using NSubstitute;

namespace MISA.WebFresher052023.CTM.Application.Tests
{
    public class EmployeeServiceTests
    {
        #region Properties
        private IEmployeeService _employeeService;

        private IEmployeeRepository _employeeRepository;

        private IDepartmentRepository _departmentRepository;

        private IMapper _mapper;

        private IEmployeeValidate _employeeValidate;

        private IEmployeeLayoutService _employeeLayoutService;
        #endregion

        #region SetUp
        [SetUp]
        public void SetUp()
        {
            _departmentRepository = Substitute.For<IDepartmentRepository>();

            _employeeLayoutService = Substitute.For<IEmployeeLayoutService>();

            _employeeRepository = Substitute.For<IEmployeeRepository>();

            _mapper = Substitute.For<IMapper>();

            _employeeValidate = Substitute.For<IEmployeeValidate>();

            _employeeService = new EmployeeService(_employeeRepository, _mapper, _employeeValidate, _departmentRepository, _employeeLayoutService);
        } 
        #endregion


        #region Testcases
        /// <summary>
        /// Kiểm tra xóa một mảng rỗng
        /// </summary>
        /// CreatedBy: TTANH (24/07/2023)
        [Test]
        public async Task DeleteMultipleAsync_EmptyIdsList_ThrowException()
        {
            //Arrange
            var ids = new List<Guid>();
            var expectedMessage = Resource.Delete_Empty_Error;

            // Act & Assert
            var exception = Assert.ThrowsAsync<ValidateException>(async () => await _employeeService.DeleteMultipleAsync(ids));

            Assert.That(exception.ErrorMessage, Is.EqualTo(expectedMessage));
        }

        /// <summary>
        /// Kiểm tra xóa 10 nhân viên, nhưng không tìm thấy
        /// </summary>
        /// CreatedBy: TTANH (24/07/2023)
        [Test]
        public async Task DeleteMultipleAsync_List10Items_ThrowException()
        {
            //Arrange
            var ids = Enumerable.Range(0, 10)
                     .Select(_ => Guid.NewGuid())
                     .ToList();

            var employees = Enumerable.Range(0, 10)
                                   .Select(_ => new Employee())
                                   .ToList();

            _employeeRepository.GetListByIdsAsync(ids).Returns(employees);

            var expectedMessage = Resource.Exception_NotFound_Default;

            var exception = Assert.ThrowsAsync<NotFoundException>(async () => await _employeeService.DeleteMultipleAsync(ids));

            Assert.That(exception.ErrorMessage, Is.EqualTo(expectedMessage));

            await _employeeRepository.Received(1).GetListByIdsAsync(ids);
        }

        /// <summary>
        /// Kiểm tra xóa 10 và thành công
        /// </summary>
        /// CreatedBy: TTANH (24/07/2023)
        [Test]
        public async Task DeleteMultipleAsync_List10Items_Success()
        {
            //Arrange
            var ids = Enumerable.Range(0, 10)
                     .Select(_ => Guid.NewGuid())
                     .ToList();

            var expectedDeleted = 10;

            var employees = Enumerable.Range(0, 10)
                                   .Select(_ => new Employee())
                                   .ToList();

            _employeeRepository.GetListByIdsAsync(ids).Returns(employees);

            _employeeRepository.DeleteMultipleAsync(employees).Returns(10);

            var result = await _employeeService.DeleteMultipleAsync(ids);

            Assert.That(result, Is.EqualTo(expectedDeleted));

            await _employeeRepository.Received(1).DeleteMultipleAsync(employees);
        }
        #endregion

    }
}