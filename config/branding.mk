#
# Copyright 2017-2019 Cosmic-OS
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

# Versioning System
COS_NUM_VER := 8.0

# As part of the cosmic platform, each Major system upgrade is released
# under a specific codename. The indicates which codename for which
# major system upgrade under the cosmic platform.
COS_CODENAME := Transit

TARGET_PRODUCT_SHORT := $(subst cos_,,$(COS_BUILD_TYPE))

ifndef COS_BUILD_TYPE
  # We build unofficial by default
  COS_BUILD_TYPE := UNOFFICIAL
endif

# Only include Updater for official  build
ifeq ($(filter-out OFFICIAL,$(COS_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        Updater
endif

# Sign builds if building an official build
ifeq ($(filter-out OFFICIAL,$(COS_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(KEYS_LOCATION)
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
COS_BUILD_VERSION := $(COS_NUM_VER)-$(COS_CODENAME)
COS_VERSION := $(COS_BUILD_VERSION)-$(COS_BUILD)-$(COS_BUILD_TYPE)-$(BUILD_TIME)-$(BUILD_DATE)
ifeq ($(USE_GAPPS), true)
COS_VERSION := $(COS_BUILD_VERSION)-$(COS_BUILD)-$(COS_BUILD_TYPE)-Gapps-$(BUILD_TIME)-$(BUILD_DATE)
endif
ROM_FINGERPRINT := Cosmic/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BUILD_TIME)
COS_DISPLAY_VERSION := $(COS_VERSION)
RELEASE_TYPE := $(COS_BUILD_TYPE)
