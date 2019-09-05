pixiecore-simpleconfig is a chart that lets you quickly setup a backend for pixiecore

You can put the pixiecore json files directly into config, keyed by mac address.

For example, to pxe boot 00:11:22:33, use values file:
```yaml
config:
 "00:11:22:33": |
   {
     "kernel": "http://xxx.xxx.xxx.xxx:9090/vmlinuz",
     "initrd": ["http://xxx.xxx.xxx.xxx:9090/initrd.img"],
     "cmdline": "ks=http://xxx.xxx.xxx.xxx:9091/v1/boot/ks.cfg ksdevice=ens1 console=ttyS1,115200"
   }
```

Install like:
```console
helm install pnnlmiscscripts/pixiecore-simpleconfig \
 --name pixiecore-simpleconfig \
 --namespace provision \
 -f pixiecore-simpleconfig-values.yaml
```

Then point your pixiecore at the pixiecore-simpleconfig.

The config value gets mapped directly to a configmap, so its possible to put other things in there such as kickstart files if that simplifies your setup.

