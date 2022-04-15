MODUTILVER=v2.6.1
MODUTILVCODE=261
if [[ -d /system_root ]]; then
  isABDevice=true
  SYSTEM=/system_root/system
  SYSTEM2=/system
  CACHELOC=/data/cache
else
  isABDevice=false
  SYSTEM=/system
  SYSTEM2=/system
  CACHELOC=/cache
fi
[[ -z "$isABDevice" ]] && { echo "- Something went wrong"; exit 1; }
set_busybox() {
  if [[ -x "$1" ]]; then
    for i in $(${1} --list); do
      if [[ "$i" != 'echo' ]]; then
        alias "$i"="${1} $i" >/dev/null 2>&1
      fi
    done
    _busybox=true
    _bb=$1
  fi
}
_busybox=false
if [[ -n "$_bb" ]]; then
  true
elif [[ -x "$SYSTEM2"/xbin/busybox ]]; then
  _bb=$SYSTEM2/xbin/busybox
elif [[ -x "$SYSTEM2"/bin/busybox ]]; then
  _bb="$SYSTEM2"/bin/busybox
else
  echo "- Busybox not detected!!"
  echo "Please install it (@osm0sis busybox recommended)"
  false
fi
set_busybox $_bb
[[ $? -ne 0 ]] && { echo "[!] Something went wrong"; exit $?; }
[[ -n "$ANDROID_SOCKET_adbd" ]] && alias clear='echo'
_bbname="$($_bb | head -n 1 | awk '{print $1,$2}')"
BBok=true
if [[ "$_bbname" = "" ]]; then
  _bbname="[!] Busybox not found"
  BBok=false
fi
set_perm() {
  chown "$2":"$3" "$1" || return 1
  chmod "$4" "$1" || return 1
  (if [[ -z "$5" ]]; then
    case $1 in
      *"system/vendor/app/"*) chcon 'u:object_r:vendor_app_file:s0' "$1";;
      *"system/vendor/etc/"*) chcon 'u:object_r:vendor_configs_file:s0' "$1";;
      *"system/vendor/overlay/"*) chcon 'u:object_r:vendor_overlay_file:s0' "$1";;
      *"system/vendor/"*) chcon 'u:object_r:vendor_file:s0' "$1";;
      *) chcon 'u:object_r:system_file:s0' "$1";;
    esac
  else
    chcon "$5" "$1"
  fi) || return 1
}
set_perm_recursive() {
  find "$1" -type d 2>/dev/null | while read dir; do
    set_perm "$dir" "$2" "$3" "$4" "$6"
  done
  find "$1" -type f -o -type l 2>/dev/null | while read file; do
    set_perm "$file" "$2" "$3" "$5" "$6"
  done
}
mktouch() {
  mkdir -p "${1%/*}" 2>/dev/null
  [[ -z $2 ]] && touch "$1" || echo "$2" > "$1"
  chmod 644 "$1"
}
grep_prop() {
  local REGEX="s/^$1=//p"
  shift
  local FILES=$@
  [[ -z "$FILES" ]] && FILES='/system/build.prop'
  sed -n "$REGEX" $FILES 2>/dev/null | head -n 1
}
is_mounted() {
  grep -q " $(readlink -f "$1") " /proc/mounts 2>/dev/null
  return $?
}
abort() {
  echo "$1"
  exit 1
}
BRAND=$(getprop ro.product.brand)
MODEL=$(getprop ro.product.model)
DEVICE=$(getprop ro.product.device)
ROM=$(getprop ro.build.display.id)
API=$(grep_prop ro.build.version.sdk)
ABI=$(grep_prop ro.product.cpu.abi | cut -c-3)
ABI2=$(grep_prop ro.product.cpu.abi2 | cut -c-3)
ABILONG=$(grep_prop ro.product.cpu.abi)
ARCH=arm
ARCH32=arm
IS64BIT=false
if [[ "$ABI" = "x86" ]]; then ARCH=x86; ARCH32=x86; fi;
if [[ "$ABI2" = "x86" ]]; then ARCH=x86; ARCH32=x86; fi;
if [[ "$ABILONG" = "arm64-v8a" ]]; then ARCH=arm64; ARCH32=arm; IS64BIT=true; fi;
if [[ "$ABILONG" = "x86_64" ]]; then ARCH=x64; ARCH32=x86; IS64BIT=true; fi;
VER=$(grep_prop version "$MODDIR"/module.prop)
REL=$(grep_prop versionCode "$MODDIR"/module.prop)
AUTHOR=$(grep_prop author "$MODDIR"/module.prop)
MODTITLE=$(grep_prop name "$MODDIR"/module.prop)
G='\e[01;32m'		# GREEN TEXT
R='\e[01;31m'		# RED TEXT
Y='\e[01;33m'		# YELLOW TEXT
B='\e[01;34m'		# BLUE TEXT
V='\e[01;35m'		# VIOLET TEXT
Bl='\e[01;30m'		# BLACK TEXT
C='\e[01;36m'		# CYAN TEXT
W='\e[01;37m'		# WHITE TEXT
BGBL='\e[1;30;47m'	# Background W Text Bl
N='\e[0m'			# How to use (example): echo "${G}example${N}"
loadBar=' '			# Load UI
[[ -n "$1" ]] && [[ "$1" = "-nc" ]] && shift && NC=true
[[ "$NC" ]] || [[ -n "$ANDROID_SOCKET_adbd" ]] && {
  G=''; R=''; Y=''; B=''; V=''; Bl=''; C=''; W=''; N=''; BGBL=''; loadBar='=';
}
character_no=$(echo "$MODTITLE $VER $REL" | wc -c)
div="${Bl}$(printf '%*s' "${character_no}" '' | tr " " "=")${N}"
title_div() {
  [[ "$1" = "-c" ]] && local character_no=$2 && shift 2
  [[ -z "$1" ]] && { local message=; no=0; } || { local message="$@ "; local no=$(echo "$@" | wc -c); }
  [[ $character_no -gt $no ]] && local extdiv=$((character_no-no)) || { echo "Invalid!"; return 1; }
  echo "${W}$message${N}${Bl}$(printf '%*s' "$extdiv" '' | tr " " "=")${N}"
}
set_file_prop() {
  if [[ -f "$3" ]]; then
    if grep -q "$1=" "$3"; then
      sed -i "s/${1}=.*/${1}=${2}/g" "$3"
    else
      echo "$1=$2" >> "$3"
    fi
  else
    echo "- $3 doesn't exist"; return 1
  fi
}
ProgressBar() {
  if [[ "$COLUMNS" -le "57" ]]; then
    local var1=2
	local var2=20
  else
    local var1=4
    local var2=40
  fi
  local _progress=$(((${1}*100/${2}*100)/100))
  local _done=$(((${_progress}*${var1})/10))
  local _left=$((${var2}-$_done))
  local _done=$(printf "%${_done}s")
  local _left=$(printf "%${_left}s")
printf "\rProgress : ${BGBL}|${N}${_done// /${BGBL}$loadBar${N}}${_left// / }${BGBL}|${N} ${_progress}%%"
}
Spinner() {
case ${_indicator} in
  "|") _indicator="/";;
  "/") _indicator="-";;
  "-") _indicator="\\";;
  "\\") _indicator="|";;
  # Initiate spinner character
  *) _indicator="\\";;
esac
printf "\r${@} [${_indicator}]"
}
e_spinner() {
  PID=$!
  h=0; anim='-\|/';
  while [[ -d /proc/$PID ]]; do
    h=$(((h+1)%4))
    sleep 0.02
    printf "\r${@} [${anim:$h:1}]"
  done
}
test_connection() {
  (
  if ping -q -c 1 -W 1 google.com >/dev/null 2>&1; then
    true
  elif ping -q -c 1 -W 1 baidu.com >/dev/null 2>&1; then
    true
  else
    false
  fi & e_spinner "Testing internet connection"
  ) && echo " - OK" || { echo " - Error"; false; }
}
upload_logs() {
  $BBok && {
    test_connection || exit
    echo "Uploading logs"
    [[ -s $VERLOG ]] && verUp=$(cat "$VERLOG" | nc termbin.com 9999) || verUp=none
    [[ -s $oldVERLOG ]] && oldverUp=$(cat "$oldVERLOG" | nc termbin.com 9999) || oldverUp=none
    [[ -s $LOG ]] && logUp=$(cat "$LOG" | nc termbin.com 9999) || logUp=none
    [[ -s $oldLOG ]] && oldlogUp=$(cat "$oldLOG" | nc termbin.com 9999) || oldlogUp=none
    [[ -s $stdoutLOG ]] && stdoutUp=$(cat "$stdoutLOG" | nc termbin.com 9999) || stdoutUp=none
    [[ -s $oldstdoutLOG ]] && oldstdoutUp=$(cat "$oldstdoutLOG" | nc termbin.com 9999) || oldstdoutUp=none
    echo -n "Link: "
    echo "$MODEL ($DEVICE) API $API\n$ROM\n$ID\n
    O_Verbose: $oldverUp
    Verbose:   $verUp
    O_STDOUT:  $oldstdoutUp
    STDOUT:    $stdoutUp
    O_Log: $oldlogUp
    Log:   $logUp" | nc termbin.com 9999
  } || echo "- Busybox not found"
  exit 1
}
prandom() {
  local CHANCES=2
  local TARGET=2
  [[ "$1" =  "-c" ]] && { local CHANCES=$2; local TARGET=$3; shift 3; }
  [[ "$((RANDOM%CHANCES+1))" -eq "$TARGET" ]] && echo "$@"
}
pcenter() {
  local CHAR=$(printf "$@" | sed 's|\\e[[0-9;]*m||g' | wc -m)
  local hfCOLUMN=$((COLUMNS/2))
  local hfCHAR=$((CHAR/2))
  local indent=$((hfCOLUMN-hfCHAR))
  echo "$(printf '%*s' "${indent}" '') $@"
}
