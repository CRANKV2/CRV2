#!/system/bin/sh
MODDIR=${0%/*}

#Removing Unnecessary Files
rm -rf $MODPATH/LICENSE

#Path
FILESPATH="system/bin"
Path="/sdcard"

wait_until_login() {
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
ModulPath=/data/adb/modules
ModulId="STRP"
if [ ! -z "$1" ];then
echo "$1" > $ModulPath/$ModulId/system/vendor/etc/thermal-status.txt
fi
ThermalStatus="$(cat "$ModulPath/$ModulId/system/vendor/etc/thermal-status.txt")"
if [ "$ThermalStatus" == "0" ];then
cp -af $ModulPath/$ModulId/system/vendor/etc/thermal-engine.stock.conf $ModulPath/$ModulId/system/vendor/etc/thermal-engine.conf
cp -af $ModulPath/$ModulId/system/vendor/bin/thermal-engine-ori $ModulPath/$ModulId/system/vendor/bin/thermal-engine
elif  [ "$ThermalStatus" == "1" ];then
cp -af $ModulPath/$ModulId/system/vendor/etc/thermal-engine.v3.conf $ModulPath/$ModulId/system/vendor/etc/thermal-engine.conf
cp -af $ModulPath/$ModulId/system/vendor/bin/thermal-engine-ori $ModulPath/$ModulId/system/vendor/bin/thermal-engine
elif  [ "$ThermalStatus" == "2" ];then
cp -af $ModulPath/$ModulId/system/vendor/etc/thermal-engine.v4.conf $ModulPath/$ModulId/system/vendor/etc/thermal-engine.conf
cp -af $ModulPath/$ModulId/system/vendor/bin/thermal-engine-ori $ModulPath/$ModulId/system/vendor/bin/thermal-engine
elif  [ "$ThermalStatus" == "3" ];then
cp -af $ModulPath/$ModulId/system/vendor/etc/thermal-engine.v5.conf $ModulPath/$ModulId/system/vendor/etc/thermal-engine.conf
cp -af $ModulPath/$ModulId/system/vendor/bin/thermal-engine-blank $ModulPath/$ModulId/system/vendor/bin/thermal-engine
fi

#Download Readme
sleep 5
am start -a android.intent.action.MAIN -e toasttext "ππ©π§ππ©π€π¨π₯πππ§π ππ£ππ©πππ‘ππ―ππ£π..." -n bellavita.toast/.MainActivity
sleep 5
am start -a android.intent.action.MAIN -e toasttext "πΎπ§πππ©ππ π½π? πΎππΌπππ2" -n bellavita.toast/.MainActivity
sleep 5
am start -a android.intent.action.MAIN -e toasttext "ππ€ππ£ @πΌ-π-π-πΎ π€π£ πππ‘πππ§ππ’" -n bellavita.toast/.MainActivity


sleep  25
stratospheretweaks