FROM alpine:3.9
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

RUN \
  echo http://dl-cdn.alpinelinux.org/alpine/v3.9/community >> /etc/apk/repositories && \
  apk add --no-cache --update ca-certificates openssl ipmitool && \
  rm -f /etc/apk/repositories

ENTRYPOINT ["ipmitool"]

CMD ["--help"]
