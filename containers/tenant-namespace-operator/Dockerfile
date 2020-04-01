FROM quay.io/operator-framework/ansible-operator:v0.13.0

USER 0

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/

#FIXME forcing ingress newer to work on newer k8s clusters. Fix upstream chart.

RUN \
  curl -o /helm.tar.gz https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz && \
  tar -zxvf /helm.tar.gz && \
  mv /linux-amd64/helm /usr/bin/helm && \
  rm -f /helm.tar.gz && \
  helm repo add pnnl-miscscripts https://pnnl-miscscripts.github.io/charts && \
  helm pull pnnl-miscscripts/tenant-namespace --untar && \
  cd ${HOME} && \
  find roles/ -type f -exec md5sum {} \; > /.extrafingerprints && \
  echo 0.1.3 >> /.extrafingerprints && \
  md5sum watches.yaml >> /.extrafingerprints

USER 1001
ENTRYPOINT ["/usr/local/bin/entrypoint", "--inject-owner-ref=false"]
