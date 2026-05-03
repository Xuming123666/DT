# Copyright (C) 2026 TeamWin Recovery Project
# Licensed under the Apache License, Version 2.0
#

# 唯一必需的继承：TWRP官方通用配置
$(call inherit-product, vendor/twrp/config/common.mk)

# 设备文件复制（路径必须和你设备树完全一致，大小写敏感）
PRODUCT_COPY_FILES += \
    device/Readboy/msm8998/fstab.ab:root/fstab.ab \
    device/Readboy/msm8998/init.recovery.qcom.rc:root/init.recovery.qcom.rc

# 设备属性（必须和twrp_msm8998.mk完全一致，大小写敏感）
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.device.name=msm8998 \
    ro.twrp.vendor.name=Readboy \
    ro.product.device=msm8998 \
    ro.product.manufacturer=Readboy \
    ro.product.model=C30 \
    ro.twrp.build.type=unofficial \
    ro.build.ab_update=true \
    ro.boot.slot_suffix=_a \
    ro.twrp.ab_device=true \
    ro.twrp.allow_ab_backup=true \
    ro.twrp.allow_ab_flash=true \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1 \
    service.adb.enable=1 \
    sys.usb.config=adb,mtp

