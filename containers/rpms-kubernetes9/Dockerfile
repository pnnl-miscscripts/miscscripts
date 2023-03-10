# syntax = docker/dockerfile:1.0-experimental

FROM pnnlmiscscripts/rpms-node-base9:latest

FROM rockylinux:9
ARG BACK=1
ARG SUBBUILD=1.13

COPY --from=0 /data /rpms-base

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

ADD kubernetes.repo /etc/yum.repos.d/
RUN --mount=type=secret,id=gpg \
  yum install -y 'dnf-command(download)' createrepo gnupg2 rpm-sign findutils && \
  mkdir -p rpms/ && \
  VERSION=$(yum --showduplicates list kubelet -q | grep -vi packages | grep -vi rc | grep -vi alpha | grep -vi beta | awk '{print $2}' | awk -F. '{print $2}' | sort -nu | tail -n $BACK | head -n 1) && \
  VERSION="$(echo $SUBBUILD | awk -F. '{print $2}')" && \
  SUBVERSION=$(yum --showduplicates list kubelet -q | grep -vi packages | awk '{print $2}' | grep "^1\.$VERSION\."| awk -F. '{print $3}' | awk -F- '{print $1}' | sort -nu | tail -n 1) && \
  REVISION=$(yum --showduplicates list kubelet -q | grep -vi packages | awk '{print $2}' | grep "^1\.$VERSION\.$SUBVERSION-" | awk -F- '{print $2}' | sort -nu | tail -n 1) && \
  FULLVERSION="1.$VERSION.$SUBVERSION-$REVISION" && \
  echo "Picked $FULLVERSION" && \
  mkdir -p rpms/ && \
  cd /rpms && \
  cp -a /rpms-base/*.rpm . && \
  dnf install -y --downloadonly --destdir /rpms "kubelet-$FULLVERSION" "kubeadm-$FULLVERSION" "kubectl-$FULLVERSION" && \
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
