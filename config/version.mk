# Copyright (C) 2024 ApexOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ANDROID_VERSION := 14
APEXVERSION := 1.0

APEX_BUILD_TYPE ?= UNOFFICIAL
APEX_MAINTAINER ?= UNKNOWN
APEX_DATE_YEAR := $(shell date -u +%Y)
APEX_DATE_MONTH := $(shell date -u +%m)
APEX_DATE_DAY := $(shell date -u +%d)
APEX_DATE_HOUR := $(shell date -u +%H)
APEX_DATE_MINUTE := $(shell date -u +%M)
APEX_BUILD_DATE := $(APEX_DATE_YEAR)$(APEX_DATE_MONTH)$(APEX_DATE_DAY)-$(APEX_DATE_HOUR)$(APEX_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst apex_,,$(APEX_BUILD))

# OFFICIAL_DEVICES
ifeq ($(APEX_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/apex/config/apex.devices)
    ifeq ($(filter $(APEX_BUILD), $(LIST)), $(APEX_BUILD))
      IS_OFFICIAL=true
      APEX_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      APEX_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(APEX_BUILD)")
    endif
endif

APEX_VERSION := $(APEXVERSION)-$(APEX_BUILD)-$(APEX_BUILD_DATE)-VANILLA-$(APEX_BUILD_TYPE)
ifeq ($(WITH_GAPPS), true)
APEX_VERSION := $(APEXVERSION)-$(APEX_BUILD)-$(APEX_BUILD_DATE)-GAPPS-$(APEX_BUILD_TYPE)
endif
APEX_MOD_VERSION :=$(ANDROID_VERSION)-$(APEXVERSION)
APEX_DISPLAY_VERSION := ApexOS-$(APEXVERSION)-$(APEX_BUILD_TYPE)
APEX_DISPLAY_BUILDTYPE := $(APEX_BUILD_TYPE)
APEX_FINGERPRINT := ApexOS/$(APEX_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(APEX_BUILD_DATE)

# APEX System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.apex.version=$(APEX_DISPLAY_VERSION) \
  ro.apex.build.status=$(APEX_BUILD_TYPE) \
  ro.modversion=$(APEX_MOD_VERSION) \
  ro.apex.build.date=$(APEX_BUILD_DATE) \
  ro.apex.buildtype=$(APEX_BUILD_TYPE) \
  ro.apex.fingerprint=$(APEX_FINGERPRINT) \
  ro.apex.device=$(APEX_BUILD) \
  org.apex.version=$(APEXVERSION) \
  ro.apex.maintainer=$(APEX_MAINTAINER)