FROM openresty/openresty:alpine

WORKDIR /server

COPY nginx.conf .
COPY scripts ./scripts

CMD ["/usr/local/openresty/bin/openresty", "-c", "/server/nginx.conf", "-g", "daemon off;"]

STOPSIGNAL SIGQUIT