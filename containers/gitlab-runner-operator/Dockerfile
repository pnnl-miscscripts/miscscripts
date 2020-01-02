FROM quay.io/operator-framework/ansible-operator:v0.13.0

USER 0

RUN \
  curl -o /helm.tar.gz https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz && \
  tar -zxvf /helm.tar.gz && \
  mv /linux-amd64/helm /usr/bin/helm && \
  rm -f /helm.tar.gz && \
  helm repo add gitlab https://charts.gitlab.io && \
  helm pull gitlab/gitlab-runner --untar

USER 1001

COPY watches.yaml ${HOME}/watches.yaml

COPY roles/ ${HOME}/roles/
