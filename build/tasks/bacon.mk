# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2018 The PixelExperience Project
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

COSMIC_TARGET_PACKAGE := $(PRODUCT_OUT)/$(COSMIC_VERSION).zip

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(COSMIC_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(COSMIC_TARGET_PACKAGE) > $(COSMIC_TARGET_PACKAGE).md5sum
	$(hide) ./vendor/cos/tools/generate_json_build_info.sh $(COSMIC_TARGET_PACKAGE)

	echo -e ${CL_CYN}" ▄████▄   ▒█████    ██████  ███▄ ▄███▓ ██▓ ▄████▄      ▒█████    ██████  "${CL_RST}
	echo -e ${CL_CYN}"▒██▀ ▀█  ▒██▒  ██▒▒██    ▒ ▓██▒▀█▀ ██▒▓██▒▒██▀ ▀█     ▒██▒  ██▒▒██    ▒  "${CL_RST}
	echo -e ${CL_CYN}"▒▓█    ▄ ▒██░  ██▒░ ▓██▄   ▓██    ▓██░▒██▒▒▓█    ▄    ▒██░  ██▒░ ▓██▄    "${CL_RST}
	echo -e ${CL_CYN}"▒▓▓▄ ▄██▒▒██   ██░  ▒   ██▒▒██    ▒██ ░██░▒▓▓▄ ▄██▒   ▒██   ██░  ▒   ██▒ "${CL_RST}
	echo -e ${CL_CYN}"▒ ▓███▀ ░░ ████▓▒░▒██████▒▒▒██▒   ░██▒░██░▒ ▓███▀ ░   ░ ████▓▒░▒██████▒▒ "${CL_RST}
	echo -e ${CL_CYN}"░ ░▒ ▒  ░░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░░ ▒░   ░  ░░▓  ░ ░▒ ▒  ░   ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░ "${CL_RST}
	echo -e ${CL_CYN}"  ░  ▒     ░ ▒ ▒░ ░ ░▒  ░ ░░  ░      ░ ▒ ░  ░  ▒        ░ ▒ ▒░ ░ ░▒  ░ ░ "${CL_RST}
	echo -e ${CL_CYN}"░        ░ ░ ░ ▒  ░  ░  ░  ░      ░    ▒ ░░           ░ ░ ░ ▒  ░  ░  ░   "${CL_RST}
	echo -e ${CL_CYN}"░ ░          ░ ░        ░         ░    ░  ░ ░             ░ ░        ░   "${CL_RST}
	echo -e ${CL_CYN}"░                                         ░                              "${CL_RST}
	@echo -e ${CL_BLD}${CL_CYN}"===============================-Package complete-==============================="${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Zip: "${CL_YLW} $(COSMIC_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"MD5: "${CL_YLW}" `cat $(COSMIC_TARGET_PACKAGE).md5sum | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_YLW}"Size:"${CL_YLW}" `du -sh $(COSMIC_TARGET_PACKAGE) | awk '{print $$1}' `"${CL_RST}
	@echo -e ${CL_BLD}${CL_CYN}"================================================================================"${CL_RST}
