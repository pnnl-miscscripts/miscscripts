ARG SUBBUILD=1.13
FROM nginx:stable-alpine

FROM pnnlmiscscripts/k8s-node-image:$SUBBUILD
COPY --from=0 / /
RUN echo "server {autoindex off; server_name localhost; location ~ ^/$ {return 200;} location ~ ^.*/$ {return 404;} location / { root /data; default_type application/octet-stream; add_header Content-Disposition 'attachment'; types {}}}" > /etc/nginx/conf.d/default.conf
