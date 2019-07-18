ifneq ($(IS_GENERIC_SYSTEM_IMAGE), true)
ifeq ($(COSMIC_BUILD_TYPE), OFFICIAL)

ifeq ($(IS_GO_VERSION), true)
COSMIC_OTA_VERSION_CODE := pie_go
else
COSMIC_OTA_VERSION_CODE := pie
endif

CUSTOM_PROPERTIES += \
    ro.cos.ota.version_code=$(COSMIC_OTA_VERSION_CODE)

PRODUCT_PACKAGES += \
    Updates

PRODUCT_COPY_FILES += \
    vendor/cos/config/permissions/ro.cos.ota.xml:system/etc/permissions/ro.cos.ota.xml

endif
endif
