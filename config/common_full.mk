# Inherit common Cosmic-OS stuff
$(call inherit-product, vendor/cos/config/common_mobile.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
