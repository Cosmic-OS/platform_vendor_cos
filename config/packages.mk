# Cosmic-OS packages
PRODUCT_PACKAGES += \
    Updater \
    ThemePicker \
    RepainterServicePriv

ifneq ($(USE_GAPPS),true)
PRODUCT_PACKAGES += \
    Apps \
    GmsCompat \
    Seedvault
endif

# Extra tools in Cosmic
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    zip

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync
