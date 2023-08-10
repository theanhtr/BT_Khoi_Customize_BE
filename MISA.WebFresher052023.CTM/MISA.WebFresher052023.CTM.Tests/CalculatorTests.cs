using MISA.WebFresher052023.CTM.UnitTests;

namespace MISA.WebFresher052023.CTM.Tests
{
    [TestFixture]
    public class CalculatorTests
    {
        #region Fields
        private Calculator _calculator;
        #endregion

        #region Methods
        [SetUp]
        public void SetUp()
        {
            _calculator = new Calculator();
        }

        /// <summary>
        /// Hàm test đầu vào đúng cho hàm Add(int x, int y)
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <param name="expectedResult">Giá trị mong muốn</param>
        /// CreatedBy: TTANH (13/07/2023)
        [TestCase(1, 2, 3)]
        [TestCase(2, 3, 5)]
        [TestCase(int.MaxValue, 4, int.MaxValue + (long)4)]
        public void Add_ValidInput_ValidResult(int x, int y, long expectedResult)
        {
            // Act: gọi đến hàm cần test
            var actualResult = _calculator.Add(x, y);

            // Assert: so sánh kết quả trả về
            Assert.That(actualResult, Is.EqualTo(expectedResult));
        }

        /// <summary>
        /// Hàm test đầu vào đúng cho hàm Sub(int x, int y)
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <param name="expectedResult">Giá trị mong muốn</param>
        /// CreatedBy: TTANH (13/07/2023)
        [TestCase(1, 2, -1)]
        [TestCase(2, 3, -1)]
        [TestCase(int.MaxValue, int.MinValue, int.MaxValue - (long)int.MinValue)]
        [TestCase(int.MaxValue, int.MaxValue, 0)]
        public void Sub_ValidInput_ValidResult(int x, int y, long expectedResult)
        {
            // Act: gọi đến hàm cần test
            var actualResult = _calculator.Sub(x, y);

            // Assert: so sánh kết quả trả về
            Assert.That(actualResult, Is.EqualTo(expectedResult));
        }

        /// <summary>
        /// Hàm test đầu vào đúng cho hàm Mul(int x, int y)
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <param name="expectedResult">Giá trị mong muốn</param>
        /// CreatedBy: TTANH (13/07/2023)
        [TestCase(1, 2, 2)]
        [TestCase(2, 3, 6)]
        [TestCase(int.MaxValue, int.MinValue, int.MaxValue * (long)int.MinValue)]
        public void Mul_ValidInput_ValidResult(int x, int y, long expectedResult)
        {
            // Act: gọi đến hàm cần test
            var actualResult = _calculator.Mul(x, y);

            // Assert: so sánh kết quả trả về
            Assert.That(actualResult, Is.EqualTo(expectedResult));
        }

        /// <summary>
        /// Hàm test chia cho 0 cho hàm Div(int x, int y)
        /// </summary>
        /// CreatedBy: TTANH (13/07/2023)
        [Test]
        public void Div_DividedByZero_ReturnsException()
        {
            //Arrange
            var x = 1;
            var y = 0;
            var expectedExceptionMessage = "Không chia được cho 0";

            var handler = () => _calculator.Div(x, y);

            // Assert: so sánh kết quả trả về
            var exception = Assert.Throws<Exception>(() => handler());

            Assert.That(exception.Message, Is.EqualTo(expectedExceptionMessage));
        }

        /// <summary>
        /// Hàm test đầu vào đúng cho hàm Div(int x, int y)
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <param name="expectedResult">Giá trị mong muốn</param>
        /// CreatedBy: TTANH (13/07/2023)
        [TestCase(1, 2, 0.5)]
        [TestCase(2, 3, 0.6666)]
        [TestCase(int.MaxValue, int.MinValue, int.MaxValue / (double)int.MinValue)]
        public void Div_ValidInput_ValidResult(int x, int y, double expectedResult)
        {
            // Act: gọi đến hàm cần test
            var actualResult = _calculator.Div(x, y);

            // Assert: so sánh kết quả trả về
            Assert.That(Math.Abs(actualResult - expectedResult), Is.LessThan(1e-3));
        }

        /// <summary>
        /// Hàm test đầu vào đúng cho hàm Add(string inputString)
        /// </summary>
        /// <param name="inputString">Chuỗi đầu vào cách nhau bởi dấu ,</param>
        /// <param name="expectedResult">Giá trị mong muốn</param>
        /// CreatedBy: TTANH (13/07/2023)
        [TestCase("1, 2, 3", 6)]
        [TestCase("9,                                                                         6,2", 17)]
        [TestCase("2, 123, 10", 135)]
        [TestCase("-0, 123, 10", 133)]
        [TestCase(", 123, 10", 133)]
        [TestCase("", 0)]
        public void Add_ValidInput_ValidResult(string inputString, long expectedResult)
        {
            // Act: gọi đến hàm cần test
            var actualResult = _calculator.Add(inputString);

            // Assert: so sánh kết quả trả về
            Assert.That(actualResult, Is.EqualTo(expectedResult));
        }

        /// <summary>
        /// Hàm test đầu vào sai cho hàm Add(string inputString)
        /// </summary>
        /// <param name="inputString">Chuỗi đầu vào cách nhau bởi dấu ,</param>
        /// <param name="expectedExceptionMessage">ErrorMessage mong muốn</param>
        /// CreatedBy: TTANH (13/07/2023)
        [TestCase("1, -2, -3", "Không chấp nhận toán tử âm: -2, -3")]
        [TestCase("-2, -123, -10", "Không chấp nhận toán tử âm: -2, -123, -10")]
        [TestCase("int.MaxValue, int.MaxValue", "Đầu vào không phải là số")]
        [TestCase("-, 1", "Đầu vào không phải là số")]
        [TestCase("Anh Cuờng ơi, cưới vợ thôi anh, em muốn dự đám cưới của anh trước khi bị out GĐ2 :3333", "Đầu vào không phải là số")]
        public void Add_InValidInput_ValidResult(string inputString, string expectedExceptionMessage)
        {
            var handler = () => _calculator.Add(inputString);

            // Assert: so sánh kết quả trả về
            var exception = Assert.Throws<Exception>(() => handler());

            Assert.That(exception.Message, Is.EqualTo(expectedExceptionMessage));
        }
        #endregion
    }
}
