FROM quay.io/operator-framework/ansible-operator:v1.32.0

ARG helm_version=v3.5.2
USER 0
RUN \
  dnf clean all && \
  dnf install -y git patch && \
  dnf clean all && \
  ARCH=$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/') && \
  curl -o helm.tar.gz https://get.helm.sh/helm-${helm_version}-linux-${ARCH}.tar.gz && \
  tar -zxvf helm.tar.gz && \
  mv linux-${ARCH}/helm /usr/local/bin/helm && \
  rm -f helm.tar.gz && \
  rm -rf linux-${ARCH} && \
  touch /.extrafingerprints && \
  chown ${USER_UID}:0 /.extrafingerprints

USER 1001
WORKDIR ${HOME}

COPY configmap.patch watches.yaml requirements.yml ${HOME}/
COPY roles/ ${HOME}/roles/

#FIXME forcing ingress newer to work on newer k8s clusters. Fix upstream chart.
RUN \
  ansible-galaxy install -r ${HOME}/requirements.yml && \
  chmod -R ug+rwx ${HOME}/.ansible && \
  helm plugin install https://github.com/databus23/helm-diff --version master && \
  helm pull --repo https://pnnl-miscscripts.github.io/charts tenant-namespace --version 0.6.13 --untar && \
  cd tenant-namespace/charts/ingress-nginx/ && \
  cd - && \
  find roles/ -type f -exec md5sum {} \; > /.extrafingerprints && \
  echo 0.1.13 >> /.extrafingerprints && \
  md5sum watches.yaml >> /.extrafingerprints

ENTRYPOINT ["/tini", "--", "/usr/local/bin/ansible-operator", "run", "--watches-file=./watches.yaml", "--inject-owner-ref=false"]
