PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

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

# SuperSU
PRODUCT_COPY_FILES += \
   vendor/cos/prebuilt/common/etc/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
   vendor/cos/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

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

# Substratum
 PRODUCT_COPY_FILES += \
vendor/cos/prebuilt/common/app/substratum.apk:system/app/substratum/substratum.apk

# Pixel Launcher
 PRODUCT_COPY_FILES += \
vendor/cos/prebuilt/common/app/PixelLauncherPrebuilt.apk:system/priv-app/PixelLauncher/PixelLauncherPrebuilt.apk \
vendor/cos/prebuilt/common/app/WallpaperPickerGooglePrebuilt.apk:system/app/PixelLauncher/WallpaperPickerGooglePrebuilt.apk

# KernelAdiutor
 PRODUCT_COPY_FILES += \
vendor/cos/prebuilt/common/app/KernelAdiutor.apk:system/priv-app/KernelAdiutor/KernelAdiutor.apk

# Extra Optional packages
PRODUCT_PACKAGES += \
     masquerade \
     OmniSwitch \
     SnapdragonCamera \
     LockClock

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
ANDROID_VERSION = 7.0
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

COS_VER := 1.1
ifdef COS_BUILD_TYPE
    COS_VERSION_NUMBER = $(COS_VER)-$(COS_BUILD_TYPE)
else
    COS_VERSION_NUMBER = $(COS_VER)
endif

ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
    COS_BUILD_TYPE :=$(TARGET_UNOFFICIAL_BUILD_ID)
endif

# Set all versions
COS_VERSION := Cosmic-OS_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VERSION_NUMBER)
COS_MOD_VERSION := Cosmic-OS_$(COS_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(COS_VERSION_NUMBER)


PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.cos.version=$(COS_VERSION_NUMBER) \
    ro.mod.version=$(COS_BUILD_TYPE)-v$(COS_VERSION_NUMBER) \

$(call inherit-product-if-exists, vendor/extra/product.mk)

# Include UBER common configuration
include vendor/cos/config/uber.mk
