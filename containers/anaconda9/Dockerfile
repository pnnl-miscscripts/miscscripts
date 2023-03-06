FROM rockylinux:9

RUN \
  mkdir -p /data/images/pxeboot/ && \
  curl https://dl.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/.treeinfo > /data/.treeinfo && \
  curl https://dl.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/images/pxeboot/vmlinuz -o /data/images/pxeboot/vmlinuz && \
  curl https://dl.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/images/pxeboot/initrd.img -o /data/images/pxeboot/initrd.img && \
  curl https://dl.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/images/efiboot.img -o /data/images/efiboot.img && \
  curl https://dl.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/images/install.img -o /data/images/install.img && \
  curl http://dl.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/LICENSE -o /data/LICENSE && \
  sed -i 's/AppStream,BaseOS/BaseOS/' /data/.treeinfo && \
  curl -s http://download.rockylinux.org/pub/rocky/9/BaseOS/x86_64/os/media.repo | grep mediaid | awk -F= '{print $2}' > /data/RockyLinux_BuildTag && \
  cat /data/RockyLinux_BuildTag | tee /.extrafingerprints

FROM scratch
COPY --from=0 /data /data
COPY --from=0 /.extrafingerprints /.extrafingerprints
