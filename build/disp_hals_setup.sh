# A workaround for display HAL soong namespace issue by manually
# copying the display HAL to a temporary dir and removing
# "soong_namespace {}" in Android.bp

HAL_VARIANT=$(get_build_var QCOM_HARDWARE_VARIANT)
HAL_PATH="$ANDROID_BUILD_TOP/hardware/qcom/display/$HAL_VARIANT"
TEMP_PATH="$ANDROID_BUILD_TOP/hardware/qcom/display/temp"

rm -rf $TEMP_PATH

if [[ -f "$HAL_PATH/Android.bp" ]]; then
    if [[ $(sed 1q $HAL_PATH/Android.bp) == *soong_namespace* ]]; then
        echo -e "\nConfiguring display HAL: $HAL_VARIANT \n"
        cp -a $HAL_PATH $TEMP_PATH
        sed -i '1,3d' $TEMP_PATH/Android.bp
    fi
fi
