
# Starry Mix rk3588

# starry mix
基于 [starry-next](https://github.com/oscomp/starry-next) 和 [arceos](https://github.com/oscomp/arceos) 的操作系统。

[初赛比赛文档](./初赛文档.pdf)

进展汇报幻灯片： https://cloud.tsinghua.edu.cn/f/924d8221719a49618ea0/

比赛演示视频： https://cloud.tsinghua.edu.cn/f/e96b194f650d4101a15b/

# starry mix rk3588 (9-12)

```bash
git clone -b ajax --recurse-submodules https://github.com/starry-mix-rk3588/starry-mix.git
cd starry-mix
#  -// pub type A64PageTableMut<H> = PageTable64Mut<'_, A64PagingMetaData, A64PTE, H>;
#  +pub type A64PageTableMut<'a, H> = PageTable64Mut<'a, A64PagingMetaData, A64PTE, H>;
#  +#[cfg(target_arch = "aarch64")]
#  +const PCI_IRQ_BASE: u32 = 0x20;
make ARCH=aarch64 run LOG=debug
```
