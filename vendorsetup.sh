for combo in $(curl -s https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_cos/n7.1.2/cos.devices  | sed -e 's/#.*$//' | awk '{printf "cos_%s-userdebug\n", $1}')
do
    add_lunch_combo $combo
done
