FROM alpine:3.20
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

RUN \
  apk add --no-cache --update xmlstarlet bash && \
  echo 1 > /.extrafingerprints

ENTRYPOINT [ "/usr/bin/xmlstarlet" ]
