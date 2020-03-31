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

#
# Handle various build version information.
#
# Guarantees that the following are defined:
#     COSMIC_VERSION
#     COSMIC_VERSION_CODE
#     COSMIC_BUILD_TYPE
#

ifndef COSMIC_VERSION
  # This is the global cosmic version that determines our releases
  # in various types. The types are defined as Major, Minor, and Maintenance.
  # Example of this syntax:
  # Major: The first number indicates a major system upgrade
  # Minor: The second number indicates a minor system upgrade which
  #        may include system pacthes for improvements and small new features.
  # Maintenance: The third number indicates a maintenance system upgrade with
  #              small, but effective improvements throughout the system.
  COSMIC_VERSION := 5.0
endif

ifndef COSMIC_VERSION_CODE
  # As part of the cosmic platform, each Major system upgrade is released
  # under a specific codename. The indicates which codename for which
  # major system upgrade under the cosmic platform.
  COSMIC_VERSION_CODE := Quasar
endif

ifndef COSMIC_BUILD_TYPE
  # We build unofficial by default
  COSMIC_BUILD_TYPE := UNOFFICIAL
endif

ifndef CAF_VERSION
  # Current CAF version.
  CAF_VERSION := LA.UM.8.11.r1-02900-NICOBAR.0
endif

# Output target zip name
COSMIC_TARGET_ZIP := Cosmic-OS-v$(COSMIC_VERSION)-$(COSMIC_VERSION_CODE)-$(COSMIC_BUILD)-$(shell date -u +%Y%m%d-%H%M)-$(COSMIC_BUILD_TYPE).zip

# Branding Props
CUSTOM_PROPERTIES += \
    ro.modversion=$(COSMIC_VERSION)-$(shell date -u +%Y%m%d) \
    ro.qti.caf.version=$(CAF_VERSION) \
    ro.cos.version=$(COSMIC_VERSION) \
    ro.cos.version_code=$(COSMIC_VERSION_CODE) \
    ro.cos.device=$(COSMIC_BUILD) \
    ro.cos.releasetype=$(COSMIC_BUILD_TYPE) \
    ro.cos.builddate=$(shell date -u +%Y%m%d)
