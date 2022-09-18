# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# Cosmic-OS Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.cos.display.version=$(COS_DISPLAY_VERSION) \
    ro.cos.build.version=$(COS_BUILD_VERSION) \
    ro.cos.build.date=$(BUILD_DATE) \
    ro.cos.buildtype=$(COS_BUILD_TYPE) \
    ro.cos.fingerprint=$(ROM_FINGERPRINT) \
    ro.cos.version=$(COS_VERSION) \
    ro.cos.base.version=$(COS_NUM_VER) \
    ro.cos.base.codename=$(COS_CODENAME) \
    ro.modversion=$(COS_VERSION)
