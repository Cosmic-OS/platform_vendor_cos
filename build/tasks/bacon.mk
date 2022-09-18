# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
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

# -----------------------------------------------------------------
# Cosmic OTA update package

COS_TARGET_PACKAGE := $(PRODUCT_OUT)/Cosmic-OS-v$(COS_VERSION).zip
COS_TARGET_PACKAGE_FOLDER := $(PRODUCT_OUT)

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(COS_TARGET_PACKAGE)
	$(hide) $(SHA256) $(COS_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(COS_TARGET_PACKAGE).sha256sum

	@echo -e ${CL_CYN}" ▄████▄   ▒█████    ██████  ███▄ ▄███▓ ██▓ ▄████▄      ▒█████    ██████  "${CL_RST}
	@echo -e ${CL_CYN}"▒██▀ ▀█  ▒██▒  ██▒▒██    ▒ ▓██▒▀█▀ ██▒▓██▒▒██▀ ▀█     ▒██▒  ██▒▒██    ▒  "${CL_RST}
	@echo -e ${CL_CYN}"▒▓█    ▄ ▒██░  ██▒░ ▓██▄   ▓██    ▓██░▒██▒▒▓█    ▄    ▒██░  ██▒░ ▓██▄    "${CL_RST}
	@echo -e ${CL_CYN}"▒▓▓▄ ▄██▒▒██   ██░  ▒   ██▒▒██    ▒██ ░██░▒▓▓▄ ▄██▒   ▒██   ██░  ▒   ██▒ "${CL_RST}
	@echo -e ${CL_CYN}"▒ ▓███▀ ░░ ████▓▒░▒██████▒▒▒██▒   ░██▒░██░▒ ▓███▀ ░   ░ ████▓▒░▒██████▒▒ "${CL_RST}
	@echo -e ${CL_CYN}"░ ░▒ ▒  ░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░ ▒░   ░  ░░▓  ░ ░▒ ▒  ░   ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░ "${CL_RST}
	@echo -e ${CL_CYN}"  ░  ▒     ░ ▒ ▒░ ░ ░▒  ░ ░░  ░      ░ ▒ ░  ░  ▒        ░ ▒ ▒░ ░ ░▒  ░ ░ "${CL_RST}
	@echo -e ${CL_CYN}"░        ░ ░ ░ ▒  ░  ░  ░  ░      ░    ▒ ░░           ░ ░ ░ ▒  ░  ░  ░   "${CL_RST}
	@echo -e ${CL_CYN}"░ ░          ░ ░        ░         ░    ░  ░ ░             ░ ░        ░   "${CL_RST}
	@echo -e ${CL_CYN}"░                                         ░                              "${CL_RST}
	@echo -e ${CL_BLD}${CL_CYN}"===============================-Package complete-==============================="${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Folder : "${CL_YLW} $(COS_TARGET_PACKAGE_FOLDER)${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Zip    : "${CL_YLW} $(COS_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"MD5    : "${CL_YLW}" `cat $(COS_TARGET_PACKAGE).md5sum | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Size   : "${CL_YLW}" `du -sh $(COS_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_CYN}"================================================================================"${CL_RST}
