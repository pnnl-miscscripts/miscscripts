# syntax = docker/dockerfile:1.0-experimental
FROM centos:centos7
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

ENV VERSION=1.3.4

ADD containerd.spec /root/rpmbuild/SOURCES/containerd.spec
ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

RUN --mount=type=secret,id=gpg \
  set -x && \
  cd / && \
  yum install -y rpm-build cpio createrepo gnupg2 rpm-sign && \
  NEWVER=$(echo "$VERSION" | awk -F. '{print $1 "." $2 "." $3+1}') && \
  (! curl -f -o /root/rpmbuild/SOURCES/containerd.tar.gz "https://storage.googleapis.com/cri-containerd-release/cri-containerd-$NEWVER.linux-amd64.tar.gz") && \
  NEWVER=$(echo "$VERSION" | awk -F. '{print $1 "." $2+1 ".0"}') && \
  (! curl -f -o /root/rpmbuild/SOURCES/containerd.tar.gz "https://storage.googleapis.com/cri-containerd-release/cri-containerd-$NEWVER.linux-amd64.tar.gz") && \
  curl -f -o /root/rpmbuild/SOURCES/containerd.tar.gz "https://storage.googleapis.com/cri-containerd-release/cri-containerd-$VERSION.linux-amd64.tar.gz" && \
  sed -i "s/^\(Version:\).*$/\1 $VERSION/" /root/rpmbuild/SOURCES/containerd.spec && \
  cat /root/rpmbuild/SOURCES/containerd.spec && \
  rpmbuild -ba /root/rpmbuild/SOURCES/containerd.spec && \
  mkdir -p rpms && \
  mv ~/rpmbuild/RPMS/x86_64/* rpms/ && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  rpm --addsign $(find rpms -type f -name '*.rpm') && \
  createrepo rpms && \
  gpg --detach-sign --armor rpms/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  cp /root/rpm.pub /rpms/repodata/RPM-GPG-KEY && \
  mkdir tmp1 && \
  pushd tmp1 && \
  tar -xvf ~/rpmbuild/SOURCES/containerd.tar.gz && \
  SUM=$(md5sum usr/local/bin/containerd | awk '{print $1}') && \
  popd && \
  mkdir tmp2 && \
  pushd tmp2 && \
  rpm2cpio ../rpms/containerd*.rpm | cpio -idmv && \
  SUM2=$(md5sum usr/local/bin/containerd | awk '{print $1}') && \
  [ "x$SUM" != "x$SUM2" ] && echo "Checksums don't match" && exit -1  || true && \
  popd

FROM scratch
COPY --from=0 /rpms /data
