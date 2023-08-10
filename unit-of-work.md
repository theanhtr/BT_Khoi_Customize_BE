# Unit of Work

## Định nghĩa

- Là 1 kỹ thuật để đảm bảo tất cả request tới db có liên quan tới nhau đều được thực hiện trên cùng 1 DbContext.

## DbContext

- DbContext là một thực thể đại diện cho một phiên làm việc với database, dùng để query và lưu dữ liệu của bạn.
- Mỗi khi có 1 request mới từ browser, 1 DbContext mới sẽ được tạo ra, và sẽ bị dispose khi return response cho browser
- Khi thay đổi dữ liệu sẽ không được đưa xuống db ngay mà phải qua xử lý của dbContext.
- Gọi hàm SaveChanges() thì những thay đổi này sẽ được đưa xuống DB.
