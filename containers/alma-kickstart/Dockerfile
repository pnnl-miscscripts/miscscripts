FROM nginx

RUN \
  mkdir -p /usr/share/nginx/html/images/pxeboot && \
  mkdir -p /usr/share/nginx/html/EFI/BOOT/fonts && \
  curl -L -o /usr/share/nginx/html/EFI/BOOT/BOOTX64.EFI https://seattle.crazyfast.us/almalinux/9/BaseOS/x86_64/kickstart/EFI/BOOT/BOOTX64.EFI && \
  curl -L -o /usr/share/nginx/html/EFI/BOOT/grubx64.efi https://seattle.crazyfast.us/almalinux/9/BaseOS/x86_64/kickstart/EFI/BOOT/grubx64.efi && \
  curl -L -o /usr/share/nginx/html/EFI/BOOT/mmx64.efi https://seattle.crazyfast.us/almalinux/9/BaseOS/x86_64/kickstart/EFI/BOOT/mmx64.efi && \
  curl -L -o /usr/share/nginx/html/EFI/BOOT/fonts/unicode.pf2 https://seattle.crazyfast.us/almalinux/9/BaseOS/x86_64/kickstart/EFI/BOOT/fonts/unicode.pf2 && \
  curl -L -o /usr/share/nginx/html/images/install.img https://seattle.crazyfast.us/almalinux/9/BaseOS/x86_64/kickstart/images/install.img && \
  curl -L -o /usr/share/nginx/html/images/pxeboot/initrd.img https://seattle.crazyfast.us/almalinux/9/BaseOS/x86_64/kickstart/images/pxeboot/initrd.img && \
  curl -L -o /usr/share/nginx/html/images/pxeboot/vmlinuz https://seattle.crazyfast.us/almalinux/9/BaseOS/x86_64/kickstart/images/pxeboot/vmlinuz && \
  echo 'server {autoindex off; server_name localhost; location ~ ^/$ {return 200;} location ~ ^.*/$ {return 404;} location / { root /usr/share/nginx/html; default_type application/octet-stream; add_header Content-Disposition 'attachment'; types {}}}' > /etc/nginx/conf.d/default.conf

