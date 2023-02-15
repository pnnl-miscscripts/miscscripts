# syntax = docker/dockerfile:1.0-experimental
ARG SUBBUILD=1.13
FROM pnnlmiscscripts/rpms-node-base9:latest as base
FROM pnnlmiscscripts/rpms-containerd9:latest as containerd
FROM pnnlmiscscripts/rpms-openvswitch9:latest as openvswitch
FROM pnnlmiscscripts/rpms-kubernetes9:$SUBBUILD as kubernetes

FROM rockylinux:9 as repobuild
COPY --from=base /data /rpmdata
COPY --from=containerd /data /data/containerd
COPY --from=openvswitch /data /data/openvswitch
COPY --from=kubernetes /data /data/kubernetes
ADD rpm.pub /root/rpm.pub
RUN --mount=type=secret,id=gpg \
  yum install -y createrepo yum-utils gnupg2 && \
  mkdir -p /data/repodata && \
  zcat /rpmdata/repodata/*comps.xml.gz > /data/repodata/comps.xml && \
  cp -a /rpmdata/*.rpm /data && \
  createrepo -g /data/repodata/comps.xml /data && \
  gpg --import /run/secrets/gpg && \
  gpg --import /root/rpm.pub && \
  gpg --detach-sign --armor /data/repodata/repomd.xml && \
  rm -rf ~/.gnupg && \
  echo Done building repo.

FROM pnnlmiscscripts/rpms-node-base9:latest
COPY --from=openvswitch /data /data/openvswitch
COPY --from=containerd /data /data/containerd
COPY --from=kubernetes /data /data/kubernetes
COPY --from=repobuild /data/repodata /data/repodata

