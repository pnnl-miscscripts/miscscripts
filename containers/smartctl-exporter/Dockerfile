FROM golang
RUN \
  wget -q -O /tmp/exporter.tar.gz https://github.com/Sheridan/smartctl_exporter/archive/smartctl_exporter_0.5.tar.gz && \
  tar -zxvf /tmp/exporter.tar.gz && \
  cd smartctl* && \
  export CGO_ENABLED=0 && \
  make && \
  make install && \
  mv bin/smartctl* /bin/smartctl_exporter

FROM alpine
COPY --from=0 /bin/smartctl_exporter /bin/smartctl_exporter
RUN \
  apk add --no-cache --update smartmontools

COPY smartctl_exporter.yaml /etc/smartctl_exporter.yaml

CMD ["/bin/smartctl_exporter"]
