# Clean architecture

# Entity, Model, Dto

- Entity: Thực thể tương đương 1 bảng trong db
- Model: Khi thêm bớt cột entity
- Dto:

## Kiến trúc đa tầng

Client -> Controller -> BL -> DL -> DB.

## Cấu trúc clean architecture

UI, DB (Frameworks & Drivers) -> Controllers (Interface adapters) -> Use Cases -> Entities.
Lớp trong không biết lớp ngoài là gì và các lớp làm việc thông qua interfaces.

## Các lớp cụ thể

1. Entities
   Là layer trong cùng, quan trọng nhất. Entity chính là các thực thể hay từng đối tượng cụ thể và các rule business logic của nó. Trong OOP đây chính là các Object cùng với các method và properties tuyên thủ các nguyên tắc Encapsulation.

2. Use Cases
   Là layer chứa các business logic ở cấp độ cụ thể từng Use Case (application).
   VD: Use Case đăng ký cần tổ hợp 1 hoặc nhiều Entities.

3. Interface Adapters (Controllers, Gateways)
   Là layer phụ trách việc chuyển đổi format dữ liệu phù hợp từng Use Case và Entities. Các format này có thể dùng bên trong hoặc ngoài ứng dụng.

4. Frameworks & Drivers
   Tầng ngoài cùng phục vụ cho từng như cầu của end user.
   Tầng này chịu trách nhiệm khởi tạo các objects cho các tầng bên trong (Setup Dependencies).

## Áp dụng trong asp.net core api

1. Domain layer

   - Entities.
   - Value objects.
   - Domain services.

   - Cụ thể: IRepo, IUnitOfWork, Entity, Model, Enum, Resource, validate nghiệp vụ, exception, domain service
   - Domain không phụ thuộc vào bất kì tầng nào khác

   IUnitOfWork, Model, domain service

2. Application layer

   - Application services.
   - DTOs.
   - Mappers.

   - Cụ thể: Dto, Service, IService

3. Infrastructure layer

   - những hệ thống ở ngoài.
   - Data access, logging, email, storage.

   - Cụ thể: UnitOfWork, Repository.

4. Presentation layer (User interface)

   - ASP.NET Core web API (project host)
   - Controller, middleware

## Nội dung buổi học

1. Luồng chính đa tầng

   Validate -> Tách nghiệp vụ -> Lưu vào db.
   Mục đích: chia nhỏ code theo từng mục đích nhất định.
   Các lớp chính: Client -> Controller -> BL -> DL -> DB.
   Cần chia thành các project cho rạch ròi.
   AddSingleton gọi lần đầu mới khởi tạo.
   Đa tầng bị phụ thuộc vào DL.

2. Các bước viết api

   - Khai báo Route theo chuẩn restful cho dễ quản lý
     [Route("api/v1/[controller]")]
     [ApiController]
   - Validate dữ liệu
     Có thư viện DataAnnotations để validate dữ liệu, sẽ không trả về theo middleware ExceptionMiddleware mà cần ghi đè.

3. Luồng chính clean architecture
   - Core: Entity, Enum, Resource, Interface (Service - controller gọi, Interface Repository - DB).
   - Infrastructure: Implement Interface Repository.
   - API: Controller

## Chú ý

- Phải giới hạn repo sẽ là employee
- Employee chỉ giới hạn trong domain.
- Application gọi vào Domain (refs), domain không gọi tới đâu cả.
