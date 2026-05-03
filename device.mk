# Copyright (C) 2026 TeamWin Recovery Project
# Licensed under the Apache License, Version 2.0
#

# 继承顺序不能改：先基础系统，再QCOM通用，最后本设备
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, device/qcom/common/common.mk)

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
    ro.twrp.build.type=unofficial
