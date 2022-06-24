FROM quay.io/operator-framework/ansible-operator:v0.16.0

USER 0

COPY volume.patch /volume.patch
COPY watches.yaml ${HOME}/watches.yaml
COPY requirements.yml ${HOME}/requirements.yml
COPY roles/ ${HOME}/roles/

RUN \
  set -e && \
  yum clean all && \
  yum install -y git patch && \
  yum clean all && \
  curl -o /helm.tar.gz https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz && \
  tar -zxvf /helm.tar.gz && \
  mv /linux-amd64/helm /usr/bin/helm && \
  rm -f /helm.tar.gz && \
  ansible-galaxy collection install -r ${HOME}/requirements.yml && \
  chmod -R ug+rwx ${HOME}/.ansible && \
  helm plugin install https://github.com/databus23/helm-diff --version master && \
  helm repo add gitlab https://charts.gitlab.io && \
  helm repo update && \
  helm pull gitlab/gitlab-runner --untar && \
  cd gitlab-runner && \
  awk -F: '{if($1 == "version"){print $2}}' Chart.yaml | sed 's/ //g' && \
  echo Skipping volume.patch && \
  echo patch -p1 /volume.patch && \
  cd .. && \
  yum remove -y patch git && \
  cd ${HOME} && \
  find roles/ -type f -exec md5sum {} \; > /.extrafingerprints && \
  echo 0.1.4 >> /.extrafingerprints && \
  awk -F: '{if($1 == "version"){print $2}}' /gitlab-runner/Chart.yaml | sed 's/ //g' >> /.extrafingerprints && \
  md5sum watches.yaml >> /.extrafingerprints

USER 1001
