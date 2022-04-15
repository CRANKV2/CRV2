#!/system/bin/sh
wait_until_login() {
	# we doesn't have the permission to rw "/sdcard" before the user unlocks the screen
	while [[ `getprop sys.boot_completed` -ne 1 && -d "/sdcard" ]]
	do
       sleep 2
	done

    local test_file="/sdcard/.PERMISSION_TEST"
    touch "$test_file"
    while [ ! -f "$test_file" ]; do
        touch "$test_file"
        sleep 2
    done
    rm "$test_file"
}
wait_until_login
# Readme
wget -O "${MODPATH}/storage/emulated/0/.CRV2/README.md" "https://raw.githubusercontent.com/CRANKV2/CRV2Tweaks/main/README.md"

# Setup tweaks
sleep 60
crv2twtweaks

# set swappiness to 100 (zram
echo 100 > /proc/sys/vm/swappiness

# done