# Hướng dẫn Deploy với Docker

## Yêu cầu
- Docker đã được cài đặt
- Docker Compose (tùy chọn, nhưng khuyến nghị)

## Cách sử dụng

### Cách 1: Sử dụng Docker Compose (Khuyến nghị)

1. **Build và chạy container:**
   ```bash
   docker-compose up -d
   ```

2. **Xem logs:**
   ```bash
   docker-compose logs -f
   ```

3. **Dừng container:**
   ```bash
   docker-compose down
   ```

4. **Rebuild sau khi thay đổi code:**
   ```bash
   docker-compose up -d --build
   ```

### Cách 2: Sử dụng Docker trực tiếp

1. **Build image:**
   ```bash
   docker build -t moicuoi-web .
   ```

2. **Chạy container:**
   ```bash
   docker run -d -p 8888:8888 --name moicuoi_web --restart unless-stopped moicuoi-web
   ```

3. **Xem logs:**
   ```bash
   docker logs -f moicuoi_web
   ```

4. **Dừng container:**
   ```bash
   docker stop moicuoi_web
   ```

5. **Xóa container:**
   ```bash
   docker rm moicuoi_web
   ```

## Truy cập website

Sau khi container chạy, truy cập website tại:
- **Local:** http://localhost:8888
- **Server:** http://your-server-ip:8888

## Cấu hình

### Thay đổi cổng

Nếu muốn thay đổi cổng, sửa file `docker-compose.yml`:
```yaml
ports:
  - "8080:8888"  # Thay 8080 bằng cổng bạn muốn
```

Và sửa file `nginx.conf`:
```nginx
listen 8080;  # Thay 8080 bằng cổng bạn muốn
```

### Update files mà không cần rebuild

File `docker-compose.yml` đã được cấu hình với volume mount, nên bạn có thể:
1. Sửa file trực tiếp trong thư mục
2. Refresh browser để xem thay đổi (không cần restart container)

## Troubleshooting

### Kiểm tra container có đang chạy không:
```bash
docker ps
```

### Xem logs lỗi:
```bash
docker-compose logs web
```

### Vào trong container để debug:
```bash
docker exec -it moicuoi_web sh
```

### Kiểm tra nginx config:
```bash
docker exec moicuoi_web nginx -t
```

## Production Tips

1. **Sử dụng reverse proxy (Nginx/Apache)** ở phía ngoài để:
   - SSL/HTTPS
   - Domain name
   - Load balancing

2. **Backup files định kỳ:**
   ```bash
   docker cp moicuoi_web:/usr/share/nginx/html ./backup
   ```

3. **Monitor resources:**
   ```bash
   docker stats moicuoi_web
   ```

