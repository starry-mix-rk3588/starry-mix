

## clone busybox

## 进入根目录执行

```bash
make ARCH=aarch64 CROSS_COMPILE=aarch64-linux-musl- menuconfig
make ARCH=aarch64 CROSS_COMPILE=aarch64-linux-musl- -j40
make ARCH=aarch64 CROSS_COMPILE=aarch64-linux-musl- install

dd if=/dev/zero of=disk.img bs=1M count=64
mkfs.ext4 -F disk.img
mkdir -p mnt
sudo mount -o loop disk.img mnt
sudo cp -a _install/* mnt/
sudo umount mnt

mv disk.img path-to/starry-mix/arceos
```