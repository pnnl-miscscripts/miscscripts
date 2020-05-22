# syntax = docker/dockerfile:1.0-experimental
FROM centos:centos7
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

RUN --mount=type=secret,id=gpg \
  cd / && \
  set -e && \
  yum install -y createrepo createrepo gnupg2 rpm-sign && \
  mkdir -p rpms/ && \
  yum install -y centos-release-openstack-train createrepo && \
  yumdownloader --resolv --destdir rpms openvswitch && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  rpm --addsign $(find rpms -type f -name '*.rpm') && \
  createrepo rpms && \
  gpg --detach-sign --armor rpms/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  cp /root/rpm.pub /rpms/repodata/RPM-GPG-KEY

FROM scratch
COPY --from=0 /rpms /data
