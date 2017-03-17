for combo in $(cat $(gettop)/vendor/cos/cos.devices  | sed -e 's/#.*$//' | awk '{printf "cos_%s-userdebug\n", $1}')
do
    add_lunch_combo $combo
done
