# syntax = docker/dockerfile:1.0-experimental
FROM centos:centos7
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

RUN --mount=type=secret,id=gpg \
  cd / && \
  set -e && \
  yum install -y createrepo yum-utils gnupg2 rpm-sign && \
  mkdir -p rpms/ && \
  yumdownloader --resolv --installroot=/tmp/root --releasever=/ \
    --destdir rpms --setopt cachedir=/tmp/cache \
    @Base @Core @anaconda-tools grub2-efi-x64 kernel grub2 docker e2fsprogs \
    container-selinux nspr nss-util openssh-server openssh iptables-services \
    nfs-utils authconfig psmisc libibverbs qemu-guest-agent && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  rpm --addsign $(find rpms -type f -name '*.rpm') && \
  reposync --gpgcheck -l --repoid=base --downloadcomps -u > /dev/null && \
  mkdir -p rpms/repodata && \
  mv base/comps.xml rpms/repodata && \
  createrepo -g `pwd`/rpms/repodata/comps.xml rpms && \
  gpg --detach-sign --armor rpms/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  cp /root/rpm.pub /rpms/repodata/RPM-GPG-KEY

FROM scratch
COPY --from=0 /rpms /data
