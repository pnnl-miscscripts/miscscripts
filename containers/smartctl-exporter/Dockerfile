FROM alpine
RUN \
  wget -O exporter.tar.gz https://github.com/prometheus-community/smartctl_exporter/releases/download/v0.7.0/smartctl_exporter-0.7.0.linux-amd64.tar.gz && \
  tar -zxvf exporter.tar.gz && \
  mv smartctl_exporter*/smartctl_exporter /bin/ && \
  rm -rf smartctl_exporter* && \
  apk add --no-cache --update smartmontools

COPY smartctl_exporter.yaml /etc/smartctl_exporter.yaml

CMD ["/bin/smartctl_exporter"]
