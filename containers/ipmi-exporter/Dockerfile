FROM rockylinux:8
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

RUN \
  yum install -y freeipmi && \
  curl -o ipmi_exporter.tgz https://github.com/soundcloud/ipmi_exporter/releases/download/v1.2.0/ipmi_exporter-v1.2.0.linux-amd64.tar.gz -L && \
  tar -xvf ipmi_exporter.tgz && \
  mv ipmi_exporter-v*/ipmi_exporter /usr/bin/ && \
  rm -rf ipmi_exporter-v* && \
  echo 1.2.0 >> /.extrafingerprints

ENTRYPOINT ["ipmi_exporter"]

CMD ["--help"]
