FROM golang

RUN \
  CGO_ENABLED=0 go get go.universe.tf/netboot/cmd/pixiecore

FROM alpine:3.9
COPY --from=0 /go/bin/pixiecore /bin/pixiecore
RUN echo 1.0.1 > /.extrafingerprints
ENTRYPOINT ["/bin/pixiecore"]

