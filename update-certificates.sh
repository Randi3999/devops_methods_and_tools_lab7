#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ./nginx/certs/nginx.key \
  -out ./nginx/certs/nginx.crt \
  -subj "/C=RU/ST=Perm/L=Perm/O=DevOps/CN=localhost"

docker exec nginx-container nginx -s reload
sleep 2
echo "Сертификаты обновлены."
echo "Проверим обновлены ли сертификаты:"
echo "На хосте:"
My_HOST=$(openssl x509 -in ./nginx/certs/nginx.crt -noout -fingerprint -sha256 | cut -d'=' -f2)
echo $My_HOST
echo "В контейнере nginx:"
DOCK=$(echo | timeout 3 openssl s_client -connect 127.0.0.1:55443 2>/dev/null | openssl x509 -noout -fingerprint -sha256 | cut -d'=' -f2)
echo $DOCK
if [ "$My_HOST" == "$DOCK" ] && [ -n "$My_HOST" ]; then
    echo "Сравнение сертификатов: совпадают."
else
    echo "Сравнение сертификатов: разные!"
fi
