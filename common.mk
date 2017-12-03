PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.opa.eligible_device=true \
    ro.setupwizard.rotation_locked=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cos/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cos/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/cos/prebuilt/common/bin/whitelist:system/addon.d/whitelist

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/cos/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/cos/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/init.local.rc:root/init.local.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/cos/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/cos/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Misc packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Busybox \
    MusicFX \
    libemoji \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    powertop \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    Terminal \
    WallpaperPicker

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# RCS
PRODUCT_PACKAGES += \
    rcscommon \
    rcscommon.xml \
    rcsservice \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# Custom packages
PRODUCT_PACKAGES += \
    OTAUpdates \
    Phonograph \
    CosmicWalls \
    Galaxy

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += \
    Recorder

# Turbo
PRODUCT_PACKAGES += \
    Turbo

# World APN list
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

PRODUCT_PACKAGE_OVERLAYS += \
	vendor/cos/overlay/common

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter arm64,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

# Dialer fix
PRODUCT_COPY_FILES +=  \
    vendor/cos/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# COS Versioning
ANDROID_VERSION = 8.0.0
PLATFORM_VERSION_CODENAME = REL

ifeq ($(KBUILD_BUILD_USER),Savitar)
    ifeq ($(KBUILD_BUILD_HOST),Saturn)
      COS_RELEASE=true
    endif
else
    COS_RELEASE=false
endif

ifndef COS_BUILD_TYPE
ifeq ($(COS_RELEASE),true)
    ifeq ($(COS_BIWEEKLY),true)
      COS_BUILD_TYPE := BIWEEKLY
      PLATFORM_VERSION_CODENAME := OFFICIAL
    else
      COS_BUILD_TYPE := OFFICIAL
      PLATFORM_VERSION_CODENAME := OFFICIAL
    endif
else
    COS_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
endif
endif

ifeq ($(COS_BETA),true)
    COS_BUILD_TYPE := BETA
    PLATFORM_VERSION_CODENAME := BETA
endif

ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
    COS_BUILD_TYPE := $(TARGET_UNOFFICIAL_BUILD_ID)
endif

COS_VERSION_NUMBER := 3.0
COS_VER := $(COS_VERSION_NUMBER)-$(COS_BUILD_TYPE)
COS_CODENAME := Chronus

# Set all versions
COS_VERSION := Cosmic-OS_$(COS_CODENAME)_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VER)
COS_MOD_VERSION := Cosmic-OS_$(COS_CODENAME)_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VER)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.cos.version=$(COS_VER) \
    ro.mod.version=$(COS_VER)

ifeq ($(COS_RELEASE),true)
    CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
    LIST = $(shell curl -s https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_cos/oreo/cos.devices)
    FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
    endif
    ifneq ($(IS_OFFICIAL), true)
       COS_RELEASE=false
       $(error Device is not official "$(FOUND)")
    endif
    PRODUCT_PROPERTY_OVERRIDES += \
        persist.ota.romname=$(TARGET_PRODUCT) \
        persist.ota.version=$(shell date +%Y%m%d) \
        persist.ota.manifest=https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_ota/oreo/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif

$(call inherit-product-if-exists, vendor/extra/product.mk)
