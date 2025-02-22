#!/bin/bash

# Cài đặt Docker
wget -O docker.sh "https://raw.githubusercontent.com/zunxbt/installation/98a351c5ff781415cbb9f1a250a6d2699cb814c7/docker.sh"
chmod +x docker.sh && ./docker.sh

# Đợi Docker khởi động
sleep 10

# Chạy 100 container với NODE_ID=5550215
for i in {1..100}; do
    port=$((8080 + $i))
    docker run -d --name "n$i" --restart unless-stopped -e NODE_ID=5550215 -p "$port:80" inanitynoupcase/nexus_2:1.3.0
done

# Cài đặt service monitor
curl -sSL https://raw.githubusercontent.com/inanitynoupcase/patato-monitor/main/monitor_restart.sh -o monitor_restart.sh
chmod +x monitor_restart.sh
nohup ./monitor_restart.sh > container_restarts.log 2>&1 &

echo "Đã hoàn thành: "
echo "- Cài đặt Docker"
echo "- Chạy 50 container với NODE_ID=5550215"
echo "- Cài đặt và chạy monitor service"

# Hiển thị số container đang chạy
echo "Số container đang chạy:"
docker ps | wc -l
