# syntax = docker/dockerfile:1.0-experimental
FROM rockylinux:9
MAINTAINER Kevin Fox <Kevin.Fox@pnnl.gov>

ADD rpm.pub /root/rpm.pub
ADD rpmmacros /root/.rpmmacros

RUN --mount=type=secret,id=gpg \
  cd / && \
  set -e && \
  yum install -y createrepo yum-utils gnupg2 rpm-sign && \
  mkdir -p rpms/ && \
  BASE=$(dnf group info base | grep '^   \w' | awk '{print $1}') && \
  CORE=$(dnf group info core | grep '^   \w' | awk '{print $1}') && \
  ANACONDA_TOOLS=$(dnf group info anaconda-tools | grep '^   \w' | awk '{print $1}') && \
  repotrack --alldeps --resolve --installroot=/tmp/root --releasever=/ \
    --destdir rpms --setopt cachedir=/tmp/cache --downloadonly \
    $BASE $CORE $ANACONDA_TOOLS grub2-efi-x64 kernel grub2 e2fsprogs \
    nspr nss-util openssh-server openssh iptables-services \
    nfs-utils authconfig psmisc libibverbs qemu-guest-agent libsss_sudo && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  rpm --addsign $(find rpms -type f -name '*.rpm') && \
  mkdir -p rpms/repodata && \
  curl -o rpms/repodata/comps.xml $(reposync --gpgcheck --repoid=baseos --downloadcomps -u  | grep -- -GROUPS.xml) && \
  createrepo -g `pwd`/rpms/repodata/comps.xml rpms && \
  gpg --detach-sign --armor rpms/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  cp /root/rpm.pub /rpms/repodata/RPM-GPG-KEY && \
  ls -l /rpms

FROM scratch
COPY --from=0 /rpms /data
