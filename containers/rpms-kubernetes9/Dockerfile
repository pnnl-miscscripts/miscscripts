# syntax = docker/dockerfile:1.2

FROM pnnlmiscscripts/rpms-node-base9:latest

FROM rockylinux:9
ARG BACK=1
ARG SUBBUILD=1.13

COPY --from=0 /data /rpms-base

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

ADD kubernetes.repo /etc/yum.repos.d/
RUN --mount=type=secret,id=gpg \
  sed -i "s/KUBE_VERSION/${SUBBUILD}/" /etc/yum.repos.d/kubernetes.repo && \
  yum install -y 'dnf-command(download)' createrepo gnupg2 rpm-sign findutils && \
  mkdir -p rpms/ && \
  mkdir -p rpms/ && \
  cd /rpms && \
  cp -a /rpms-base/*.rpm . && \
  dnf install -y --downloadonly --destdir /rpms kubelet kubeadm kubectl && \
  find /rpms-base -maxdepth 1 -type f -name '*.rpm' -printf '%f\n' | while read line; do rm -f $line; done && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  rpm --addsign $(find . -type f -name '*.rpm') && \
  createrepo /rpms && \
  gpg --detach-sign --armor /rpms/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  cp /root/rpm.pub /rpms/repodata/RPM-GPG-KEY && \
  ls -l /rpms/

FROM scratch
COPY --from=1 /rpms /data
