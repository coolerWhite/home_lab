# Задача
# Создать мультистэйдж в сборке 2-х бинарников
# И поместить их в другой образ
FROM ubuntu:22.04 AS stage1

WORKDIR /app/nginx

RUN apt update && apt install -y gcc \
                                libpcre3-dev \
                                make \
                                zlib1g-dev

ADD https://github.com/nginx/nginx.git .

RUN auto/configure

RUN make
RUN make install

WORKDIR /app/c-app

RUN echo '#include <stdio.h>\nint main() { printf("Hello from C application!\\n"); return 0; }' > hello.c

RUN gcc hello.c -o hello_app

FROM alpine:latest

COPY --from=stage1 /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx
COPY --from=stage1 /app/c-app/hello_app /usr/local/bin/hello_app

EXPOSE 80
CMD [ "/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
# CMD [ "/bin/sh", "-c", "/usr/local/bin/hello_app" ]