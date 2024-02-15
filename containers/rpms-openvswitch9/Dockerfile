# syntax = docker/dockerfile:1.0-experimental

FROM pnnlmiscscripts/rpms-node-base9:latest

FROM rockylinux:9
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

COPY --from=0 /data /rpms-base

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

RUN --mount=type=secret,id=gpg \
  cd / && \
  set -e && \
  dnf install -y 'dnf-command(download)' createrepo gnupg2 rpm-sign findutils && \
  dnf install -y centos-release-nfv-openvswitch && \
  sed -i 's/common-$releasever/2-9-stream/g' /etc/yum.repos.d/CentOS-NFV-OpenvSwitch.repo && \
  mkdir -p /rpms && \
  cd /rpms && \
  cp -a /rpms-base/*.rpm . && \
  dnf download --resolve --destdir /rpms openvswitch2.17 NetworkManager-ovs && \
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
