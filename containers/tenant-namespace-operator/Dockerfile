FROM quay.io/operator-framework/ansible-operator:v0.17.0

ARG helm_version=v3.2.0
USER 0
RUN \
  curl -o helm.tar.gz https://get.helm.sh/helm-${helm_version}-linux-amd64.tar.gz && \
  tar -zxvf helm.tar.gz && \
  mv linux-amd64/helm /usr/local/bin/helm && \
  rm -f helm.tar.gz && \
  rm -rf linux-amd64 && \
  touch /.extrafingerprints && \
  chown ${USER_UID}:0 /.extrafingerprints

USER 1001
WORKDIR ${HOME}

COPY watches.yaml requirements.yml ${HOME}/
COPY roles/ ${HOME}/roles/

#FIXME forcing ingress newer to work on newer k8s clusters. Fix upstream chart.
RUN \
  ansible-galaxy collection install -r ${HOME}/requirements.yml && \
  chmod -R ug+rwx ${HOME}/.ansible && \
  helm pull --repo https://pnnl-miscscripts.github.io/charts tenant-namespace --untar && \
  find roles/ -type f -exec md5sum {} \; > /.extrafingerprints && \
  echo 0.1.7 >> /.extrafingerprints && \
  md5sum watches.yaml >> /.extrafingerprints

ENTRYPOINT ["/usr/local/bin/entrypoint", "--inject-owner-ref=false"]
