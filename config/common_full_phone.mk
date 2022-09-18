# Inherit full common Cosmic-OS stuff
$(call inherit-product, vendor/cos/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cos/overlay/dictionaries

$(call inherit-product, vendor/cos/config/telephony.mk)
