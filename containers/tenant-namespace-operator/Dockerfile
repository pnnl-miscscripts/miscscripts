FROM quay.io/operator-framework/ansible-operator:v0.17.0

ARG helm_version=v3.3.4
USER 0
RUN \
  yum clean all && \
  yum install -y git patch && \
  yum clean all && \
  curl -o helm.tar.gz https://get.helm.sh/helm-${helm_version}-linux-amd64.tar.gz && \
  tar -zxvf helm.tar.gz && \
  mv linux-amd64/helm /usr/local/bin/helm && \
  rm -f helm.tar.gz && \
  rm -rf linux-amd64 && \
  touch /.extrafingerprints && \
  chown ${USER_UID}:0 /.extrafingerprints

USER 1001
WORKDIR ${HOME}

COPY configmap.patch watches.yaml requirements.yml ${HOME}/
COPY roles/ ${HOME}/roles/

#FIXME forcing ingress newer to work on newer k8s clusters. Fix upstream chart.
RUN \
  ansible-galaxy collection install -r ${HOME}/requirements.yml && \
  chmod -R ug+rwx ${HOME}/.ansible && \
  helm plugin install https://github.com/databus23/helm-diff --version master && \
  helm pull --repo https://pnnl-miscscripts.github.io/charts tenant-namespace --version 0.6.9 --untar && \
  cd tenant-namespace/charts/ingress-nginx/ && \
  patch -p3 --no-backup-if-mismatch <${HOME}/configmap.patch && \
  cd - && \
  find roles/ -type f -exec md5sum {} \; > /.extrafingerprints && \
  echo 0.1.11 >> /.extrafingerprints && \
  md5sum watches.yaml >> /.extrafingerprints

ENTRYPOINT ["/usr/local/bin/entrypoint", "--inject-owner-ref=false"]
