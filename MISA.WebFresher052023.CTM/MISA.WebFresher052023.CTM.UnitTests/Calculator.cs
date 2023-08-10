namespace MISA.WebFresher052023.CTM.UnitTests
{
    public class Calculator
    {
        #region Methods
        /// <summary>
        /// Hàm cộng 2 số
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <returns>Giá trị tổng của 2 số</returns>
        /// CreatedBy: TTANH (13/07/2023)
        public long Add(int x, int y)
        {
            return x + (long)y;
        }

        /// <summary>
        /// Hàm cộng tổng các số trong 1 string
        /// </summary>
        /// <param name="inputString">Chuỗi đầu vào cách nhau bởi dấu ,</param>
        /// <returns>Giá trị tổng của các số trong string</returns>
        /// <exception cref="Exception">Đầu vào không phải là số</exception>
        /// <exception cref="Exception">Không chấp nhận toán tử âm: </exception>
        /// CreatedBy: TTANH (13/07/2023)
        public long Add(string inputString)
        {
            bool isNegativeInput = false;

            long sum = 0;
            string[] inputStrings = inputString.Split(',');

            string negativeString = "";

            foreach (string input in inputStrings)
            {
                try
                {
                    var inputNumber = (long)0;

                    if (input.Trim() == "")
                    {
                        inputNumber = (long)0;
                    }
                    else
                    {
                        inputNumber = Int64.Parse(input);
                    }
                     

                    if (isNegativeInput)
                    {
                        if (inputNumber < 0)
                        {
                            negativeString += ", " + inputNumber;
                        }
                        else
                        {
                            
                        }
                    }
                    else
                    {
                        if (inputNumber < 0)
                        {
                            isNegativeInput = true;
                            negativeString = " " + inputNumber;
                        }
                        else
                        {
                            sum += inputNumber;
                        }
                    }
                }
                catch
                {
                    throw new Exception("Đầu vào không phải là số");
                }
            }

            if (negativeString.Length > 0)
            {
                throw new Exception("Không chấp nhận toán tử âm:" + negativeString);
            }
            else
            {
                return sum;
            }
        }

        /// <summary>
        /// Hàm trừ 2 số
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <returns>Giá trị hiệu của 2 số</returns>
        /// CreatedBy: TTANH (13/07/2023)
        public long Sub(int x, int y)
        {
            return x - (long)y;
        }

        /// <summary>
        /// Hàm nhân 2 số
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <returns>Giá trị tích của 2 số</returns>
        /// CreatedBy: TTANH (13/07/2023)
        public long Mul(int x, int y)
        {
            return x * (long)y;
        }

        /// <summary>
        /// Hàm chia 2 số
        /// </summary>
        /// <param name="x">Số nguyên x</param>
        /// <param name="y">Số nguyên y</param>
        /// <returns>Giá trị thương của 2 số</returns>
        /// <exception cref="Exception">Không chia được cho 0</exception>
        /// CreatedBy: TTANH (13/07/2023)
        public double Div(int x, int y)
        {
            if (y == 0)
            {
                throw new Exception("Không chia được cho 0");
            }

            return x / (double)y;
        }
        #endregion
    }
}
