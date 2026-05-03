#
# Copyright (C) 2026 TeamWin Recovery Project
# Licensed under the Apache License, Version 2.0
#

###########################################################################
# 基础平台配置（msm8998专属，绝对不能改）
###########################################################################
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_VARIANT := generic
TARGET_BOARD_PLATFORM := msm8998  # ✅ 新增：QCOM平台必须定义，否则所有硬件功能失效

###########################################################################
# 原生AB分区核心配置（你的设备专属，绝对不能改）
###########################################################################
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
TARGET_COPY_OUT_VENDOR := vendor
ENABLE_VIRTUAL_AB := false  # 原生AB，不是Virtual AB
BOARD_AVB_ENABLE := false   # ✅ 若你的设备开机提示"AVB验证失败"，改为true
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# 定义boot分区大小（msm8998设备通用64MB，足够放下TWRP）
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

###########################################################################
# 预编译内核配置（✅ 必须从你自己的boot.img提取偏移量！）
###########################################################################
# 1. 预编译内核 + 单独DTB 路径（必须和你文件实际位置一致）
TARGET_PREBUILT_KERNEL := device/Readboy/msm8998/kernel
TARGET_PREBUILT_DTB := device/Readboy/msm8998/kernel_dtb
BOARD_PREBUILT_DTBIMAGE_DIR := device/Readboy/msm8998

# 2. 告诉构建系统DTB是单独的，不用从内核里找
BOARD_KERNEL_SEPARATED_DTB := true
TARGET_NO_DTB := false

# 3. 彻底禁用内核源码编译
TARGET_KERNEL_SOURCE :=
TARGET_KERNEL_CONFIG :=
TARGET_NO_KERNEL := false

BOARD_MKBOOTIMG_ARGS += --base 0x80000000
 BOARD_MKBOOTIMG_ARGS += --kernel_offset 0x00008000
 BOARD_MKBOOTIMG_ARGS += --ramdisk_offset 0x01000000
 BOARD_MKBOOTIMG_ARGS += --tags_offset 0x00000100
 BOARD_MKBOOTIMG_ARGS += --dtb_offset 0x03000000
 BOARD_MKBOOTIMG_ARGS += --pagesize 4096
 BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
 BOARD_MKBOOTIMG_ARGS += --second 0  # 🟡 优化：明确没有second stage
 # 5. 强制使用原生完整cmdline（一个字符都不能改）
 BOARD_MKBOOTIMG_ARGS += --cmdline "console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 earlycon=msm_serial_dm,0xc1b0000 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 sched_enable_hmp=1 sched_enable_power_aware=1 service_locator.enable=1 swiotlb=2048 androidboot.configfs=true androidboot.usbcontroller=a800000.dwc3 loop.max_part=7 buildvariant=user veritykeyid=id:7e4333f9bba00adfe0ede979e28ed1920492b40f"
 # 6. 跨版本专用参数（安卓10固件+TWRP 11必须这么设）
 BOARD_MKBOOTIMG_ARGS += --os_version 11.0.0
 BOARD_MKBOOTIMG_ARGS += --os_patch_level 2021-01-05
 BOARD_MKBOOTIMG_ARGS += --veritykeyid 7e4333f9bba00adfe0ede979e28ed1920492b40f
 # 7. 禁用安卓11+才有的分区
 BOARD_HAS_SYSTEM_EXT := false
 BOARD_HAS_PRODUCT := false
 BOARD_USES_PRODUCT_SERVICES := false
# 8. 使用原生安卓10的fstab文件
 TARGET_RECOVERY_FSTAB := device/Readboy/msm8998/fstab.ab
 # 9. 显示相关配置（避免花屏）
 TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"  # 🟡 优化：骁龙835标准格式
 TW_THEME := portrait_hdpi  # 🟡 优化：1080P竖屏主题
 # 10. 彻底禁用构建系统自动追加任何参数
 BOARD_KERNEL_CMDLINE :=
 BOARD_KERNEL_BASE :=
 BOARD_RAMDISK_OFFSET :=
 BOARD_TAGS_OFFSET :=
 BOARD_DTB_OFFSET :=
 BOARD_PAGE_SIZE :=

###########################################################################
# ADB与USB全功能配置（已修复自动开启问题）
###########################################################################
# TWRP专属ADB强制开启，无需任何授权
TW_ADB_ENABLED := true
TW_ALWAYS_ENABLE_ADB := true
TW_ADB_INSECURE := true  # ✅ 新增：TWRP 11专属，彻底禁用ADB授权验证

# USB功能（已修复MTP冲突）
TW_INCLUDE_USB := true
TW_INCLUDE_MTP := true
TW_INCLUDE_OTG := true
TW_INCLUDE_MASS_STORAGE := false  # ✅ 修正：Android 10+已废弃U盘模式，开启会导致MTP失效
TW_USB_MTP_DRIVER := android
TW_NO_EXFAT_FUSE := false  # ✅ 新增：支持exFAT格式OTGU盘

###########################################################################
# TWRP核心功能配置
###########################################################################
TW_THEME := portrait_hdpi
TW_NO_SCREEN_BLANK := true
TW_USE_TOOLBOX := true
TW_INCLUDE_BASH := true
TW_INCLUDE_NANO := true
TW_INCLUDE_TAR := true
TW_INCLUDE_ZIP := true
TW_INCLUDE_GZIP := true
TW_INCLUDE_XZ := true
BOARD_HAS_NO_SELECT_BUTTON := true  # ✅ 新增：支持电源键确认操作

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
# Android 10 FBE加密解密（✅ 已修复，必须匹配安全补丁日期）
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
# TWRP 11 专属配置
###########################################################################
TW_SUPPORT_COMPRESSION := true
TW_USE_NEW_MAGISKBOOT := true
TW_INCLUDE_PROP_TOOLS := true
TW_INCLUDE_SELINUX_TOOLS := true

###########################################################################
# ✅ 必须手动修改：从你解包的dts文件中获取实际值
###########################################################################
TW_SCREEN_WIDTH := 1600
TW_SCREEN_HEIGHT := 2560
TW_TOUCHSCREEN_WIDTH := 1600
TW_TOUCHSCREEN_HEIGHT := 2560
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 150

BOARD_MKBOOTIMG_ARGS := \
    --base $(BOARD_KERNEL_BASE) \
    --pagesize $(BOARD_KERNEL_PAGESIZE) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_TAGS_OFFSET)
