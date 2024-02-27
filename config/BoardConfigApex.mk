include vendor/apex/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/apex/config/BoardConfigQcom.mk
endif

include vendor/apex/config/BoardConfigSoong.mk