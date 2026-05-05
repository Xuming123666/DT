#
# Copyright (C) 2026 TeamWin Recovery Project
# Licensed under the Apache License, Version 2.0
#
# 解决64位设备32位应用编译错误
TARGET_SUPPORTS_64_BIT_APPS := true
###########################################################################
# 基础平台配置（msm8998专属，绝对不能改）
###########################################################################
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a73
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_VARIANT := cortex-a73
TARGET_BOARD_PLATFORM := msm8998
# 骁龙835通用修复
TARGET_USES_QCOM_BSP := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
###########################################################################
# 原生AB分区核心配置（你的设备专属，绝对不能改）
###########################################################################
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
BOARD_HAS_NO_RECOVERY_PARTITION := true
TARGET_COPY_OUT_VENDOR := vendor
ENABLE_VIRTUAL_AB := false
BOARD_AVB_ENABLE := false
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
###########################################################################
# 预编译内核配置（✅ 已修正DTB矛盾）
###########################################################################
TARGET_PREBUILT_KERNEL := device/Readboy/msm8998/kernel
TARGET_NO_DTB := false
TARGET_KERNEL_SOURCE :=
TARGET_KERNEL_CONFIG :=
TARGET_NO_KERNEL := false
BOARD_MKBOOTIMG_ARGS += --base 0x80000000
BOARD_MKBOOTIMG_ARGS += --kernel_offset 0x00008000
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset 0x01000000
BOARD_MKBOOTIMG_ARGS += --tags_offset 0x00000100
BOARD_MKBOOTIMG_ARGS += --dtb_offset 0x03000000
BOARD_MKBOOTIMG_ARGS += --pagesize 4096
BOARD_MKBOOTIMG_ARGS += --dtb device/Readboy/msm8998/kernel_dtb
# 强制使用原生完整cmdline（一个字符都不能改）
BOARD_MKBOOTIMG_ARGS += --cmdline "console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 earlycon=msm_serial_dm,0xc1b0000 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 sched_enable_hmp=1 sched_enable_power_aware=1 service_locator.enable=1 swiotlb=2048 androidboot.configfs=true androidboot.usbcontroller=a800000.dwc3 loop.max_part=7 buildvariant=user"
# 跨版本参数（安卓10固件+TWRP 12.1，必须保留11.0.0否则无法启动）
BOARD_MKBOOTIMG_ARGS += --os_version 11.0.0
BOARD_MKBOOTIMG_ARGS += --os_patch_level 2021-01-05
# 禁用安卓11+才有的分区
BOARD_HAS_SYSTEM_EXT := false
BOARD_HAS_PRODUCT := false
BOARD_USES_PRODUCT_SERVICES := false
# fstab配置
TARGET_RECOVERY_FSTAB := device/Readboy/msm8998/fstab.ab
BOARD_RECOVERY_FSTAB_LOCATION := /etc
# 显示相关配置（避免花屏）
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TW_THEME := portrait_hdpi
# 彻底禁用构建系统自动追加任何参数
BOARD_KERNEL_CMDLINE :=
BOARD_KERNEL_BASE :=
BOARD_RAMDISK_OFFSET :=
BOARD_TAGS_OFFSET :=
BOARD_DTB_OFFSET :=
BOARD_PAGE_SIZE :=
###########################################################################
# ADB与USB全功能配置（✅ 已适配TWRP 12.1）
###########################################################################
TW_ADB_ENABLED := true
TW_ALWAYS_ENABLE_ADB := true
TW_ADB_ALWAYS_INSECURE := true
TW_INCLUDE_USB := true
TW_INCLUDE_MTP := true
TW_INCLUDE_OTG := true
TW_INCLUDE_MASS_STORAGE := false
TW_USB_MTP_DRIVER := android
TW_NO_EXFAT_FUSE := false
###########################################################################
# TWRP核心功能配置
###########################################################################
# 移除无用的TWRP APP，减小镜像体积
TW_EXCLUDE_TWRPAPP := true
TW_NO_SCREEN_BLANK := true
TW_USE_TOOLBOX := true
TW_INCLUDE_BASH := true
TW_INCLUDE_NANO := true
TW_INCLUDE_TAR := true
TW_INCLUDE_ZIP := true
TW_INCLUDE_GZIP := true
TW_INCLUDE_XZ := true
BOARD_HAS_NO_SELECT_BUTTON := true
# 备份与恢复
TW_BACKUP_VENDOR := true
TW_BACKUP_BOOT := true
TW_BACKUP_SYSTEM := true
TW_BACKUP_DATA := true
TW_BACKUP_CACHE := true
TW_BACKUP_MODEM := true
# 分区操作
TW_INCLUDE_FORMAT_DATA := true
TW_INCLUDE_WIPE_CACHE := true
TW_INCLUDE_WIPE_DALVIK := true
TW_HAS_NO_REAL_PARTITIONS := false
###########################################################################
# Android 10 加密配置（关闭更稳定）
###########################################################################
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO_FBE := false
TW_INCLUDE_FBE_LEGACY := false
TW_SUPPORT_LEGACY_DECRYPTION := false
TW_CRYPTO_USE_SYSTEM_VOLD := false
###########################################################################
# 其他实用功能
###########################################################################
BOARD_HAS_DOWNLOAD_MODE := true
BOARD_HAS_FLASH_LED := true
TW_INCLUDE_VIBRATOR := true
TW_INCLUDE_SCREENSHOT := true
TW_INCLUDE_LOGCAT := true
TW_INCLUDE_REBOOT_BOOTLOADER := true
TW_INCLUDE_REBOOT_RECOVERY := true
TW_INCLUDE_REBOOT_SYSTEM := true
TW_INCLUDE_POWEROFF := true
TW_SELINUX_PERMISSIVE := true
###########################################################################
# TWRP 12.1 通用配置
###########################################################################
TW_SUPPORT_COMPRESSION := true
TW_INCLUDE_PROP_TOOLS := true
TW_INCLUDE_SELINUX_TOOLS := true
###########################################################################
# ✅ 你的设备专属参数（确认屏幕分辨率正确即可）
###########################################################################
TW_SCREEN_WIDTH := 1600
TW_SCREEN_HEIGHT := 2560
TW_TOUCHSCREEN_WIDTH := 1600
TW_TOUCHSCREEN_HEIGHT := 2560
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 150
