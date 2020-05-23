FROM centos:centos7
RUN \
  mkdir -p /data/LiveOS && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/CentOS_BuildTag -o /data/CentOS_BuildTag && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/images/pxeboot/initrd.img -o /data/initrd.img && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/images/pxeboot/vmlinuz -o /data/vmlinuz && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/.treeinfo -o /data/.treeinfo && \
  curl http://mirror.centos.org/centos-7/7/os/x86_64/LiveOS/squashfs.img -o /data/LiveOS/squashfs.img && \
  cat /data/CentOS_BuildTag > /.extrafingerprints

FROM scratch
COPY --from=0 /data /data
COPY --from=0 /.extrafingerprints /.extrafingerprints
