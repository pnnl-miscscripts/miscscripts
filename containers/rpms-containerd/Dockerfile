# syntax = docker/dockerfile:1.0-experimental
FROM centos:centos7

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

ADD docker-ce.repo /etc/yum.repos.d/
RUN --mount=type=secret,id=gpg \
  cd / && \
  set -e && \
  yum install -y createrepo gnupg2 rpm-sign && \
  mkdir -p rpms/ && \
  yumdownloader --resolv --destdir rpms containerd.io && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  rpm --addsign $(find rpms -type f -name '*.rpm') && \
  createrepo rpms && \
  gpg --detach-sign --armor rpms/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  cp /root/rpm.pub /rpms/repodata/RPM-GPG-KEY

FROM scratch
COPY --from=0 /rpms /data
