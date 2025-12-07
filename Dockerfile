# Sử dụng nginx image chính thức
FROM nginx:alpine

# Xóa cấu hình mặc định của nginx
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy file cấu hình nginx tùy chỉnh
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy tất cả các file tĩnh vào thư mục nginx
COPY . /usr/share/nginx/html

# Expose cổng 8888
EXPOSE 8888

# Khởi động nginx
CMD ["nginx", "-g", "daemon off;"]

