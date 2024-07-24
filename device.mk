#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# A/B
TARGET_IS_VAB := true

# Inherit from sm8250-common
$(call inherit-product, device/xiaomi/sm8250-common/kona.mk)

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Audio configs
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1600

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/camera/camera_cnf.txt:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_cnf.txt

PRODUCT_PACKAGES += \
    libpiex_shim

# Display Config
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/displayconfig/,$(TARGET_COPY_OUT_PRODUCT)/etc/displayconfig)

# Fingerprint
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi

# Mlipay
PRODUCT_COPY_FILES += \
    vendor/xiaomi/sm8250-common/proprietary/vendor/bin/mlipayd@1.1:$(TARGET_COPY_OUT_VENDOR)/bin/mlipayd@1.1 \
    vendor/xiaomi/sm8250-common/proprietary/vendor/etc/init/vendor.xiaomi.hardware.mlipay@1.1-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.xiaomi.hardware.mlipay@1.1-service.rc \
    vendor/xiaomi/sm8250-common/proprietary/vendor/lib64/libmlipay.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmlipay.so \
    vendor/xiaomi/sm8250-common/proprietary/vendor/lib64/libmlipay@1.1.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libmlipay@1.1.so

PRODUCT_PACKAGES += \
    manifest_vendor.xiaomi.hardware.mlipay \
    vendor.xiaomi.hardware.mlipay@1.1.vendor \
    vendor.xiaomi.hardware.mtdservice@1.2.vendor

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

# Peripheral Manager
PRODUCT_PACKAGES += \
    XiaomiPeripheralManager

# QDCM
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/qdcm/,$(TARGET_COPY_OUT_VENDOR)/etc)

# Shipping API level
BOARD_SHIPPING_API_LEVEL := 30
PRODUCT_SHIPPING_API_LEVEL := 30

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# SoterService
PRODUCT_PACKAGES += \
    SoterService

# Tablet
PRODUCT_CHARACTERISTICS := tablet
TARGET_IS_TABLET := true

# Touchfeature
PRODUCT_PACKAGES += \
    vendor.xiaomi.hardware.touchfeature@1.0.vendor

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.touchfeature.type=43

# Inherit from vendor blobs
$(call inherit-product, vendor/xiaomi/elish/elish-vendor.mk)
