CUSTOM_PLATFORM_VERSION := 14.0

BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
CUSTOM_VERSION := PixelProject_$(CUSTOM_BUILD)-$(CUSTOM_BUILD_TYPE)-$(CUSTOM_PLATFORM_VERSION)-$(BUILD_TIME)-$(BUILD_DATE)
CUSTOM_VERSION_PROP := fourteen


CUSTOM_BUILD_TYPE ?= Unofficial

# Only include Updater for official  build
ifeq ($(filter-out Official,$(CUSTOM_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater

PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/init/init.tpp-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.tpp-updater.rc
endif

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/aosp/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/aosp/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/aosp/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/aosp/signing/keys/otakey.x509.pem
endif
endif
