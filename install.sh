#!/bin/sh

if [ ! "$ANSI_SUPPORT" == "true" ] || [ ! -n "$MMM_EXT_SUPPORT" ]; then
  abort "! Please Use Fox Magisk Module Manager (FOXMMM) To Flash This Module!"
  ui_print ""
  ui_print "https://github.com/Fox2Code/FoxMagiskModuleManager/releases"
  ui_print ""
  exit 1
fi

ui_print "#!useExt"
mmm_exec() {
  ui_print "$(echo -e "#!$@")"
}

ESC=""
# ESC="\e"
BL="$ESC[90m" #BLACK
R="$ESC[91m" #Red
O="$ESC[33m" #Orange
Y="$ESC[93m" #Yellow
G="$ESC[92m" #Green
C="$ESC[96m" #Cyan
B="$ESC[94m" #Blue
P="$ESC[95m" #Purple
N="$ESC[0m" #Reset

ui_replace() {
  mmm_exec setLastLine "$1"
}

#by CV2 (CRANKV2 @ GitHub)
SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true
CLEANSERVICE=false
DEBUG=false
MODDIR="/data/adb/modules"

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
"
print_modname() {
service=/data/adb/modules_update/STRP/service.sh
ui_print " "
sleep 1.5
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
sleep 2
ui_print "
${BL}░${N}${R}██████${N}${G}╗${N}${R}████████${N}${G}╗${R}${R}██████${N}${G}╗${R}${BL}░${N}${R}██████${N}${G}╗${N}${BL}░${R}
${R}██${N}${G}╔════╝${N}${G}╚══${N}${R}██${N}${G}╔══╝${N}${R}██${N}${G}╔══${N}${R}██${N}${G}╗${N}${R}██${N}${G}╔══${N}${R}██${N}${G}╗${R}
${G}╚${N}${R}█████${N}${G}╗${R}${BL}░${N}${BL}░░░${N}${R}██${N}${G}║${N}${BL}░░░${N}${R}██████${N}${G}╔╝${N}${R}██████${N}${G}╔╝${N}
${BL}░${N}${G}╚═══${N}${R}██${N}${G}╗${R}${BL}░░░${N}${R}██${N}${G}║${N}${BL}░░░${N}${R}██${N}${G}╔══${N}${R}██${N}${G}╗${N}${R}██${N}${G}╔═══╝${N}${BL}░${N}
${R}██████${N}${G}╔╝${N}${BL}░░░${N}${R}██${N}${G}║${N}${BL}░░░${N}${R}██${N}${G}║${N}${BL}░░${N}${R}██${N}${G}║${N}${R}██${N}${G}║${N}${BL}░░░░░${N}
${G}╚═════╝${N}${BL}░${N}${BL}░░░${N}${G}╚═╝${N}${BL}░░░${N}${G}╚═╝${N}${BL}░░${N}${G}╚═╝${N}${G}╚═╝${N}${BL}░░░░░${N}
"
sleep 2
ui_print ""
ui_print "${Y}Created By @CRANKV2${N} ${C}[Telegram]${N}"
sleep 4
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
sleep 2.5
ui_print " "
ui_print "${G}╔${N}${Y}VERSION${N}${G} ▰${N}${R} 2${N}${G}.${Y}4 HOTFIX${N}"
sleep 1
ui_print "${G}║"
ui_print "${G}╠▌${N}${Y}CODENAME${N}${G} ▰${N}${R} ${R}S${N}${O}T${Y}R${N}${G}A${N}${C}T${N}${B}O${N}${P}S${N}${G}P${N}${Y}H${N}${C}E${N}${B}R${N}${R}E${N}"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Device Is${N}${G} ▰${N}${R} $(getprop ro.build.product)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Mobile Phone Is${N}${G} ▰${N}${R} $(getprop ro.product.model)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Manufacturer Is${N}${G} ▰${N}${R} $(getprop ro.product.system.manufacturer)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Processor Is${N}${G} ▰${N}${R} $(getprop ro.product.board)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your CPU Is${N}${G} ▰${N}${R} $(getprop ro.hardware)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your CPU Arch Is${N}${G} ▰${N}${R} $(getprop ro.bionic.arch)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Android Version Is${N}${G} ▰${N}${R} $(getprop ro.build.version.release)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Brand Is${N}${G} ▰${N}${R} $(getprop ro.product.system.brand)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Kernel Is${N}${G} ▰${N}${R} $(uname -r)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Hardware Is${N}${G} ▰${N}${R} $(getprop ro.boot.hardware)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your SDK Is${N}${G} ▰${N}${R} $API"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your OpenGL ES Version Is${N}${G} ▰${N}${R} $(getprop ro.opengles.version)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your ROM Is${N}${G} ▰${N}${R} $(getprop ro.build.display.id)"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your RAM Free Is${N}${G} ▰${N}${R} $(free | grep Mem |  awk '{print $2}')"
sleep 0.5
ui_print "${G}╠▌${N}${Y}Your Disk Encryption Is${N}${G} ▰${N}${R} $(getprop ro.crypto.state)"
sleep 0.5
ui_print "${G}╚▌${N}${Y}Your SELinux Status is${N}${G} ▰${N}${R} $(su -c getenforce)"
ui_print ""
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
sleep 3.5
ui_print " "
ui_print "${G}╔▌${N}${Y}Checking which ARM ur device has..."
sleep 2
ui_print "${G}║${N}"
ui_print "${G}╠▌${N}${Y}Your ARM Is${N}${G} :${N}${R} $(getprop ro.product.cpu.abi)"
sleep 1
ui_print "${G}║${N}"
ui_print "${G}╠▌${N}${Y}Extracting and Moving files for${N}${R} $(getprop ro.product.cpu.abi)${N}"
[[ "$IS64BIT" == "true" ]] && tar -xf "$MODPATH/strp64.tar.xz" -C "$MODPATH" || tar -xf "$MODPATH/strp32.tar.xz" -C "$MODPATH"
sleep 2.5
ui_print "${G}║${N}"
ui_print "${G}╚══${N}${R}⇒${N}${G}Done .. ${N}${R}All Scripts Placed Successfully!${N}"
ui_print ""
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
sleep 2.5
ui_print " "
ui_print "${G}▌${N}${R}Checking For Possible Conflicts...${N}"
ui_print ""
ui_print "${G}▌${N}${R}And Removing Them If They Exist!${N}"
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
    sleep 4
    ui_print ""
ui_print "${G}▌${N}${R}DONE!${N}"
ui_print " "
sleep 3
ui_print ""
ui_print "${G}▌${N}${R}Searching for any type of Hacking apps & Tools !${N}"
ui_print ""
ui_print "${G}▌${N}${R}And Removing Them If They Exist!${N}"

if [ "$(pm list package com.free.source)" ]; then
ui_print "${R}▰ 4GG CHEATS App Has Been Detected, I will Remove it now you Noob.${N}"
pm uninstall -k --user 0 com.free.source

elif [ "$(pm list package com.id.esp)" ]; then
ui_print "${R}▰ ESP App Has Been Detected, I will Remove it now you Noob.${N}"
pm uninstall -k --user 0 com.id.esp

elif [ "$(pm list package com.fanspro.sounix)" ]; then
ui_print "${R}▰ VIP Super Vegita App Has Been Detected, I will Remove it now you Noob.${N}"
pm uninstall -k --user 0 com.fanspro.sounix

elif [ "$(pm list package com.fanspro.venom)" ]; then
ui_print "${R}▰ VIP Venom App Has Been Detected, I will Remove it now you Noob.${N}"
pm uninstall -k --user 0 com.fanspro.venom

elif [ "$(pm list package com.xdz.dev)" ]; then
ui_print "${R}▰ XDZ ESP App Has Been Detected, I will Remove it now you Noob.${N}"
pm uninstall -k --user 0 com.xdz.dev

elif [ "$(pm list package com.anonymous)" ]; then
ui_print "${R}▰ PUBG ESP-Hack App Has Been Detected, I will Remove it now you Noob.${N}"
pm uninstall -k --user 0 com.anonymous

elif [ "$(pm list package apk.esp.noroot)" ]; then
ui_print "${R}▰ No Root ESP App Has Been Detected, I will Remove it now you Noob.${N}"
pm uninstall -k --user 0 apk.esp.noroot
fi
sleep 4
    ui_print ""
ui_print "${G}▌${N}${R}DONE!${N}"
ui_print " "
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
ui_print " "
sleep 2.5
ui_print "${G}▌${N}${Y}Adding Important Games To Magisk Denylist...${N}"
magiskhide add com.tencent.ig >/dev/null 2>&1
magiskhide add com.epicgames.fortnite >/dev/null 2>&1
magiskhide add com.vng.pubgmobile >/dev/null 2>&1
magiskhide add com.pubg.krmobile >/dev/null 2>&1
magiskhide add com.activision.callofduty.shooter >/dev/null 2>&1
magiskhide add com.garena.game.codm >/dev/null 2>&1
magiskhide add com.pubg.newstate >/dev/null 2>&1
magiskhide add com.plato.android >/dev/null 2>&1
magiskhide add com.dts.freefireth >/dev/null 2>&1
magiskhide add com.dts.freefiremax >/dev/null 2>&1
magiskhide add com.kitkagames.fallbuddies >/dev/null 2>&1
magisk --denylist add com.pubg.newstate >/dev/null 2>&1
magisk --denylist add com.garena.game.codm >/dev/null 2>&1
magisk --denylist add com.activision.callofduty.shooter >/dev/null 2>&1
magisk --denylist add com.pubg.krmobile >/dev/null 2>&1
magisk --denylist add com.epicgames.fortnite >/dev/null 2>&1
magisk --denylist add com.tencent.ig >/dev/null 2>&1
magisk --denylist add com.plato.android >/dev/null 2>&1
magisk --denylist add com.dts.freefireth >/dev/null 2>&1
magisk --denylist add com.dts.freefiremax >/dev/null 2>&1
magisk --denylist add com.kitkagames.fallbuddies >/dev/null 2>&1
sleep 3
ui_print "${G}▌${N}${Y}Added All Necessary Games!${N}"
ui_print ""
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
sleep 2.5
ui_print "${G}▌${N}${Y}Clean some space before placing main files...${N}"
ui_print ""
echo 3 > /proc/sys/vm/drop_caches
sleep 2.5
echo 0 > /proc/sys/vm/drop_caches
ui_print "${G}▌DONE!"
ui_print ""
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
ui_print ""
ui_print "${G}▌${N}${Y}Optimizing some important system settings...${N}"

cmd dropbox set-rate-limit 10000 2>/dev/null
pm disable com.miui.systemAdSolution >/dev/null 2>&1
pm disable com.miui.analytics >/dev/null 2>&1

sleep 3
ui_print ""
ui_print "${G}▌${N}${R}DONE!${N}"
sleep 2
ui_print ""
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
ui_print ""
ui_print "${G}▌${N}${B}Created By @CRANKV2${N} ${C}(Telegram)${N}"
sleep 2
ui_print " "
ui_print "${G}┏${N}${Y}Some Credits:${N}"
ui_print "${G}┃${N}"
sleep 1
ui_print "${G}┣${N}${Y}Too My TEAM...${N} "
ui_print "${G}┃${N}"
sleep 1
ui_print "${G}┣${N}${R}@hezenscs, @Legend_Gaming078, @Sajadragon❤${N}"
ui_print "${G}┃${N}"
sleep 1
ui_print "${G}┣${N}${G}@AdeRRo, @neginivesh, @Ayanokouj50iKiyotaka❤${N}"
ui_print "${G}┃${N}"
sleep 1
ui_print "${G}┣${N}${C}@PJ_ARMC, @SmellsGood20, @NotDarkz, @PhatWalrus❤${N}"
sleep 1
ui_print "${G}┃${N}"
ui_print "${G}┗${N}${B}@FastBoiOp, @exploit218, @RedmagicBoi, @BeastOg❤${N}"
sleep 2
ui_print " "
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
ui_print " "
ui_print "${G}╔${N}${Y}Join The Support Group:${N}" 
ui_print "${G}║${N}"
ui_print "${G}╟${N}${R}AndroidRootModulesCommunity${N}${G} ▰${N}${B} GROUP${N}"
ui_print "${G}║${N}"
ui_print "${G}╟${N}${R}StratospherePerformance${N}${G} ▰${N}${B} CHANNEL${N}"
ui_print "${G}║${N}"
ui_print "${G}╚${N}${C}(@Telegram)${N}"
sleep 4
ui_print " "
ui_print "❤️ ${C}Thanks To ${N}${G}EVERY${N}${C} Supporter!${N}❤️" 
ui_print ""
ui_print "❤${C}️And ! ${N}${G}YOU${N}${C} ! For Flashing And Using It${N}❤️"
sleep 1
ui_print " "
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
sleep 2
ui_print ""
ui_print "${G}▌${N}${R}Installing ${Y}STRATOSPHERE TOAST${N}${R} App...${N}"
pm install $MODPATH/StratosphereToast.apk
ui_print ""
sleep 2
ui_print "${G}▌${N}${R}DONE!${N}"
ui_print " "
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
sleep 1.5
ui_print ""
ui_print "${G}▌${N}${Y}Set Up Pre - Permissions...${N}"
	ui_print ""
set_perm_recursive $MODPATH 0 0 0755 0644
    set_perm $MODPATH/service.sh 0 0 0777
    set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.conf 0 0 0755 0644
    set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.stock.conf 0 0 0755 0644
        set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.v3.conf 0 0 0755 0644
            set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.v4.conf 0 0 0755 0644
                set_perm_recursive $MODPATH/system/vendor/etc/thermal-engine.v5.conf 0 0 0755 0644
                    set_perm_recursive $MODPATH/system/vendor/etc/thermal-status.txt 0 0 0755 0644
sleep 3
ui_print "${G}▌${N}${R}DONE!${N}"
ui_print ""
sleep 1
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
ui_print ""
sleep 1.5
ui_print "${G}▌${N}${G}Module Installed Successfully!${N}"
sleep 1
ui_print "${G}▌${N}${Y}Installation Date>>>${N}${R} $(date +"%d-%m-%Y %r" )${N}"
sleep 1
ui_print "${G}▌${N}${Y}Installed Into${N}${R} /data/adb/modules/STRP${N}"
ui_print " "
sleep 0.5
ui_print "${G}▌${N}${Y}Added >${N}${R} CPU BOOST${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} GPU BOOST${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} FPS BOOST${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} Touchscreen Improvements${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} Cache Cleaner${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} Cleaner Menu${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} STRP MENU${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} STRP TWEAKS${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} Power BOOST${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} Doze MODE${N}"
sleep 0.5
ui_print " "
ui_print "${G}▌${N}${Y}Added >${N}${R} Thermal Functions${N}"
sleep 0.5
ui_print ""
ui_print ""
ui_print "${G}▌${N}${R}And Many More Exclusive${N} ${C}S${N}${Y}T${N}${G}R${N}${B}P${N}${R} Stuff!${N}"
ui_print " "
ui_print "${B}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
ui_print ""
sleep 1.5
ui_print "${G}▌${N}${R}Restart Phone...${N}"
sleep 1
ui_print ""
ui_print "${G}▌${N}${R}Open${N}${Y} TERMUX${N}${R} Application"
sleep 1
ui_print ""
ui_print "${G}▌${N}${R}And Use${N}${Y} 'su -c strpmenu' ${N}${R}To Open Up Menu!${N}"
sleep 1
ui_print "${G}▌${N}${C}Stay Fast!${N} ⚡️"
ui_print " "
sleep 4
ui_print " "
ui_print " "
ui_print " "
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