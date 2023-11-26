#
# Copyright 2018 The Android Open Source Project
# Copyright 2014-2022 The Team Win LLC
#
# SPDX-License-Identifier: Apache-2.0
#

# Define hardware platform
PRODUCT_PLATFORM := sm6150

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Crypto
PRODUCT_SYSTEM_PROPERTIES += \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.metadata.method=dm-default-key \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.volume.options=::v2

# Fastbootd
TW_INCLUDE_FASTBOOTD := true

PRODUCT_PACKAGES += \
    fastbootd \
	android.hardware.fastboot@1.1-impl-mock

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# API
PRODUCT_SHIPPING_API_LEVEL := 29

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH) \
	vendor/qcom/opensource/commonsys-intf/display

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
	libion \
	vendor.display.config@1.0 \
	vendor.display.config@2.0 \
	libdisplayconfig.qti

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
	$(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
	$(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so

# Overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=$(PRODUCT_RELEASE_NAME) \
	TARGET_DEVICE=$(PRODUCT_RELEASE_NAME)

PRODUCT_PROPERTY_OVERRIDES += \
	ro.product.device=$(PRODUCT_RELEASE_NAME)
