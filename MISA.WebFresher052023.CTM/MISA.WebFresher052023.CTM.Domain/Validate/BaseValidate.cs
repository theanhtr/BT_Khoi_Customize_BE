using System.Text.RegularExpressions;

namespace MISA.WebFresher052023.CTM.Domain
{
    /// <summary>
    /// Class dùng để validate.
    /// </summary>
    /// CreatedBy: TTANH (14/07/2023)
    public abstract class BaseValidate<TEntity> : IBaseValidate<TEntity>
    {
        #region Fields
        private readonly ICodeRepository<TEntity> _codeRepository;
        #endregion

        #region Constructor
        public BaseValidate(ICodeRepository<TEntity> codeRepository)
        {
            _codeRepository = codeRepository;
        }
        #endregion

        #region Methods
        /// <summary>
        /// Hàm dùng để validate code
        /// </summary>
        /// <param name="code">Code muốn validate</param>
        /// <returns>true nếu không có lỗi</returns>
        /// <exception cref="ValidateException">Nếu có lỗi thì sẽ trả exception</exception>
        /// CreatedBy: TTANH (14/07/2023)
        public async Task<bool> CodeValidate(string code)
        {
            var regexCode = new Regex(Resource.Code_Regex);

            if (!regexCode.IsMatch(code))
            {
                var messageError = string.Format(Resource.Wrong_Format_Code, code);
                throw new ValidateException(StatusErrorCode.WrongFormatCode, messageError, null);
            }

            var checkEntity = await _codeRepository.FindByCodeAsync(code);

            if (checkEntity != null)
            {
                var messageError = string.Format(Resource.Code_Exist, code);
                throw new ValidateException(StatusErrorCode.CodeDuplicate, messageError, null);
            }

            return true;
        }
        #endregion
    }
}
