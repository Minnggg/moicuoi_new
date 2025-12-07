#!/bin/bash

# Script deploy tự động cho Docker

echo "🚀 Bắt đầu deploy website..."

# Kiểm tra Docker có được cài đặt không
if ! command -v docker &> /dev/null; then
    echo "❌ Docker chưa được cài đặt. Vui lòng cài đặt Docker trước."
    exit 1
fi

# Kiểm tra Docker Compose
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
elif docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
else
    echo "❌ Docker Compose chưa được cài đặt."
    exit 1
fi

# Dừng container cũ nếu có
echo "🛑 Dừng container cũ (nếu có)..."
$COMPOSE_CMD down 2>/dev/null

# Build và chạy container
echo "🔨 Đang build image..."
$COMPOSE_CMD build

echo "▶️  Đang khởi động container..."
$COMPOSE_CMD up -d

# Kiểm tra container có chạy không
sleep 2
if docker ps | grep -q moicuoi_web; then
    echo "✅ Deploy thành công!"
    echo ""
    echo "🌐 Website đang chạy tại:"
    echo "   - Local: http://localhost:8888"
    echo "   - Network: http://$(hostname -I | awk '{print $1}'):8888"
    echo ""
    echo "📊 Xem logs: $COMPOSE_CMD logs -f"
    echo "🛑 Dừng: $COMPOSE_CMD down"
else
    echo "❌ Có lỗi xảy ra. Kiểm tra logs:"
    $COMPOSE_CMD logs
    exit 1
fi

