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
    ro.setupwizard.rotation_locked=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# For stereo widening effect
ifneq ($(TARGET_NO_DSPMANAGER), true)
 PRODUCT_PACKAGES += \
 libcyanogen-dsp \
 audio_effects.conf
endif

# Thank you, please drive thru! 
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cos/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cos/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/cos/prebuilt/common/bin/whitelist:system/addon.d/whitelist \

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/cos/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# Magisk
ifeq ($(INCLUDE_MAGISK),true)
export INCLUDE_MAGISK
PRODUCT_COPY_FILES += \
   vendor/cos/prebuilt/common/etc/Magisk.zip:system/addon.d/Magisk.zip \
   vendor/cos/prebuilt/common/etc/MagiskManager.apk:system/priv-app/MagiskManager/MagiskManager.apk

# KernelAdiutor
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/app/KernelAdiutor.apk:system/priv-app/KernelAdiutor/KernelAdiutor.apk

endif

# SuperSU
ifeq ($(INCLUDE_SUPERSU),true)
export INCLUDE_SUPERSU
PRODUCT_COPY_FILES += \
   vendor/cos/prebuilt/common/etc/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
   vendor/cos/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# KernelAdiutor
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/app/KernelAdiutor.apk:system/priv-app/KernelAdiutor/KernelAdiutor.apk

endif

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/cos/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/cos/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/init.local.rc:root/init.cos.rc

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
    mke2fs \
    tune2fs \
    bash \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    su \
    Terminal


# Launcher
ifeq ($(USE_LAUNCHER3),true)
PRODUCT_PACKAGES += \
    Launcher3
else
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/app/PixelLauncherPrebuilt.apk:system/priv-app/PixelLauncher/PixelLauncherPrebuilt.apk \
    vendor/cos/prebuilt/common/app/WallpaperPickerGooglePrebuilt.apk:system/priv-app/WallpaperPickerGoogle/WallpaperPickerGooglePrebuilt.apk
endif

# Amaze File Manager
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/app/AmazeFileManager.apk:system/priv-app/AmazeFileManager/AmazeFileManager.apk

# Phonograph
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/app/Phonograph.apk:system/app/Phonograph/Phonograph.apk

# Turbo
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/app/Turbo.apk:system/app/Turbo/Turbo.apk

# Extra Optional packages
PRODUCT_PACKAGES += \
     ThemeInterfacer \
     LockClock \
     Snap \
     OmniStyle \
     OmniSwitch \
     OmniJaws \
     OTAUpdates \
     CosmicWalls \
     Chromium

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Telephony packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    libphonenumbergoogle \
    messaging \
    Stk \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# World APN list
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Overlays & Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += \
	vendor/cos/overlay/common \
	vendor/cos/overlay/dictionaries

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

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Squisher Location
SQUISHER_SCRIPT := vendor/cos/tools/squisher

# COS Versioning
ANDROID_VERSION = 7.1.2
PLATFORM_VERSION_CODENAME = REL

ifndef COS_BUILD_TYPE
ifeq ($(COS_RELEASE),true)
    COS_BUILD_TYPE := OFFICIAL
    PLATFORM_VERSION_CODENAME := OFFICIAL
else
    COS_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
endif
endif

ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
    COS_BUILD_TYPE := $(TARGET_UNOFFICIAL_BUILD_ID)
endif

COS_VERSION_NUMBER := 1.5
COS_VER := $(COS_VERSION_NUMBER)-$(COS_BUILD_TYPE)

# Set all versions
COS_VERSION := Cosmic-OS_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VER)
COS_MOD_VERSION := Cosmic-OS_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VER)


PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.cos.version=$(COS_VER) \
    ro.mod.version=v$(COS_VER)

$(call inherit-product-if-exists, vendor/extra/product.mk)

# DUI
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils
PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

ifeq ($(COS_RELEASE),true)
    CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
    LIST = $(shell curl -s https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_cos/n7.1.2/cos.devices)
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
        persist.ota.manifest=https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_ota/n7.1.2/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif
