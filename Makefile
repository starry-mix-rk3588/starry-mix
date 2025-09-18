# Build Options
export ARCH := riscv64
export LOG := warn
export BACKTRACE := y
export MEMTRACK := n

# QEMU Options
export BLK := y
export NET := y
export MEM := 1G
export TEST := alpine

# Generated Options
export A := $(PWD)
export NO_AXSTD := y
export AX_LIB := axfeat
export APP_FEATURES := qemu
TARGET_DIR := $(PWD)/target/aarch64-unknown-none-softfloat/release/starry
TOOL_PATH = $(PWD)/module-local/axplat-opi5p/tools/orangepi5

ifeq ($(MEMTRACK), y)
	APP_FEATURES += starry-api/memtrack
endif

export ICOUNT := n

DIR := $(shell basename $(PWD))

all:
	@if [ -f cargo_config.toml ]; then \
		mkdir -p .cargo; \
		cp cargo_config.toml .cargo/config.toml; \
	fi
	RUSTUP_TOOLCHAIN=nightly-2025-05-20 \
	CARGO_PROFILE_RELEASE_LTO=true \
	CARGO_PROFILE_RELEASE_CODEGEN_UNITS=1 \
	$(MAKE) oscomp LOG=off BACKTRACE=n

oscomp:
	$(MAKE) ARCH=riscv64 BUS=mmio build
	cp $(DIR)_riscv64-qemu-virt.bin kernel-rv
	$(MAKE) ARCH=loongarch64 build
	cp $(DIR)_loongarch64-qemu-virt.elf kernel-la

IMG :=
ifeq ($(ARCH), riscv64)
	IMG := sdcard-rv-$(TEST).img
else ifeq ($(ARCH), loongarch64)
	IMG := sdcard-la-$(TEST).img
endif

run: defconfig
	rust-objdump -d --print-imm-hex $(TARGET_DIR) > $(TARGET_DIR)_qemu.disasm
	@if [ -f "$(IMG)" ]; then \
		cp $(IMG) arceos/disk.img; \
	fi
	@make -C arceos run

# Aliases
rv:
	$(MAKE) ARCH=riscv64 run

la:
	$(MAKE) ARCH=loongarch64 run

alpine:
	$(MAKE) TEST=alpine rv

vf2:
	$(MAKE) ARCH=riscv64 APP_FEATURES=vf2 MYPLAT=axplat-riscv64-visionfive2 BUS=dummy build

2k1000la:
	$(MAKE) ARCH=loongarch64 APP_FEATURES=2k1000la MYPLAT=axplat-loongarch64-2k1000la BUS=dummy build

opi5p:
	$(MAKE) ARCH=aarch64 APP_FEATURES=opi5p MYPLAT=axplat-aarch64-opi5p BUS=dummy MODE=release UIMAGE=y build
	rust-objcopy -O binary $(TARGET_DIR) $(TARGET_DIR).bin
	sudo bash $(TOOL_PATH)/make_disk.sh $(TARGET_DIR).img $(TARGET_DIR).bin
	rust-objdump -d --print-imm-hex $(TARGET_DIR) > $(TARGET_DIR)_opi5p.disasm

upload: 
	bash $(TOOL_PATH)/upload_flash.sh $(TARGET_DIR).img

flash:
	sudo bash $(TOOL_PATH)/make_flash.sh $(TARGET_DIR).img

build justrun debug disasm: defconfig
	@make -C arceos $@

defconfig:
	@make -C arceos $@

clean:
	@make -C arceos $@
	rm -rf target
	rm -rf .cargo
.PHONY: all build run justrun debug disasm clean
