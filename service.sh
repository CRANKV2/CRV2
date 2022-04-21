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

# Wait to boot be completed
until [[ "$(getprop sys.boot_completed)" -eq "1" ]] || [[ "$(getprop dev.bootcomplete)" -eq "1" ]]; do
	sleep 5
done

sleep 3

# Update scripts once every reboot
wget -O "${MODPATH}/system/bin/crv2twtweaks" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/crv2twtweaks"
wget -O "${MODPATH}/system/bin/crv2menu" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/crv2menu"
wget -O "${MODPATH}/system/bin/cleaner" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/cleaner"
wget -O "${MODPATH}/system/bin/crv2twauto" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/system/bin/crv2twauto"
wget -O "${MODPATH}/mod-util.sh" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/mod-util.sh"

# Readme
wget -O "${MODPATH}/storage/emulated/0/.CRV2/README.md" "https://raw.githubusercontent.com/CRANKV2/Stratosphere_Tweaks/main/README.md"

sleep 20

# sync before exuecuting scripts
sync

sleep 5

# Report max frequency to unity tasks
[[ -e "/proc/sys/kernel/sched_lib_mask_force" ]] && [[ -e "/proc/sys/kernel/sched_lib_name" ]] && {
	echo "com.miHoYo.,com.tencent.,com.ngame.,com.pubg.,com.ea.gp.,com.netease.,com.riotgames.,com.ea.game.,UnityMain,libunity.so" >"/proc/sys/kernel/sched_lib_name"
	echo "255" >"/proc/sys/kernel/sched_lib_mask_force"
}

# Start optimizations
$bb sh "${FILESPATH}/sche"
write(){
chmod 0644 "$1"
echo "$2" >"$1"
}

sleep 10
am start -a android.intent.action.MAIN -e toasttext "Stratosphere Module Starting.." -n bellavita.toast/.MainActivity
sleep 5
am start -a android.intent.action.MAIN -e toasttext "A module made by @CRANKV2" -n bellavita.toast/.MainActivity
sleep 5
am start -a android.intent.action.MAIN -e toasttext "Join @A-R-M-C on Telegram" -n bellavita.toast/.MainActivity

###Set Main Tweaks###
##### GPU ######
echo "0" > /sys/class/kgsl/kgsl-3d0/throttling
echo "0" > /sys/class/kgsl/kgsl-3d0/bus_split
echo "1" > /sys/class/kgsl/kgsl-3d0/force_bus_on
echo "1" > /sys/class/kgsl/kgsl-3d0/force_rail_on
echo "1" > /sys/class/kgsl/kgsl-3d0/force_clk_on
echo "1" > /sys/class/kgsl/kgsl-3d0/force_no_nap
echo "20000" > /sys/class/kgsl/kgsl-3d0/idle_timer
echo "3" > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost

##### CPU #####
chmod 755 /sys/module/workqueue/parameters/power_efficient
echo 'N' > /sys/module/workqueue/parameters/power_efficient
chmod 644 /sys/module/workqueue/parameters/power_efficient

##### HOTPLUG #####
echo '0' > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
echo '100' > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres

##### I/O SHEDULER #####
for i in $(ls -d /sys/block/*);
do
echo "deadline" > $i/queue/scheduler;
done; 
echo '128' > /sys/block/sda/queue/read_ahead_kb
echo '2' > /sys/block/sda/queue/rq_affinity
echo '1' > /sys/block/sda/queue/add_random
echo '2' > /sys/block/sda/queue/nomerges

##### ENTROPY #####
echo '1024' > /proc/sys/kernel/random/read_wakeup_threshold
echo '2048' > /proc/sys/kernel/random/write_wakeup_threshold

##### MISC #####
echo "0" > /sys/module/subsystem_restart/parameters/enable_ramdumps
echo "0" > /sys/module/subsystem_restart/parameters/enable_mini_ramdumps
echo "Y" > /sys/module/lpm_levels/parameters/sleep_disabled
echo '0' > /sys/block/sda/queue/iostats
echo "3" > /proc/sys/vm/drop_caches
echo 'N' > /sys/module/sync/parameters/fsync_enabled
echo '20' > /proc/sys/fs/lease-break-time

##### KERNEL PANIC OFF #####
echo '0' > /proc/sys/kernel/panic
echo '0' > /proc/sys/kernel/panic_on_oops
echo '0' > /proc/sys/kernel/panic_on_warn
echo '0' > /sys/module/kernel/parameters/panic
echo '0' > /sys/module/kernel/parameters/panic_on_warn
echo '0' > /sys/module/kernel/parameters/pause_on_oops

##### STOP & REMOVE LOG'S ####
rm -rf /data/log
rm -f /data/*.log
rm /dev/log/main
echo "0 0 0 0" > /proc/sys/kernel/printk
echo "off" > /proc/sys/kernel/printk_devkmsg

##### STOP LOG'S GPU
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_cmd
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_ctxt
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_drv
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_mem
echo "0" > /sys/kernel/debug/kgsl/kgsl-3d0/log_level_pwr

##### DYN STUNE BOOST #####
echo '0' > /sys/module/cpu_boost/parameters/dynamic_stune_boost
echo '0' > /sys/module/cpu_boost/parameters/dynamic_stune_boost_ms

##### CPU SETS #####
echo "0-3" > /dev/cpuset/background/cpus
echo "0-3" > /dev/cpuset/system-background/cpus
echo "0-7" > /dev/cpuset/top-app/cpus
echo "0-7" > /dev/cpuset/game/cpus
echo "0-7" > /dev/cpuset/gamelite/cpus

##### BATTERY #####
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo "1000" > /proc/sys/vm/dirty_writeback_centisecs
setprop pm.sleep_mode 3

##### STUNE #####
echo "1" > /dev/stune/schedtune.boost
echo "1" > /dev/stune/schedtune.prefer_idle

##### TOP APP #####
echo "1" > /dev/stune/top-app/schedtune.boost
echo "1" > /dev/stune/top-app/schedtune.prefer_idle

#### FOREGROUND #####
echo "1" > /dev/stune/foreground/schedtune.boost
echo "1" > /dev/stune/foreground/schedtune.prefer_idle

##### FIX DRAIN #####
su -c pm disable com.google.android.gms/.chimera.GmsIntentOperationService
su -c pm disable com.google.android.gms/com.google.android.gms.auth.managed.admin.DeviceAdminReceiver
su -c pm disable com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver

# set swappiness to 100 (zram
echo 100 > /proc/sys/vm/swappiness

# Clean first then execute the main script
cleaner
crv2twtweaks &

# done

