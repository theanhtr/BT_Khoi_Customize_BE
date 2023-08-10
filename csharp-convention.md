| Loại                                 |                Convention                 |                                  Chú ý |
| ------------------------------------ | :---------------------------------------: | -------------------------------------: |
| Tên biến                             |  PascalCase, không có các kí tự (, - \_)  | trừ trường hợp private field, internal |
| namespace, class, member             |                PascalCase                 |                                        |
| tham số của 1 hàm, tên biến (inline) |                 camelCase                 |                                        |
| Class                                | PascalCase, không có prefix để phân biệt. |                                        |
| Collection/Exception/Attribute       | thêm các từ này tương ứng vào cuối class. |                                        |
| interface                            |              prefix với từ I              |                                        |
| tham số kiểu Generic                 |               prefix bởi T                |                         TKey, TSession |
| enum, method, Property, Resource     |                PascalCase                 |                           Is, Can, Has |
| Event                                |          suffix là EventHandler           |                                        |
| dấu ngoặc đơn để tạo mệnh đề         |    if ((val1 > val2) && (val1 > val3))    |                                        |

- Không dùng Exception để điều khiển luồng logic ứng dụng bởi vì throw exception là một câu lệnh rất tốn kém tài nguyên.
- Tránh việc AddHandler mà không có RemoveHandler tường mình vì có thể dẫn đến MemoryLeak khi đối tượng được AddHandler sống lâu hơn đối tượng chứa Handler.

+) nếu mà chia vào repository rồi thì có cần bỏ phụ thuộc new MySqlConnection
+) nếu có xử lý lỗi r thì có cần try catch không
