for device in $(python vendor/cos/tools/get_official_devices.py)
do
for var in user userdebug; do
add_lunch_combo cos_$device-$var
done
done
