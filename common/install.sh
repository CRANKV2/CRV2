ui_print " "
ui_print " - [⚡️] - 🇨‌🇻‌② 🇹‌🇼‌🇪‌🇦‌🇰‌🇸‌"
ui_print " "
ui_print " - [⚡️] - VERSION: 0.3.0 - 04/18/2022"
ui_print " "
ui_print " - [⚡️] - CODENAME: THUNDER"
sleep 2
ui_print " - [⚡️] - Your Device Is : $(getprop ro.build.product)"
ui_print " - [⚡️] - Your Mobile Phone Is  : $(getprop ro.product.model)"
ui_print " - [⚡️] - Your Manufacturer Is : $(getprop ro.product.system.manufacturer)"
ui_print " - [⚡️] - Your Processor Is : $(getprop ro.product.board)"
ui_print " - [⚡️] - Your CPU Is : $(getprop ro.hardware)"
ui_print " - [⚡️] - Your Android Version Is : $(getprop ro.build.version.release)"
ui_print " - [⚡️] - Your Kernel Is : $(uname -r)"
ui_print " - [⚡️] - Your RAM Free Is : $(free | grep Mem |  awk '{print $2}')"
sleep 3
ui_print " "
ui_print "With this module"
ui_print "you can choose"
ui_print "different profiles"
ui_print "and improve your user experience."
sleep 3
ui_print " "
sleep 0.5
ui_print "[⚡️] Do you want to fstrim the partitions? [Recommended]"
sleep 3
ui_print " "
ui_print " Vol + = Switch option"
ui_print ""
sleep 0.2
ui_print " Vol - = Select option"
sleep 1
ui_print " "
ui_print " 1- Yes "
ui_print ""
sleep 0.5
ui_print " 2- No "
ui_print " "
sleep 0.5
ui_print "[!] Select you're desired option: "
ui_print " "
AO=1
while true
do
ui_print "  $AO"
if $VKSEL 
then
AO=$((AO + 1))
else 
break
fi
if [ $AO -gt 2 ]
then
AO=1
fi
done

case $AO in
1 ) FCTEXTAD2="Yes";;
2 ) FCTEXTAD2="No";;
esac

ui_print " "
ui_print "[⚡️] Selected: $FCTEXTAD2 "
ui_print " "

if [[ $FCTEXTAD2 == "Yes" ]]
then
ui_print "Wait, process in progress..."
ui_print " "
sleep 1
fstrim -v /system;
fstrim -v /data;
fstrim -v /cache;
sleep 1
fstrim -v /vendor;
fstrim -v /product;
ui_print "DONE!"
fi
sleep 2
ui_print "[⚡️] Checking for possible conflicts..."
ui_print " "

if [ -d $MODDIR/FDE ]; then
ui_print "[!] FDE.AI Module detected, removing for security reasons."
touch $MODDIR/FDE/disable

elif [ -d $MODDIR/ktweak ]; then
ui_print "[!] KTweak Module detected, removing for security reasons."
touch $MODDIR/ktweak/disable

elif [ -d $MODDIR/ZeetaaTweaks ]; then
ui_print "[!] ZeetaaTweaks Module detected, removing for security reasons."
touch $MODDIR/ZeetaaTweaks/disable

elif [ -d $MODDIR/lv-gpu-performance ]; then
ui_print "[!] Lv-gpu-performance Module detected, removing for security reasons."
touch $MODDIR/lv-gpu-performance/disable

elif [ -d $MODDIR/R.kashyap ]; then
ui_print "[!] Gamers Edition Module detected, removing for security reasons."
touch $MODDIR/R.kashyap/disable

elif [ -d $MODDIR/ZTS ]; then
ui_print "[!] ZTS Module detected, removing for security reasons."
touch $MODDIR/ZTS/disable

elif [ -d $MODDIR/MAGNETAR ]; then
ui_print "[!] MAGNETAR Module detected, removing for security reasons."
touch $MODDIR/MAGNETAR/disable

elif [ -d $MODDIR/Apollon ]; then
ui_print "[!] Apollon Module detected, removing for security reasons."
touch $MODDIR/Apollon/disable

elif [ -d $MODDIR/Apollon-plus ]; then
ui_print "[!] Apollon Plus Module detected, removing for security reasons."
touch $MODDIR/Apollon-plus/disable

elif [ -d $MODDIR/gameexp ]; then
ui_print "[!] Improve Game Xperience Module detected, removing for security reasons."
touch $MODDIR/gameexp/disable

elif [ -d $MODDIR/lspeed ]; then
ui_print "[!] LSpeed Module detected, removing for security reasons."
touch $MODDIR/lspeed/disable

elif [ -d $MODDIR/fkm_spectrum_injector ]; then
ui_print "[!] FKM Injector Module detected, removing for security reasons."
touch $MODDIR/fkm_spectrum_injector/disable

elif [ -d $MODDIR/KTSR ]; then
ui_print "[!] KTSR Module detected, removing for security reasons."
touch $MODDIR/KSTR/disable

elif [ -d $MODDIR/lazy ]; then
ui_print "[!] Lazy Tweaks Module detected, removing for security reasons."
touch $MODDIR/lazy/disable

elif [ -d $MODDIR/injector ]; then
ui_print "[!] NFS Injector Module detected, removing for security reasons."
touch $MODDIR/injector/disable

elif [ -d $MODDIR/GamersExtreme ]; then
ui_print "[!] GamersExtreme Module detected, im removing it.."
touch $MODDIR/GamersExtreme/disable

elif [ -d $MODDIR/xengine ]; then
ui_print "[!] Xengine Module detected, im removing it.."
touch $MODDIR/xengine/disable

elif [ -d $MODDIR/PXT ]; then
ui_print "[!] PXT Module detected, im removing it.."
touch $MODDIR/PXT/disable

elif [ -d $MODDIR/Godspeed ]; then
ui_print "[!] GodSpeedModule Detected, im removing it.."
touch $MODDIR/GodSpeed/disable

elif [ "$(pm list package magnetarapp)" ]; then
ui_print "[!] MAGNETAR App has been detected, I recommend removing the app to avoid conflicts."

elif [ "$(pm list package ktweak)" ]; then
ui_print "[!] KTweak App has been detected, I recommend removing the app to avoid conflicts."

elif [ "$(pm list package lsandroid)" ]; then
ui_print "[!] LSpeed App has been detected, I recommend removing the app to avoid conflicts."

elif [ "$(pm list package feravolt)" ]; then
ui_print "[!] FDE.AI App has been detected, I recommend removing the app to avoid conflicts."

elif [ "$(pm list package kitana)" ]; then
ui_print "[!] Kitana Tweak App has been detected, I recommend removing the app to avoid conflicts."

elif [ "$(pm list package nfs)" ]; then
ui_print "[!] NFS Manager App has been detected, I recommend removing the app to avoid conflicts."

    fi
sleep 1.5

SC="/storage/emulated/0/Android/data/com.lnrgame.roguelike/files/SettingDatas.dat"
LIFE="/storage/emulated/0/Android/data/com.netease.mrzhna/files/netease/g66/Documents/configs/qualityconfig"
APEX="/data/data/com.ea.gp.apexlegendsmobilefps/files/UE4Game/AClient/AClient/Saved/Config/Android/UserCustom.ini"
 
sleep 3
ui_print " [!] Important:"
ui_print "These settings (can) cause"
ui_print "errors in system applications."
sleep 0.5
ui_print " "
ui_print "If u face some issue"
ui_print "don't use one of this options"
ui_print "handle with care!"
sleep 1
ui_print " "
ui_print "Might not work"
ui_print "if you are using magiskhideprops"
ui_print "or other Tweak module"
ui_print " "
ui_print " "
sleep 0.5
ui_print " 1- None"
ui_print " "
sleep 0.5
ui_print " 2- CODM 120 FPS Settings"
ui_print " "
sleep 0.5
ui_print " 3- PUBGM 90 FPS Settings "
ui_print " "
sleep 0.5
ui_print " 4- ML Max Settings "
ui_print " "
sleep 0.5
ui_print " 5- Asphalt 9 and Sky Children of the Light 60 FPS Settings"
ui_print " "
sleep 0.5
ui_print " 6- Game for Peace 90 FPS Settings"
ui_print " "
sleep 0.5
ui_print " 7- LifeAfter 120 FPS Settings"
ui_print " "
sleep 0.5
ui_print " 8- Apex Legends 120 FPS Settings"
ui_print " "
sleep 0.5
ui_print " 9- Super Clone 120 FPS Settings"
ui_print " "
sleep 0.5
ui_print " 10- Apply Asphalt 9 and Sky Children of the Light 60 FPS Settings"
ui_print " "
sleep 0.5
ui_print "[⚡️] Select which you want"
ui_print "otherwise Select 'NONE'"
ui_print "and Continue!"
ui_print " "
KU=1
while true
do
  ui_print "  ${KU}"
  if "${VKSEL}"; then
      KU=$((KU + 1))
  else 
      break
  fi
if [[ "${KU}" -gt "10" ]]; then
    KU=1
fi
done

case "${KU}" in
1 ) FCTEXTAD2="None";;
2 ) FCTEXTAD2="CODM 120 FPS"; sed -i '/ro.product.model/s/.*/ro.product.model=XQ-AS72/' "${MODPATH}/system.prop"; sed -i '/ro.product.model/s/.*/ro.product.model=XQ-AS72/' "${MODPATH}/system1.prop";;
3 ) FCTEXTAD2="PUBGM 90 FPS"; sed -i '/ro.product.model/s/.*/ro.product.model=IN2023/' "${MODPATH}/system.prop"; sed -i '/ro.product.model/s/.*/ro.product.model=IN2023/' "${MODPATH}/system1.prop";;
4 ) FCTEXTAD2="ML Max Settings"; sed -i '/ro.product.model/s/.*/ro.product.model=umi/' "${MODPATH}/system.prop"; sed -i '/ro.product.model/s/.*/ro.product.model=umi/' "${MODPATH}/system1.prop";;
5 ) FCTEXTAD2="Asphalt 9 and Sky Children of the Light 60 FPS"; sed -i '/ro.product.model/s/.*/ro.product.model=GM1917/' "${MODPATH}/system.prop"; sed -i '/ro.product.model/s/.*/ro.product.model=GM1917/' "${MODPATH}/system1.prop";;
6 ) FCTEXTAD2="Game For Peace 90 FPS"; sed -i '/ro.product.model/s/.*/ro.product.model=SM-G9880/' "${MODPATH}/system.prop"; sed -i '/ro.product.model/s/.*/ro.product.model=SM-G9880/' "${MODPATH}/system1.prop";;
7 ) FCTEXTAD2="LifeAfter 120 FPS"; sed -i 's/"frame": 1,/"frame": 4,/g' "${LIFE}"; sed -i 's/"frame": 2,/"frame": 4,/g' "${LIFE}"; sed -i 's/"frame": 3,/"frame": 4,/g' "${LIFE}";;
8 ) FCTEXTAD2="Apex Legends 120 FPS"; sed -i 's/SpecialFPS=30/SpecialFPS=120/g' "${APEX}"; sed -i 's/BRFPS=40/BRFPS=120/g' "${APEX}"; sed -i 's/SpecialFPS=60/SpecialFPS=120/g' "${APEX}"; sed -i 's/BRFPS=30/BRFPS=120/g' "${APEX}";;
9 ) FCTEXTAD2="Super Clone 120 FPS"; sed -i 's/{"isFPSOn":true,"isEffectSoundOn":true,"isMusicSoundOn":true,"targetFPS":30,"isFixTouchJoystickPosition":true,"isFixTouchJoystickCompletely":true}/{"isFPSOn":true,"isEffectSoundOn":true,"isMusicSoundOn":true,"targetFPS":120,"isFixTouchJoystickPosition":true,"isFixTouchJoystickCompletely":true}/g' "${SC}"; sed -i 's/{"isFPSOn":true,"isEffectSoundOn":true,"isMusicSoundOn":true,"targetFPS":45,"isFixTouchJoystickPosition":true,"isFixTouchJoystickCompletely":true}/{"isFPSOn":true,"isEffectSoundOn":true,"isMusicSoundOn":true,"targetFPS":120,"isFixTouchJoystickPosition":true,"isFixTouchJoystickCompletely":true}/g' "${SC}"; sed -i 's/{"isFPSOn":true,"isEffectSoundOn":true,"isMusicSoundOn":true,"targetFPS":60,"isFixTouchJoystickPosition":true,"isFixTouchJoystickCompletely":true}/{"isFPSOn":true,"isEffectSoundOn":true,"isMusicSoundOn":true,"targetFPS":120,"isFixTouchJoystickPosition":true,"isFixTouchJoystickCompletely":true}/g' "${SC}";;
10 ) FCTEXTAD2="Asphalt 9 and Sky Children of the Light 60 FPS"; sed -i '/ro.product.model/s/.*/ro.product.model=GM1917/' "${MODPATH}/system.prop"; sed -i '/ro.product.model/s/.*/ro.product.model=GM1917/' "${MODPATH}/system1.prop";;
esac
break
ui_print " "
ui_print "Selected: ${FCTEXTAD2} "
ui_print " "
sleep 1
ui_print " - [⚡️] Created by CRANKV2 @ (Telegram)"
sleep 2
ui_print " "
ui_print " - Contributors, credits:"
sleep 1
ui_print " "
ui_print " - pedro3z0, frap129, KiraaDeath ❤️ "
ui_print "Haxis_Lancelot, imUsiF12, Veez21 ❤️"
ui_print "Zackptg5 ❤️"
sleep 1
ui_print " "
ui_print " And especially my Lovely Testers.. "
ui_print "@Nathan, @MRDOCA ❤"
ui_print "@xxcarlos84xx, @LeeXDA18 ❤"
ui_print "@UshieKane ❤"
sleep 1
ui_print " "
ui_print " - [⚡️] Join my support group:" 
ui_print "AndroidRootModulesCommunity"
ui_print "(@Telegram)"
sleep 1
ui_print " "
ui_print " ❤️ Thanks to everyone ❤️" 
ui_print "❤️ for testing and helping me. ❤️"
sleep 1
ui_print " "
ui_print "[⚡️] Downloading the latest"
ui_print "script(s) / application from Github..."
ui_print " "

wget -O "${MODPATH}/system/bin/crv2twtweaks" "https://raw.githubusercontent.com/CRANKV2/CRV2Tweaks/main/system/bin/crv2twtweaks"

wget -O "${MODPATH}/system/bin/crv2menu" "https://raw.githubusercontent.com/CRANKV2/CRV2Tweaks/main/system/bin/crv2menu"

wget -O "${MODPATH}/system/bin/cleaner" "https://raw.githubusercontent.com/CRANKV2/CRV2Tweaks/main/system/bin/cleaner"

wget -O "${MODPATH}/mod-util.sh" "https://raw.githubusercontent.com/CRANKV2/CRV2Tweaks/main/mod-util.sh"

wget -O "/data/local/tmp/CV2Tweaks.apk" "https://github.com/CRANKV2/CRV2Tweaks/blob/main/CV2Tweaks.apk?raw=true"

wget -O "/data/local/tmp/CV2Toast.apk" "https://github.com/CRANKV2/CRV2Tweaks/blob/main/CV2Toast.apk?raw=true"

ui_print "[⚡️] Good All necessary files have been successfully Placed."
ui_print " "
ui_print "[⚡️] Installing main application..."
pm install /data/local/tmp/CV2Tweaks.apk
ui_print " "
ui_print "[⚡️] Installing toasts app..."
pm install /data/local/tmp/CV2Toast.apk
ui_print " "
ui_print " [⚡️] The logs are hidden."
ui_print "  [⚡️] if you need the logs" 
ui_print "retrieve it by using Termux" 
ui_print "type (su -c crv2menu."
sleep 1
ui_print " "
ui_print "[⚡️] CV2 Tweaks Module [⚡️]"
ui_print "has been installed successfuly!"
ui_print "Restart phone and ENJOY!"
ui_print " "
sleep 2
