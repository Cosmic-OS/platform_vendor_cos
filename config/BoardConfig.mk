include vendor/cos/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/cos/config/BoardConfigQcom.mk
endif

include vendor/cos/config/BoardConfigSoong.mk
