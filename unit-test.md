# Unit test

## Khái niệm

A. Test

1. Hộp đen:

   - e2e: có giao diện rồi, kiểm tra kết quả, luồng.
   - api: kiểm thử api.

2. Hộp trắng:

   - Unit test: biết luồng của code và test theo hướng của mình muốn.
   - Intergration test.

B. Unit test

- Viết unit test trước
- Dùng để test một đơn vị code (unit) thông quá số lượng logical path

- NUnit, xUnit

B. Thực hành

1.  - [Test] 1 test duy nhất
    - [TestCase(1, 2, 3)]: nhieefu test
    - [TestCase(2, 3, 5)]

2.

- Các kiểu dữ liệu dynamic: double, float, decimal.
- Khác nhau: double (64bit), float (32bit), decimal(dùng cho tiền)

3. Hàm chia

   - Chia cho 0: throw exception

4. Cơ chế dấu phẩy động

   - 0.1 + 0.2 - 0.3 < 10e-6
