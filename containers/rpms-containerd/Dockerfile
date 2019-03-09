FROM centos:centos7
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

ENV VERSION=1.2.4

ADD containerd.spec /root/rpmbuild/SOURCES/containerd.spec

RUN \
  set -x && \
  cd / && \
  yum install -y rpm-build cpio createrepo && \
  mkdir -p rpms/ && \
  curl -o /root/rpmbuild/SOURCES/containerd.tar.gz "https://storage.googleapis.com/cri-containerd-release/cri-containerd-$VERSION.linux-amd64.tar.gz" && \
  sed -i "s/^\(Version:\).*$/\1 $VERSION/" /root/rpmbuild/SOURCES/containerd.spec && \
  cat /root/rpmbuild/SOURCES/containerd.spec && \
  rpmbuild -ba /root/rpmbuild/SOURCES/containerd.spec && \
  mv ~/rpmbuild/RPMS/x86_64/* rpms/ && \
  createrepo rpms && \
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
