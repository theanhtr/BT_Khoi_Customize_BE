using Microsoft.AspNetCore.Mvc;
using System.Net;
using MISA.WebFresher052023.CTM.Infrastructure;
using MISA.WebFresher052023.CTM.Domain;
using MISA.WebFresher052023.CTM.Application;
using MISA.WebFresher052023.CTM;
using Hangfire;
using Hangfire.MySql;
using System.Reflection;
using Microsoft.Extensions.Hosting;
using System.Globalization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddCors(p => p.AddPolicy("MyCors", build =>
{
    //nếu mà dùng AllowCredentials thì không thể dùng origin là * do bảo mật
    build.WithOrigins("http://localhost:5173").AllowCredentials().AllowAnyMethod().AllowAnyHeader().WithExposedHeaders("Content-Disposition");
}));

builder.Services.AddControllers()
    .ConfigureApiBehaviorOptions(options =>
    {
        options.InvalidModelStateResponseFactory = actionContext =>
        {
            var modelState = actionContext.ModelState;
            var errors = new Dictionary<string, string>();

            foreach (var entry in modelState)
            {
                var key = entry.Key;
                var valueErrors = entry.Value.Errors.Select(error => error.ErrorMessage);
                var errorMessage = string.Join(", ", valueErrors);

                errors[key] = errorMessage;
            }

            return new BadRequestObjectResult(new BaseException
            {
                ErrorCode = (int)HttpStatusCode.BadRequest,
                DevMessage = Resource.Validate_User_Input_Error,
                UserMessage = Resource.Validate_User_Input_Error,
                TraceId = "",
                MoreInfo = "",
                Data = errors,
            });
        };
    })
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = null;
        options.JsonSerializerOptions.Converters.Add(new LocalTimeZoneConverter());
    });

builder.Services.AddDistributedMemoryCache();

builder.Services.AddSession(options =>
{
    //thời gian chờ trước khi bị hủy bỏ
    options.IdleTimeout = TimeSpan.FromMinutes(AppConst.ExpiredTime);
});

var dbConnectionString = builder.Configuration.GetConnectionString("DatabaseConnection");
var redisConnectionString = builder.Configuration.GetConnectionString("RedisConnection");

// Thêm Hangfire để xử lý background job
builder.Services.AddHangfire(config => config
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UseStorage(
        new MySqlStorage(
            dbConnectionString,
                new MySqlStorageOptions
                {
                    QueuePollInterval = TimeSpan.FromSeconds(10), // kiểm tra hàng đợi thực thi
                    JobExpirationCheckInterval = TimeSpan.FromHours(1), // kiểm tra công việc hết hạn
                    CountersAggregateInterval = TimeSpan.FromMinutes(5), // cập nahạt thống kê
                    PrepareSchemaIfNecessary = true, // tự động chuẩn bị db
                    DashboardJobListLimit = 25000, // giới hạn số lượng công việc
                    TransactionTimeout = TimeSpan.FromMinutes(1), // thời gian tối đa để thực hiện
                    TablesPrefix = "Hangfire", //phân biệt bảng hangfire trong database
                }
            )
        )
    );

builder.Services.AddHangfireServer();

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

builder.Services.AddScoped<ICacheService>(option => new CacheService(redisConnectionString));

// thêm Localization cho đa ngôn ngữ
builder.Services.AddLocalization();
var localizationOptions = new RequestLocalizationOptions();

var supportedCultures = new[]
{
    new CultureInfo("en"),
    new CultureInfo("vi"),
};

localizationOptions.SupportedCultures = supportedCultures;
localizationOptions.SupportedUICultures = supportedCultures;
localizationOptions.SetDefaultCulture("en");
localizationOptions.ApplyCurrentCultureToResponseHeaders = true;

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<IUnitOfWork>(option => new UnitOfWork(dbConnectionString));

builder.Services.AddTransient<IScheduleService, ScheduleService>();

builder.Services.AddScoped<IEmployeeService, EmployeeService>();
builder.Services.AddScoped<IEmployeeValidate, EmployeeValidate>();
builder.Services.AddScoped<IEmployeeRepository, EmployeeRepository>();
builder.Services.AddScoped<IExcelService<EmployeeExcelDto, EmployeeLayoutDto>, EmployeeExcelService>();

builder.Services.AddScoped<IDepartmentService, DepartmentService>();
builder.Services.AddScoped<IDepartmentValidate, DepartmentValidate>();
builder.Services.AddScoped<IDepartmentRepository, DepartmentRepository>();

builder.Services.AddScoped<IEmployeeLayoutService, EmployeeLayoutService>();
builder.Services.AddScoped<IEmployeeLayoutValidate, EmployeeLayoutValidate>();
builder.Services.AddScoped<IEmployeeLayoutRepository, EmployeeLayoutRepository>();

builder.Services.AddScoped<IExcelWorker<EmployeeDto, EmployeeExcelDto, EmployeeLayoutDto>, EmployeeExcelWorker>();

builder.Services.AddScoped<IFileService, FileService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.UseSession();

app.UseHangfireDashboard();
app.MapHangfireDashboard();

var rootPath = Path.GetDirectoryName(Assembly.GetEntryAssembly().Location.Substring(0, Assembly.GetEntryAssembly().Location.IndexOf("bin\\")));

var clientFolderStore = Path.Combine(rootPath, AppConst.ClientFolderStoreName);

RecurringJob.AddOrUpdate<IScheduleService>(scheduleService => scheduleService.ClearFiles(clientFolderStore), AppConst.CronJobTime);

app.UseCors("MyCors");

// thêm localization
app.UseRequestLocalization(localizationOptions);
app.UseMiddleware<LocalizationMiddleware>();

app.MapControllers();

app.UseMiddleware<ExceptionMiddleware>();

app.Run();
