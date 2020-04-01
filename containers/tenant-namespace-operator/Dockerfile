FROM quay.io/operator-framework/ansible-operator:v0.16.0

USER 0

COPY watches.yaml ${HOME}/watches.yaml
COPY requirements.yml ${HOME}/requirements.yml
COPY roles/ ${HOME}/roles/

#FIXME forcing ingress newer to work on newer k8s clusters. Fix upstream chart.

RUN \
  yum clean all && \
  yum install -y git && \
  yum clean all && \
  curl -o /helm.tar.gz https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz && \
  tar -zxvf /helm.tar.gz && \
  mv /linux-amd64/helm /usr/bin/helm && \
  rm -f /helm.tar.gz && \
  ansible-galaxy collection install -r ${HOME}/requirements.yml && \
  chmod -R ug+rwx ${HOME}/.ansible && \
  helm plugin install https://github.com/databus23/helm-diff --version master && \
  helm repo add pnnl-miscscripts https://pnnl-miscscripts.github.io/charts && \
  helm pull pnnl-miscscripts/tenant-namespace --untar && \
  cd ${HOME} && \
  find roles/ -type f -exec md5sum {} \; > /.extrafingerprints && \
  echo 0.1.5 >> /.extrafingerprints && \
  md5sum watches.yaml >> /.extrafingerprints

USER 1001
ENTRYPOINT ["/usr/local/bin/entrypoint", "--inject-owner-ref=false"]
