using MISA.WebFresher052023.CTM.Domain;

namespace MISA.WebFresher052023.CTM
{
    /// <summary>
    /// Lớp xử lí lỗi 
    /// </summary>
    /// Created By: TTANH (12/07/2023)
    public class ExceptionMiddleware
    {
        /// <summary>
        /// Biến lưu trữ middleware tiếp theo trong pipeline
        /// </summary>
        private readonly RequestDelegate _next;
        public ExceptionMiddleware(RequestDelegate next) { _next = next; }

        /// <summary>
        /// xử lí yêu cầu HTTP, nếu có ngoại lệ xảy ra
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        /// Created By: TTANH (12/07/2023)
        public async Task Invoke(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(context, ex);
            }
        }

        /// <summary>
        /// Phương thức xử lí ngoại lệ
        /// </summary>
        /// <param name="context"></param>
        /// <param name="exception"></param>
        /// <returns></returns>
        /// Created By: TTANH (12/07/2023)
        private async Task HandleExceptionAsync(HttpContext context, Exception exception)
        {
            context.Response.ContentType = "application/json";
            if (exception is NotFoundException)
            {
                context.Response.StatusCode = StatusCodes.Status404NotFound;
                await context.Response.WriteAsync(text: new BaseException()
                {
                    ErrorCode = (int)((NotFoundException)exception).ErrorCode,
                    DevMessage = ((NotFoundException)exception).ErrorMessage ?? Resource.Exception_NotFound_Default,
                    UserMessage = ((NotFoundException)exception).ErrorMessage ?? Resource.Exception_NotFound_Default,
                    TraceId = context.TraceIdentifier,
                    MoreInfo = exception.HelpLink,
                    Data = { }
                }.ToString() ?? "");
            }
            else if (exception is ValidateException)
            {
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
                await context.Response.WriteAsync(text: new BaseException()
                {
                    ErrorCode = (int)((ValidateException)exception).ErrorCode,
                    DevMessage = ((ValidateException)exception).ErrorMessage ?? Resource.Exception_Validate_Default,
                    UserMessage = ((ValidateException)exception).ErrorMessage ?? Resource.Exception_Validate_Default,
                    TraceId = context.TraceIdentifier,
                    MoreInfo = exception.HelpLink,
                    Data = ((ValidateException)exception).Data
                }.ToString() ?? "");
            }
            else
            {
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                await context.Response.WriteAsync(
                    text: new BaseException()
                    {
                        ErrorCode = context.Response.StatusCode,
                        DevMessage = exception.Message,
                        UserMessage = Resource.Exception_System_Default,
                        TraceId = context.TraceIdentifier,
                        MoreInfo = exception.HelpLink
                    }.ToString() ?? ""
                );
            }
        }
    }
}
