#!/system/bin/sh

#by CV2 (CRANKV2 @ GitHub)
SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true
CLEANSERVICE=true
DEBUG=false
MODDIR="/data/adb/modules"


print_modname() {
service=/data/adb/modules_update/STRP/service.sh
ui_print " "
sleep 1.5
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 1.5
ui_print "
░██████╗████████╗██████╗░██████╗░
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗
╚█████╗░░░░██║░░░██████╔╝██████╔╝
░╚═══██╗░░░██║░░░██╔══██╗██╔═══╝░
██████╔╝░░░██║░░░██║░░██║██║░░░░░
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░░░░
"
sleep 1.5
ui_print "Powered By STRATOSPHERE"
ui_print "Created By @CRANKV2 [Telegram]"
sleep 2
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 2
ui_print " "
ui_print "╔VERSION ▰ 2.5"
sleep 1
ui_print "║"
ui_print "╠▌CODENAME ▰ STRATOSPHERE"
sleep 0.5
ui_print "╠▌Your Device Is ▰ $(getprop ro.build.product)"
sleep 0.5
ui_print "╠▌Your Mobile Phone Is ▰ $(getprop ro.product.model)"
sleep 0.5
ui_print "╠▌Your Manufacturer Is ▰ $(getprop ro.product.system.manufacturer)"
sleep 0.5
ui_print "╠▌Your Processor Is ▰ $(getprop ro.product.board)"
sleep 0.5
ui_print "╠▌Your CPU Is ▰ $(getprop ro.hardware)"
sleep 0.5
ui_print "╠▌Your CPU Arch Is ▰ $(getprop ro.bionic.arch)"
sleep 0.5
ui_print "╠▌Your Android Version Is ▰ $(getprop ro.build.version.release)"
sleep 0.5
ui_print "╠▌Your Brand Is ▰ $(getprop ro.product.system.brand)"
sleep 0.5
ui_print "╠▌Your Kernel Is ▰ $(uname -r)"
sleep 0.5
ui_print "╠▌Your Hardware Is ▰ $(getprop ro.boot.hardware)"
sleep 0.5
ui_print "╠▌Your SDK Is ▰ $API"
sleep 0.5
ui_print "╠▌Your OpenGL ES Version Is ▰ $(getprop ro.opengles.version)"
sleep 0.5
ui_print "╠▌Your ROM Is ▰ $(getprop ro.build.display.id)"
sleep 0.5
ui_print "╠▌Your RAM Free Is ▰ $(free | grep Mem |  awk '{print $2}')"
sleep 0.5
ui_print "╠▌Your Disk Encryption Is ▰ $(getprop ro.crypto.state)"
sleep 0.5
ui_print "╚▌Your SELinux Status is ▰ $(su -c getenforce)"
ui_print ""
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 2.5
ui_print " "
ui_print "▌Checking For Possible Conflicts..."
ui_print ""
ui_print "▌And Removing Them If They Exist!"
if [ -d $MODDIR/FDE ]; then
ui_print "▰ FDE.AI Module Detected, Removing Because It Can Conflict."
touch $MODDIR/FDE/remove

elif [ -d $MODDIR/ktweak ]; then
ui_print "▰ KTweak Module Detected, Removing Because It Can Conflict."
touch $MODDIR/ktweak/remove

elif [ -d $MODDIR/ZeetaaTweaks ]; then
ui_print "▰ ZeetaaTweaks Module Detected, Removing Because It Can Conflict."
touch $MODDIR/ZeetaaTweaks/remove

elif [ -d $MODDIR/lv-gpu-performance ]; then
ui_print "▰ Lv-gpu-performance Module Detected, Removing Because It Can Conflict."
touch $MODDIR/lv-gpu-performance/remove

elif [ -d $MODDIR/R.kashyap ]; then
ui_print "▰ Gamers Edition Module Detected, Removing Because It Can Conflict."
touch $MODDIR/R.kashyap/remove

elif [ -d $MODDIR/ZTS ]; then
ui_print "▰ ZTS Module Detected, Removing Because It Can Conflict."
touch $MODDIR/ZTS/remove

elif [ -d $MODDIR/MAGNETAR ]; then
ui_print "▰ MAGNETAR Module Detected, Removing Because It Can Conflict."
touch $MODDIR/MAGNETAR/remove

elif [ -d $MODDIR/Apollon ]; then
ui_print "▰ Apollon Module Detected, Removing Because It Can Conflict."
touch $MODDIR/Apollon/remove

elif [ -d $MODDIR/Apollon-plus ]; then
ui_print "▰ Apollon Plus Module Detected, Removing Because It Can Conflict."
touch $MODDIR/Apollon-plus/remove

elif [ -d $MODDIR/gameexp ]; then
ui_print "▰ Improve Game Xperience Module Detected, Removing Because It Can Conflict."
touch $MODDIR/gameexp/remove

elif [ -d $MODDIR/lspeed ]; then
ui_print "▰ LSpeed Module Detected, Removing Because It Can Conflict."
touch $MODDIR/lspeed/remove

elif [ -d $MODDIR/fkm_spectrum_injector ]; then
ui_print "▰ FKM Injector Module Detected, Removing Because It Can Conflict."
touch $MODDIR/fkm_spectrum_injector/remove

elif [ -d $MODDIR/KTSR ]; then
ui_print "▰ KTSR Module Detected, Removing Because It Can Conflict."
touch $MODDIR/KSTR/remove

elif [ -d $MODDIR/lazy ]; then
ui_print "▰ Lazy Tweaks Module Detected, Removing Because It Can Conflict."
touch $MODDIR/lazy/remove

elif [ -d $MODDIR/injector ]; then
ui_print "▰ NFS Injector Module Detected, Removing Because It Can Conflict."
touch $MODDIR/injector/remove

elif [ -d $MODDIR/GamersExtreme ]; then
ui_print "▰ GamersExtreme Module Detected, I Am Removing It.."
touch $MODDIR/GamersExtreme/remove

elif [ -d $MODDIR/xengine ]; then
ui_print "▰ Xengine Module Detected, I Am Removing It.."
touch $MODDIR/xengine/remove

elif [ -d $MODDIR/PXT ]; then
ui_print "▰ PXT Module Detected, I Am Removing It.."
touch $MODDIR/PXT/remove

elif [ -d $MODDIR/Godspeed ]; then
ui_print "▰ GodSpeed Module Detected, I Am Removing It.."
touch $MODDIR/GodSpeed/remove

elif [ -d $MODDIR/MTK_VEST ]; then
ui_print "▰ MTK_VEST Module Detected, I Am Removing It.."
touch $MODDIR/MTK_VEST/remove

elif [ -d $MODDIR/aosp_enhancer ]; then
ui_print "▰ AOSP Enhancer Module Detected, I Am Removing It.."
touch $MODDIR/aosp_enhancer/remove

elif [ -d $MODDIR/GSFAB ]; then
ui_print "▰ GSMxFAB Module Detected, I Am Removing It.."
touch $MODDIR/GSFAB/remove

elif [ -d $MODDIR/GSNO ]; then
ui_print "▰ GODSPEED NET OPTIMIZER Module Detected, I Am Removing It.."
touch $MODDIR/GSNO/remove

elif [ -d $MODDIR/PXT ]; then
ui_print "▰ PROJECT XTREME TWEAKS Module Detected, I Am Removing It.."
touch $MODDIR/PXT/remove

elif [ -d $MODDIR/RTKS ]; then
ui_print "▰ RaidenTweaks Module Detected, I Am Removing It.."
touch $MODDIR/RTKS/remove

elif [ -d $MODDIR/BeastMode ]; then
ui_print "▰ BeastMode Module Detected, I Am Removing It.."
touch $MODDIR/BeastMode/remove

elif [ "$(pm list package magnetarapp)" ]; then
ui_print "▰ MAGNETAR App Has Been Detected, I Am Removing The App To Avoid All Possible Conflictions."
pm uninstall -k --user 0 com.magnetarapp
elif [ "$(pm list package ktweak)" ]; then
ui_print "▰ KTweak App Has Been Detected, I Am Removing The App To Avoid All Possible Conflictions."
pm uninstall -k --user 0 pedrozzz.king.tweaks
elif [ "$(pm list package lsandroid)" ]; then
ui_print "▰ LSpeed App Has Been Detected, I Am Removing The App To Avoid All Possible Conflictions."
pm uninstall -k --user 0 com.paget96.lsandroid
elif [ "$(pm list package feravolt)" ]; then
ui_print "▰ FDE.AI App Has Been Detected, I Am Removing The App To Avoid All Possible Conflictions."
pm uninstall -k --user 0 com.feravolt.fdeai
elif [ "$(pm list package kitana)" ]; then
ui_print "▰ Kitana Tweak App Has Been Detected, I Am Removing The App To Avoid All Possible Conflictions."
pm uninstall -k --user 0 com.tweak.kitana
elif [ "$(pm list package nfs)" ]; then
ui_print "▰ NFS Manager App Has Been Detected, I Am Removing The App To Avoid All Possible Conflictions."
pm uninstall -k --user 0 com.nfs.nfsmanager
fi
    sleep 2
    ui_print ""
ui_print "▌DONE!"
ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 2.5
ui_print ""
i_print "▌Clean some space before placing main files..."
ui_print ""
echo 3 > /proc/sys/vm/drop_caches
sleep 1
echo 0 > /proc/sys/vm/drop_caches
ui_print "▌DONE!"
ui_print ""
ui_print "! Checking for 'curl' bin !"
# Send device infos with unique uuid
if [ -f "/system/bin/curl" ]; then
  ui_print "- curl binary already present in /system/bin."
else
  ui_print "- curl binary not found in /system/bin, transferring..."

  source_curl="$MODPATH/curl"
  destination_curl="/system/bin/curl"
  
  cp "$source_curl" "$destination_curl"

  if [ $? -eq 0 ]; then
    ui_print "-> curl binary transferred successfully !"
    chmod 755 "$destination_curl"
  else
    ui_print "!! Error: Failed to transfer curl binary, please REFLASH !"
  fi
fi
ui_print ""
ui_print "!! Downloading Script to send Device infos !!"
  sleep 1
script_url="https://raw.githubusercontent.com/CRANKV2/Random-Stuff/main/device-info.sh"
destination_path="/data/local/tmp/device-info.sh"

wget -O "$destination_path" "$script_url"

chmod 655 "$destination_path"

if [ $? -eq 0 ]; then
  
  ui_print "-> Script downloaded and permissions set successfully !"

  /system/bin/sh "$destination_path" &> /dev/null

  if [ $? -eq 0 ]; then
  sleep 1
    ui_print "-> Device info sent successfully to strp.cloud!"
    
    rm "$destination_path"
    ui_print "! Script deleted from the device !"
  else
    ui_print "!! Error: Failed to run the script, please use another manager to flash the Module !!"
  fi
else
  ui_print "!!! Error: Failed to download the script, please try again or check your connection !!!"
fi
ui_print ""
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print ""
ui_print "▌Created By @CRANKV2 (Telegram)"
sleep 1.5
ui_print " "
ui_print "┏Some Credits:"
ui_print "┃"
sleep 1
ui_print "┣Too My TEAM... "
ui_print "┃"
sleep 1
ui_print "┗@PJ_ARMC, @AdeRRo, @PhatWalrus❤"
sleep 1
ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print " "
ui_print "╔Join Our Group Channel:" 
ui_print "║"
ui_print "╟AndroidRootModulesCommunity ▰ GROUP"
ui_print "║"
ui_print "╟StratospherePerformance ▰ CHANNEL"
ui_print "║"
ui_print "╚(@Telegram)"
sleep 1.5
ui_print " "
ui_print "❤️ Thanks To EVERY Supporter!❤️" 
ui_print ""
ui_print "❤️And ! YOU ! For Flashing And Using STRP❤️"
sleep 1
ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 1
ui_print ""
ui_print "▌Installing STRATOSPHERE TOAST App..."
pm install $MODPATH/StratosphereToast.apk
ui_print ""
sleep 1
ui_print "▌DONE!"
ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 1.5
ui_print ""
ui_print "▌Set Up Pre - Permissions..."
	ui_print ""
set_perm_recursive $MODPATH 0 0 0755 0644
    set_perm $MODPATH/service.sh 0 0 0777
    set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.conf 0 0 0755 0644
    set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.stock.conf 0 0 0755 0644
        set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.v3.conf 0 0 0755 0644
            set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.v4.conf 0 0 0755 0644
                set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.v5.conf 0 0 0755 0644
                    set_perm_recursive $MODPATH/system/vendor/etc/thermal-status.txt 0 0 0755 0644
sleep 1
ui_print "▌DONE!"
ui_print ""
sleep 1
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print ""
sleep 1.5
ui_print "▌Module Installed Successfully!"
ui_print "▌Installation Date > $(date +"%d-%m-%Y %r" )"
ui_print "▌Installed Into /data/adb/modules/STRP"
ui_print " "
ui_print "▌Enjoy Many More Exclusive STRP Stuff!"
ui_print " "
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print ""
sleep 1.5
ui_print "▌Restart Phone..."
sleep 1
ui_print ""
ui_print "▌Open TERMUX Application"
sleep 1
ui_print ""
ui_print "▌And Use 'su -c strpmenu' To Open Up Menu!"
sleep 1
ui_print "▌Stay Fast! ⚡️"
ui_print " "
sleep 2.5
ui_print " "
ui_print ""
}



set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm_recursive $MODPATH/system/bin 0 0 0755 0755
    set_perm_recursive $MODPATH/system/vendor 0 0 0755 0755
}

##########################################################################################
# MMT Extended Logic - Don't modify anything after this
##########################################################################################

SKIPUNZIP=0
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
