# Phím tắt

# Debug db

set GLOBAL general_log = 1;
set GLOBAL log_output = 'table';
SELECT \* FROM mysql.general_log WHERE argument LIKE '%CALL%' ORDER BY event_time desc;

# VS Code

Ctrl + R: chuyển folder
Ctrl + W: Đóng tab
Ctrl + H: replace

## Vue

- ctrl+shift+ c: inspector
- k: console
- z: debugger
- e: network
- F8 thay cho F5

## Chung csharp

- ctrl + alt + L: mở view solution

- ctrl + r + r: thay hết tất cả
- add project referent: chuột phải
- ctrl + k + d: format code

- ctrl M O: đóng tất cả
- ctrl M P: mở tất cả
- ctrl M M: toggle phần tử mình đang chọn
- ctrl M L: toggle all

- ctrl K S: bôi đen tạo region, phải chia region: field, method,
- ctrl . : refactor

- ctrl + F12: nhảy vào implement của interface
- F12: nhảy vào interface (Go to definition)
- ctrl + -: quay trở lại triển khai, controller

- shift + alt + ;: chọn tất cả
- shift + alt + .: chọn cái giống tiếp theo
- ctrl + alt + chuột phải: bỏ chọn 1 cái

## Test csharp

- ctrl + r + a: tat ca test
- ctrl + r + t: 1 test, chuot phai

## Debug csharp

- F9: toggle breakpoint.
- shift + F9: xem nhanh giá trị của biến

- F5: debug/continue
- shift + F5: dừng debug

- shift + F11: thực hiện hết hàm và nhảy ra ngoài

- bỏ qua for: F9 tạo breakpoint xong F5 - F9 hoặc ctrl + F10

- ctrl + alt + P: Attach to Process, chạy debug
- shift + alt + P: reattach chọn lại
- IIS là gì: server trên window

- ctrl + Alt + I: Mở cửa sổ nhập giá trị như console: gọi được lệnh khi ở breakpoint (a = 1, 1 + 1)
- ctrl + alt + c: open callstack:
- ctrl + alt + w, 1, 2: open watch: theo dõi biến
- ctrl + alt + b: mở cửa sổ breakpoint

- ctrl + tab: chuyển file

đã được manage bởi DI
