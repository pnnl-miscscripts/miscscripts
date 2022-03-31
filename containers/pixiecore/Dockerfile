FROM golang

RUN \
  CGO_ENABLED=0 go install go.universe.tf/netboot/cmd/pixiecore@latest

FROM alpine:3.15
COPY --from=0 /go/bin/pixiecore /bin/pixiecore
RUN echo 1.0.2 > /.extrafingerprints && cd / && wget http://boot.ipxe.org/ipxe.efi
ENTRYPOINT ["/bin/pixiecore"]
