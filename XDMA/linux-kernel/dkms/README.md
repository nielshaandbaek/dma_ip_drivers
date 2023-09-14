# Install XDMA module using DKMS

The `xdma` module can also be built using [DKMS (Dynamic Kernel Module Support)](https://wiki.debian.org/KernelDKMS).
When building and installing the driver this way, it will be automatically updated when a newer kernel version is installed using `apt`.

To add the driver to DKMS, and subsequently build and install it, run
```
$ sudo ./install.sh
```
To load the driver, insert it using `modprobe`:
```
$ sudo modprobe xdma
```
To always load the driver at boot time, add `ifc_uio` to `/etc/modules`.
