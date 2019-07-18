ifeq ($(COS_RELEASE),true)
    CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
    LIST = $(shell curl -s https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_cos/corona-release/cos.devices)
    FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
    endif
    ifneq ($(IS_OFFICIAL), true)
       COS_RELEASE=false
       $(error Device is not official "$(FOUND)")
    endif
    PRODUCT_GENERIC_PROPERTIES += \
        persist.ota.romname=$(TARGET_PRODUCT) \
        persist.ota.version=$(shell date +%Y%m%d) \
        persist.ota.manifest=https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_ota/corona-release/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif
