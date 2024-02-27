# Inherit common mobile Apex stuff
$(call inherit-product, vendor/apex/config/common.mk)

# Include AOSP audio files
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage14.mk)
include vendor/apex/config/aosp_audio.mk

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub