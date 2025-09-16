
# Starry Mix

基于 [starry-next](https://github.com/oscomp/starry-next) 和 [arceos](https://github.com/oscomp/arceos) 的操作系统。

[初赛比赛文档](./初赛文档.pdf)

进展汇报幻灯片： https://cloud.tsinghua.edu.cn/f/924d8221719a49618ea0/

比赛演示视频： https://cloud.tsinghua.edu.cn/f/e96b194f650d4101a15b/

``` bash
git clone -b ajax --recurse-submodules https://github.com/starry-mix-rk3588/starry-mix.git
cd module-local/lwext4_rust
make musl-generic -C c/lwext4 ARCH=aarch64
cd starry-mix
make ARCH=aarch64 LOG=debug run
```
