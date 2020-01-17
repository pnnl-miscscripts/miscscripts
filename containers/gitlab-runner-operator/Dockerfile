FROM quay.io/operator-framework/ansible-operator:v0.13.0

USER 0

COPY chart.patch /chart.patch

RUN \
  yum install -y patch && \
  yum clean all && \
  curl -o /helm.tar.gz https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz && \
  tar -zxvf /helm.tar.gz && \
  mv /linux-amd64/helm /usr/bin/helm && \
  rm -f /helm.tar.gz && \
  helm repo add gitlab https://charts.gitlab.io && \
  helm pull gitlab/gitlab-runner --untar && \
  cd gitlab-runner && \
  patch -p1 < /chart.patch && \
  yum remove -y patch

COPY watches.yaml ${HOME}/watches.yaml

COPY roles/ ${HOME}/roles/

USER 1001
