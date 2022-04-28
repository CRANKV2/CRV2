#!/system/bin/sh
MODDIR=${0%/*}
rm -rf $MODPATH/LICENSE
FILESPATH="system/bin"
Path="/sdcard"
bb="/data/adb/magisk/busybox"

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

sleep 2

# Update scripts once every reboot
wget -O "${MODPATH}/system/bin/crv2twtweaks" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/crv2twtweaks"
wget -O "${MODPATH}/system/bin/crv2menu" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/crv2menu"
wget -O "${MODPATH}/system/bin/cleaner" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/cleaner"
wget -O "${MODPATH}/system/bin/crv2twauto" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/crv2twauto"
wget -O "${MODPATH}/mod-util.sh" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/mod-util.sh"

# Readme
wget -O "${MODPATH}/storage/emulated/0/.CRV2/README.md" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/README.md"

# Make Toasts On Boot
sleep 10
am start -a android.intent.action.MAIN -e toasttext "Stratosphere Module Starting.." -n bellavita.toast/.MainActivity
sleep 5
am start -a android.intent.action.MAIN -e toasttext "A module made by @CRANKV2" -n bellavita.toast/.MainActivity
sleep 5
am start -a android.intent.action.MAIN -e toasttext "Join @A-R-M-C on Telegram" -n bellavita.toast/.MainActivity

# set swappiness to 100 (zram
echo 100 > /proc/sys/vm/swappiness

# Setup Tweaks
sleep 20
crv2twtweaks

# done

