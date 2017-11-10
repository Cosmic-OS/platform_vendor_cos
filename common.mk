PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
#    ro.boot.vendor.overlay.theme=com.cosmic.overlay.base.stockfixed

# LatinIME gesture typing
ifneq ($(filter tenderloin,$(TARGET_PRODUCT)),)
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/cos/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/cos/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cos/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cos/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Custom packages
PRODUCT_PACKAGES += \
    CosmicWalls \
    Retro

# Cosmic-OS App
#PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/app/Cosmic-OS.apk:system/app/Cosmic-OS/Cosmic-OS.apk

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    librs_jni

# Offline charging animation
PRODUCT_PACKAGES += \
    charger_res_images

# Accent and Base packages
#PRODUCT_PACKAGES += \
    AmberTheme \
    BlueTheme \
    CyanTheme \
    DeepOrangeTheme \
    DeepPurpleTheme \
    GreenTheme \
    IndigoTheme \
    LightBlueTheme \
    LightGreenTheme \
    LimeTheme \
    OrangeTheme \
    PinkTheme \
    PixelBaseTheme \
    PixelTheme \
    PurpleTheme \
    RedTheme \
    StockBaseTheme \
    StockFixedBaseTheme \
    StockTheme \
    YellowTheme

# Black/DarkUI Packages
#PRODUCT_PACKAGES += \
    GBoardDarkTheme \
    SettingsBlackTheme \
    SettingsDarkTheme \
    SystemBlackTheme \
    SystemDarkTheme \
    SystemSettingsIconTint

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += \
    Recorder

# Misc packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Busybox \
    MusicFX \
    Terminal \
    LatinIME

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Fonts
PRODUCT_COPY_FILES += \
    vendor/cos/fonts/GoogleSans-Regular.ttf:system/fonts/GoogleSans-Regular.ttf \
    vendor/cos/fonts/GoogleSans-Medium.ttf:system/fonts/GoogleSans-Medium.ttf \
    vendor/cos/fonts/GoogleSans-MediumItalic.ttf:system/fonts/GoogleSans-MediumItalic.ttf \
    vendor/cos/fonts/GoogleSans-Italic.ttf:system/fonts/GoogleSans-Italic.ttf \
    vendor/cos/fonts/GoogleSans-Bold.ttf:system/fonts/GoogleSans-Bold.ttf \
    vendor/cos/fonts/GoogleSans-BoldItalic.ttf:system/fonts/GoogleSans-BoldItalic.ttf

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# World APN list
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

PRODUCT_PACKAGE_OVERLAYS += \
	vendor/cos/overlay/common

# COS Versioning
ANDROID_VERSION = 9.0
COSMIC_VERSION_CODENAME = REL

ifeq ($(KBUILD_BUILD_USER),Savitar)
    ifeq ($(KBUILD_BUILD_HOST),Saturn)
      COS_RELEASE=true
    endif
else
    COS_RELEASE=false
endif

ifeq ($(COS_RELEASE),true)
    ifeq ($(COS_BIWEEKLY),true)
      COS_BUILD_TYPE := BIWEEKLY
      COSMIC_VERSION_CODENAME := OFFICIAL
    else
      COS_BUILD_TYPE := OFFICIAL
      COSMIC_VERSION_CODENAME := OFFICIAL
    endif
else
    COS_BUILD_TYPE := UNOFFICIAL
    COSMIC_VERSION_CODENAME := UNOFFICIAL
endif

ifeq ($(COS_BETA),true)
    COS_BUILD_TYPE := BETA
    COSMIC_VERSION_CODENAME := BETA
endif

ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
    COS_BUILD_TYPE := $(TARGET_UNOFFICIAL_BUILD_ID)
endif

COS_VERSION_NUMBER := 4.0
COS_CODENAME := Corona
COS_VER := $(COS_VERSION_NUMBER)-$(COS_CODENAME)-$(COS_BUILD_TYPE)
COS_BUILD_DATE := $(shell date +%Y%m%d)

# Set all versions
COS_VERSION := Cosmic-OS_$(COS_CODENAME)_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VERSION_NUMBER)-$(COS_BUILD_TYPE)
COS_MOD_VERSION := Cosmic-OS_$(COS_CODENAME)_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VERSION_NUMBER)-$(COS_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.cos.version=$(COS_VER) \
    ro.mod.version=$(COS_VER) \
    ro.cos.build_date=$(COS_BUILD_DATE) \
    ro.cos.releasetype=$(COS_BUILD_TYPE)

ifeq ($(COS_RELEASE),true)
    CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
    LIST = $(shell curl -s https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_cos/pulsar-release/cos.devices)
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
        persist.ota.manifest=https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_ota/pulsar-release/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif
