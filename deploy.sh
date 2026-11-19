#!/bin/bash -x
docker stop nginx-container
docker rm nginx-container
docker build -t devops/nginx-img ./nginx
docker run -d --name nginx-container -p 54322:80 -p 55443:443 -v ./nginx/certs:/etc/nginx/ssl:ro --restart unless-stopped devops/nginx-img
docker ps -a | grep -e "nginx" -e "CONTAINER"
echo "sleeeeeeeeep 5"
curl 127.0.0.1:54322
curl 127.0.0.1:55443
curl -k https://127.0.0.1:55443
docker logs -n 10 nginx-container
