FROM centos:centos7
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

RUN \
  cd / && \
  set -e && \
  yum install -y createrepo && \
  mkdir -p rpms/ && \
  yum install -y centos-release-openstack-rocky createrepo && \
  yumdownloader --resolv --destdir rpms openvswitch && \
  createrepo rpms

FROM scratch
COPY --from=0 /rpms /data
