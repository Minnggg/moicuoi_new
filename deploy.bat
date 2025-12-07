@echo off
REM Script deploy tự động cho Docker trên Windows

echo 🚀 Bắt đầu deploy website...

REM Kiểm tra Docker có được cài đặt không
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker chưa được cài đặt. Vui lòng cài đặt Docker trước.
    pause
    exit /b 1
)

REM Kiểm tra Docker Compose
docker-compose --version >nul 2>&1
if errorlevel 1 (
    docker compose version >nul 2>&1
    if errorlevel 1 (
        echo ❌ Docker Compose chưa được cài đặt.
        pause
        exit /b 1
    )
    set COMPOSE_CMD=docker compose
) else (
    set COMPOSE_CMD=docker-compose
)

REM Dừng container cũ nếu có
echo 🛑 Dừng container cũ (nếu có)...
%COMPOSE_CMD% down 2>nul

REM Build và chạy container
echo 🔨 Đang build image...
%COMPOSE_CMD% build

echo ▶️  Đang khởi động container...
%COMPOSE_CMD% up -d

REM Kiểm tra container có chạy không
timeout /t 2 /nobreak >nul
docker ps | findstr moicuoi_web >nul
if errorlevel 1 (
    echo ❌ Có lỗi xảy ra. Kiểm tra logs:
    %COMPOSE_CMD% logs
    pause
    exit /b 1
)

echo ✅ Deploy thành công!
echo.
echo 🌐 Website đang chạy tại:
echo    - Local: http://localhost:8888
echo.
echo 📊 Xem logs: %COMPOSE_CMD% logs -f
echo 🛑 Dừng: %COMPOSE_CMD% down
echo.
pause

