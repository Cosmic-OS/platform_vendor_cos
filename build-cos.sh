#!/bin/bash
# Copyright (C) 2016-2017 Cosmic OS Project
# Copyright (C) 2015 Paranoid Android Project
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

# PA Colors
# red = errors, cyan = warnings, green = confirmations, blue = informational
# plain for generic text, bold for titles, reset flag at each end of line
# plain blue should not be used for readability reasons - use plain cyan instead
CLR_RST=$(tput sgr0)                        ## reset flag
CLR_RED=$CLR_RST$(tput setaf 1)             #  red, plain
CLR_GRN=$CLR_RST$(tput setaf 2)             #  green, plain
CLR_BLU=$CLR_RST$(tput setaf 4)             #  blue, plain
CLR_CYA=$CLR_RST$(tput setaf 6)             #  cyan, plain
CLR_BLD=$(tput bold)                        ## bold flag
CLR_BLD_RED=$CLR_RST$CLR_BLD$(tput setaf 1) #  red, bold
CLR_BLD_GRN=$CLR_RST$CLR_BLD$(tput setaf 2) #  green, bold
CLR_BLD_BLU=$CLR_RST$CLR_BLD$(tput setaf 4) #  blue, bold
CLR_BLD_CYA=$CLR_RST$CLR_BLD$(tput setaf 6) #  cyan, bold

# Nuke scrollback
echo -e '\0033\0143'
clear

# Cosmic OS ASCII
sleep 2
        echo -e "${CLR_BLD_BLU}_________  ________    _________ ${CLR_RST}"
        echo -e "${CLR_BLD_BLU}\_   ___ \ \_____  \  /   _____/ ${CLR_RST}"
        echo -e "${CLR_BLD_BLU}/    \  \/  /   |   \ \_____  \  ${CLR_RST}"
        echo -e "${CLR_BLD_BLU}\     \____/    |    \/        \ ${CLR_RST}"
        echo -e "${CLR_BLD_BLU} \______  /\_______  /_______  / ${CLR_RST}"
        echo -e "${CLR_BLD_BLU}        \/         \/        \/  ${CLR_RST}"
	    echo -e ""
	    echo -e "${CLR_BLD_BLU}================================${CLR_RST}"
	    echo -e "${CLR_BLD_BLU}         Cosmic OS 3.0          ${CLR_RST}"
	    echo -e "${CLR_BLD_BLU}================================${CLR_RST}"
	    echo -e ""
	
sleep 2
	
# Output usage help
function showHelpAndExit {
        echo -e "${CLR_BLD_BLU}usage: $0 <device> [options]${CLR_RST}"
        echo -e ""
        echo -e "${CLR_BLD_BLU}options:${CLR_RST}"
        echo -e "${CLR_BLD_BLU}  -h, --help     display this help message${CLR_RST}"
        echo -e "${CLR_BLD_BLU}  -c, --clean    wipe the tree before building${CLR_RST}"
        echo -e "${CLR_BLD_BLU}  -u, --user     build a user build for distribution${CLR_RST}"
        exit 1
}

# Make sure we are running on 64-bit before carrying on with anything
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
if [ "$ARCH" != "64" ]; then
        echo -e "${CLR_BLD_RED}error: unsupported arch (expected: 64, found: $ARCH)${CLR_RST}"
        exit 1
fi

# Set up paths
DIR_ROOT=$(pwd)
DIR_OUT=$(readlink $DIR_ROOT/out)
[ -z "$DIR_OUT" ] && DIR_OUT="$DIR_ROOT/out"

# Make sure everything looks sane so far
 if [ ! -d "$DIR_ROOT/vendor/cos" ]; then
         echo -e "${CLR_BLD_RED}error: insane root directory ($DIR_ROOT)${CLR_RST}"
         exit 1
 fi
 
# Pick the default thread count (allow overrides from the environment)
if [ -z "$THREADS" ]; then
        if [ "$(uname -s)" = 'Darwin' ]; then
                export THREADS=$(sysctl -n machdep.cpu.core_count)
        else
                export THREADS=$(cat /proc/cpuinfo | grep '^processor' | wc -l)
        fi
fi

# COS Version
COS_VER=$(cat $DIR_ROOT/vendor/cos/common.mk | grep 'COS_VER := *' | sed 's/.*= //')

# Grab all the command-line parameters
export DEVICE=$1
shift

if [ -z "$DEVICE" ]; then
        echo -e "${CLR_BLD_RED}error: device not specified${CLR_RST}"
        showHelpAndExit
fi

case $DEVICE in
-h|--help|h|help)
        showHelpAndExit
        ;;
esac

while [[ "$#" > 0 ]]; do
        PARAM=$(echo ${1,,})
        case $PARAM in
        -h|--help|h|help)
            showHelpAndExit
            ;;
        -c|--clean|c|clean)
            FLAG_CLEAN_BUILD=y
            ;;
        -u|--user|u|user)
            FLAG_USER_BUILD=y
            ;;
        *)
            echo -e "${CLR_CYA}warning: skipping unknown parameter: $1${CLR_RST}"
            ;;
        esac
        shift
done

# Prep for a clean build, if requested so
if [ "$FLAG_CLEAN_BUILD" = 'y' ]; then
        echo -e "${CLR_BLD_BLU}Cleaning output files left from old builds${CLR_RST}"
        echo -e ""
        rm -rf ${DIR_ROOT}/out/target/product/$DEVICE
fi

# Check the starting time (of the real build process)
TIME_START=$(date +%s.%N)

# Friendly logging to tell the user everything is working fine is always nice
echo -e "${CLR_BLD_GRN}Building Cosmic OS $COS_VER for $DEVICE${CLR_RST}"
echo -e "${CLR_GRN}Start time: $(date)${CLR_RST}"
echo -e ""

# Initializationizing!
echo -e "${CLR_BLD_BLU}Setting up the environment${CLR_RST}"
echo -e ""
. build/envsetup.sh
echo -e ""

# Lunch-time!
echo -e "${CLR_BLD_BLU}Lunching $DEVICE${CLR_RST} ${CLR_CYA}(Including dependencies sync)${CLR_RST}"
echo -e ""
if [ "$FLAG_USER_BUILD" = 'y' ]; then
        lunch "cos_$DEVICE-user"
else
        lunch "cos_$DEVICE-userdebug"
fi
echo -e ""

# Build away!
echo -e "${CLR_BLD_BLU}Starting compilation${CLR_RST}"
echo -e ""
if [ "$FLAG_USER_BUILD" = 'y' ]; then
        mka dist
else
        mka bacon
fi
echo -e ""

# Check the finishing time
TIME_END=$(date +%s.%N)

echo -e "${CLR_BLD_GRN}Total time elapsed:${CLR_RST} ${CLR_GRN}$(echo "($TIME_END - $TIME_START) / 60" | bc) minutes ($(echo "$TIME_END - $TIME_START" | bc) seconds)${CLR_RST}"
echo -e ""
