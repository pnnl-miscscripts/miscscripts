FROM centos:centos7
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

RUN \
  cd / && \
  set -e && \
  yum install -y createrepo yum-utils && \
  mkdir -p rpms/ && \
  yumdownloader --resolv --installroot=/tmp/root --releasever=/ \
    --destdir rpms --setopt cachedir=/tmp/cache \
    @Base @Core kernel grub2 docker e2fsprogs container-selinux nspr \
    nss-util openssh-server openssh iptables-services nfs-utils && \
  createrepo rpms
  reposync --gpgcheck -l --repoid=base --downloadcomps -u > /dev/null && \
  mv base/comps.xml rpms/repodata

FROM scratch
COPY --from=0 /rpms /data
