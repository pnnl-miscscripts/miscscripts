FROM alpine:3.13
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

RUN \
  apk add --no-cache --update ca-certificates openssl git && \
  rm -f /etc/apk/repositories

ENTRYPOINT ["git"]

CMD ["--help"]
