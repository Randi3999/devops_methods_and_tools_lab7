Я Климов Сергей Сергеевич, ИТ-14. Все файлы работы лежат в репозитории. Здесь я описал результаты выполнения лабораторной работы 7 по предмету "Devops и администрирование (Методы и инструменты DevOps)".

Выполнены основные и дополнительные (ssl) задачи.
Порт http: 54322
Порт https: 55443

Вывод после запуска deploy.sh:
```bash
./deploy.sh
+ docker stop nginx-container
nginx-container
+ docker rm nginx-container
nginx-container
+ docker build -t devops/nginx-img ./nginx
[+] Building 0.8s (11/11) FINISHED                                                     docker:default
 => [internal] load build definition from dockerfile                                             0.0s
 => => transferring dockerfile: 326B                                                             0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                  0.0s
 => [internal] load .dockerignore                                                                0.0s
 => => transferring context: 2B                                                                  0.0s
 => [internal] load build context                                                                0.0s
 => => transferring context: 3.20kB                                                              0.0s
 => [1/6] FROM docker.io/library/nginx:latest@sha256:fb01117203ff38c2f9af91db1a7409459182a37c87  0.0s
 => => resolve docker.io/library/nginx:latest@sha256:fb01117203ff38c2f9af91db1a7409459182a37c87  0.0s
 => CACHED [2/6] ADD ./index.html /var/www/html/index.html                                       0.0s
 => CACHED [3/6] ADD ./nginx-conf/nginx.conf /etc/nginx/conf.d/default.conf                      0.0s
 => [4/6] ADD ./certs/nginx.crt /etc/nginx/ssl/                                                  0.0s
 => [5/6] ADD ./certs/nginx.key /etc/nginx/ssl/                                                  0.0s
 => [6/6] RUN /usr/sbin/nginx -t                                                                 0.2s
 => exporting to image                                                                           0.3s
 => => exporting layers                                                                          0.1s
 => => exporting manifest sha256:53d306a675f16f6cfe4c327a0c9e21d3612fc3483ce5904235205433a697d0  0.0s
 => => exporting config sha256:154976c632980589da3b6ca311b33506f439e27b1e78cb0c9e92eecf1dcaa5b7  0.0s
 => => exporting attestation manifest sha256:a7c0c77f9174e83c29bcd6ff1fccb0304d777d201b78136c87  0.0s
 => => exporting manifest list sha256:a7a6cce5ab1dd320827b74f00cca7a2db2452923d72670c98616b6865  0.0s
 => => naming to docker.io/devops/nginx-img:latest                                               0.0s
 => => unpacking to docker.io/devops/nginx-img:latest                                            0.1s
+ docker run -d --name nginx-container -p 54322:80 -p 55443:443 -v ./nginx/certs:/etc/nginx/ssl:ro --restart unless-stopped devops/nginx-img
2e1f7987954274a1ea9e65904eda82eca2eace07b9d107b9310238f839cbe696
+ docker ps -a
+ grep -e nginx -e CONTAINER
CONTAINER ID   IMAGE              COMMAND                  CREATED        STATUS                  PORTS                                                                                    NAMES
2e1f79879542   devops/nginx-img   "/docker-entrypoint.…"   1 second ago   Up Less than a second   0.0.0.0:54322->80/tcp, [::]:54322->80/tcp, 0.0.0.0:55443->443/tcp, [::]:55443->443/tcp   nginx-container
+ echo 'sleeeeeeeeep 5'
sleeeeeeeeep 5
+ curl 127.0.0.1:54322
<!DOCTYPE html>
<html>
    <head>
        <title> DevOps 2026</title>
    </head>
    <body>
        DevOps methods and tools Course 2026!!!
    </body>
</html>
+ curl 127.0.0.1:55443
<html>
<head><title>400 The plain HTTP request was sent to HTTPS port</title></head>
<body>
<center><h1>400 Bad Request</h1></center>
<center>The plain HTTP request was sent to HTTPS port</center>
<hr><center>nginx/1.29.4</center>
</body>
</html>
+ curl -k https://127.0.0.1:55443
<!DOCTYPE html>
<html>
    <head>
        <title> DevOps 2026</title>
    </head>
    <body>
        DevOps methods and tools Course 2026!!!
    </body>
</html>
+ docker logs -n 10 nginx-container
2026/11/19 19:03:38 [notice] 1#1: start worker process 29
2026/11/19 19:03:38 [notice] 1#1: start worker process 30
2026/11/19 19:03:38 [notice] 1#1: start worker process 31
2026/11/19 19:03:38 [notice] 1#1: start worker process 32
2026/11/19 19:03:38 [notice] 1#1: start worker process 33
2026/11/19 19:03:38 [notice] 1#1: start worker process 34
2026/11/19 19:03:38 [notice] 1#1: start worker process 35
172.17.0.1 - - [19/Nov/2026:19:03:38 +0000] "GET / HTTP/1.1" 200 161 "-" "curl/8.22.0" "-"
172.17.0.1 - - [19/Nov/2026:19:03:38 +0000] "GET / HTTP/1.1" 400 255 "-" "curl/8.22.0" "-"
172.17.0.1 - - [19/Nov/2026:19:03:38 +0000] "GET / HTTP/1.1" 200 161 "-" "curl/8.22.0" "-"

```

Вывод скрипта обновления сертификатов:
```bash
./update-certificates.sh
..+......+...+.....+......+...+.+.........+........+...+++++++++++++++++++++++++++++++++++++++*.+...+...+++++++++++++++++++++++++++++++++++++++*..........+.....+...+.......+..+......+.+...+...+...+..+.........+......+....+.....+...+.......+.........+..+.........+...+.......+......+............+...+..............+.+.....+.......+..+.+............+.....+...............+.+.........+.....+.+.....+......+...+...+....+...+.....................+.........+..+....+...........+.........+....+.....+.+..+....+...+...+.........+......+...+..+...+......+.+.....+.........+.........+............+....+........+.+............+.........+........+............+.+..+....................................+......+.+...+..+.......+..+......+...+............+.......+......+...........+...+.......+.....+...+..........+...............+........+.......+...........+.+........................+............+...+..+.......+...........+.+.....+.+........+....+..+...+.......+.....+...+......+.........+.+............+..................+......+...+..+...+......+......+......+...+....+.....................+..+...+..........+.........+..+.+..+.+.....+......+...+.+............+....................+.......+...+...+..+.........+......+...+....+......+......+...+.....+......+............+...+....+..+...................+..+..........+.....+.........+...+.+......+...+............+.....+.++++++
..+....+++++++++++++++++++++++++++++++++++++++*.+.....+++++++++++++++++++++++++++++++++++++++*.......+........+......+.+......+.....++++++
-----
2026/11/19 19:09:18 [notice] 36#36: signal process started
Сертификаты обновлены.
Проверим обновлены ли сертификаты:
На хосте:
DF:86:DD:07:D3:FD:57:66:C7:61:30:49:CF:91:9D:52:55:01:E8:27:96:B0:30:38:05:6B:17:23:AB:DF:50:A4
В контейнере nginx:
DF:86:DD:07:D3:FD:57:66:C7:61:30:49:CF:91:9D:52:55:01:E8:27:96:B0:30:38:05:6B:17:23:AB:DF:50:A4
Сравнение сертификатов: совпадают.

```

В браузере:
http:
!()[Screenshots/photo1.png]

https:
!()[Screenshots/photo2.png]
