# syntax = docker/dockerfile:1.0-experimental

FROM pnnlmiscscripts/rpms-node-base9:latest

FROM rockylinux:9

COPY --from=0 /data /rpms-base

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

ADD docker-ce.repo /etc/yum.repos.d/
RUN --mount=type=secret,id=gpg \
  cd / && \
  set -e && \
  yum install -y 'dnf-command(download)' createrepo gnupg2 rpm-sign findutils && \
  mkdir -p rpms/ && \
  cd /rpms && \
  cp -a /rpms-base/*.rpm . && \
  dnf download --resolve --destdir /rpms containerd.io && \
  find /rpms-base -maxdepth 1 -type f -name '*.rpm' -printf '%f\n' | while read line; do rm -f $line; done && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  rpm --addsign $(find . -type f -name '*.rpm') && \
  createrepo /rpms && \
  gpg --detach-sign --armor /rpms/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  cp /root/rpm.pub /rpms/repodata/RPM-GPG-KEY && \
  ls -l /rpms

FROM scratch
COPY --from=1 /rpms /data
