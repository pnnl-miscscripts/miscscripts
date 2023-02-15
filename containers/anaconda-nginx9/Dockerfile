FROM nginx:stable-alpine

FROM pnnlmiscscripts/anaconda9:latest
COPY --from=0 / /
RUN echo "server {autoindex off; server_name localhost; location ~ ^/$ {return 200;} location ~ ^.*/$ {return 404;} location / { root /data; default_type application/octet-stream; add_header Content-Disposition 'attachment'; types {}}}" > /etc/nginx/conf.d/default.conf
