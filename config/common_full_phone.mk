# Inherit full common Apex stuff
$(call inherit-product, vendor/apex/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Apex LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/apex/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/apex/overlay/dictionaries

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

$(call inherit-product, vendor/apex/config/telephony.mk)
