for device in $(cat vendor/cos/cosmic-os.devices)
do
    add_lunch_combo cos_$device-eng
    add_lunch_combo cos_$device-user
    add_lunch_combo cos_$device-userdebug
done
