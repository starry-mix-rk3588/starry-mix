
# Starry Mix

基于 [starry-next](https://github.com/oscomp/starry-next) 和 [arceos](https://github.com/oscomp/arceos) 的操作系统。

[初赛比赛文档](./初赛文档.pdf)

进展汇报幻灯片： https://cloud.tsinghua.edu.cn/f/924d8221719a49618ea0/

比赛演示视频： https://cloud.tsinghua.edu.cn/f/e96b194f650d4101a15b/

# Qemu 启动

``` bash
git clone -b ajax --recurse-submodules https://github.com/starry-mix-rk3588/starry-mix.git
cd module-local/lwext4_rust
make musl-generic -C c/lwext4 ARCH=aarch64
cd starry-mix
make ARCH=aarch64 LOG=debug run
```

# OrangePi 5 Plus

## SD卡
SD 卡需要创建 GPT 分区，并将分区命名为 root，并分区格式化为 ext4 格式，并制作 StarryOS 的文件系统

## eMMC （可选）

将镜像烧写到 eMMC，或者在 SD 卡中创建两个分区，参考 [eMMC 烧写](https://github.com/starry-mix-rk3588/axplat-opi5p?tab=readme-ov-file#%E7%83%A7%E5%86%99-emmc)


``` bash
git clone -b ajax --recurse-submodules https://github.com/starry-mix-rk3588/starry-mix.git
cd module-local/lwext4_rust/c
git submodule init && git submodule update
make musl-generic -C c/lwext4 ARCH=aarch64
cd ../../../ # 回到根目录
make ARCH=aarch64 LOG=error opi5p
make ARCH=aarch64 LOG=error flash
```

``` bash
U-Boot 2025.04 (Apr 02 2024 - 10:58:58 +0000)

Model: Xunlong Orange Pi 5 Plus
SoC:   RK3588
DRAM:  4 GiB
Core:  335 devices, 30 uclasses, devicetree: separate
MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In:    serial@feb50000
Out:   serial@feb50000
Err:   serial@feb50000
Model: Xunlong Orange Pi 5 Plus
SoC:   RK3588
Net:   No ethernet found.
Hit any key to stop autoboot:  0 
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
Scanning global bootmeth 'efi_mgr':
Cannot persist EFI variables without system partition
  0  efi_mgr      ready   (none)       0  <NULL>                    
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'mmc 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=-14)
Scanning bootdev 'mmc@fe2c0000.bootdev':
Scanning bootdev 'mmc@fe2e0000.bootdev':
  1  script       ready   mmc          1  mmc@fe2e0000.bootdev.part /boot.scr
** Booting bootflow 'mmc@fe2e0000.bootdev.part_1' with script
31330496 bytes read in 436 ms (68.5 MiB/s)
## Starting application at 0x00400000 ...
0Hi
   init_early on RK3588

 ____  _                          __  __ _         ⋆˙⟡
/ ___|| |_ __ _ _ __ _ __ _   _  |  \/  (_)_  __  ⋆⭒˚.⋆
\___ \| __/ _` | '__| '__| | | | | |\/| | \ \/ /
 ___) | || (_| | |  | |  | |_| | | |  | | |>  <
|____/ \__\__,_|_|  |_|   \__, | |_|  |_|_/_/\_\
                          |___/

arch = aarch64
platform = aarch64-opi5p
target = aarch64-unknown-none-softfloat
build_mode = release
log_level = error
backtrace = true
smp = 1

Boot at 1970-01-01 00:00:07.050667292 UTC

[  7.052430 0 axbacktrace::dwarf:77] Failed to initialize addr2line context: Hit the end of input before it was expected
/ # 
/ # 
/ # ls
bin         linuxrc     musl        sbin        tmp
dev         lost+found  proc        sys         usr
/ # cd bin
/bin # ls
arch           date           getopt         ln             mv             rmdir          tar
ash            dd             grep           login          netstat        rpm            touch
base32         df             gunzip         ls             nice           run-parts      true
base64         dmesg          gzip           lsattr         pidof          scriptreplay   umount
busybox        dnsdomainname  hostname       lzop           ping           sed            uname
cat            dumpkmap       hush           makemime       ping6          setarch        usleep
chattr         echo           ionice         mkdir          pipe_progress  setpriv        vi
chgrp          ed             iostat         mknod          printenv       setserial      watch
chmod          egrep          ipcalc         mktemp         ps             sh             zcat
chown          false          kbd_mode       more           pwd            sleep
conspy         fatattr        kill           mount          reformime      stat
cp             fdflush        link           mountpoint     resume         stty
cpio           fgrep          linux32        mpstat         rev            su
cttyhack       fsync          linux64        mt             rm             sync
/bin #
```
