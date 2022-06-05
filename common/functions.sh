#!/system/bin/sh

cleanup() {
	rm -rf "$MODPATH/common" 2>/dev/null
	rm -rf "$MODPATH/LICENSE" 2>/dev/null
	rm -rf "$MODPATH/README.md" 2>/dev/null
}

abort() {
	ui_print "$1"
	rm -rf "$MODPATH" 2>/dev/null
	cleanup
	rm -rf "$TMPDIR" 2>/dev/null
	exit 1
}

device_check() {
	opt=$(getopt -o dm -- "$@") type=device
	eval set -- "$opt"
	while true; do
		case "$1" in
			-d)
				type=device
				shift
				;;
			-m)
				type=manufacturer
				shift
				;;
			--)
				shift
				break
				;;
			*) abort "Invalid device_check argument $1! Aborting!" ;;
		esac
	done
	prop=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	for i in /system /vendor /odm /product; do
		[[ -f "$i/build.prop" ]] && {
			for j in "ro.product.$type" "ro.build.$type" "ro.product.vendor.$type" "ro.vendor.product.$type"; do
				[[ "$(sed -n "s/^$j=//p" "$i/build.prop" 2>/dev/null | head -n 1 | tr '[:upper:]' '[:lower:]')" == "$prop" ]] && return 0
			done
			[[ "$type" == "device" ]] && [[ "$(sed -n "s/^"ro.build.product"=//p" "$i/build.prop" 2>/dev/null | head -n 1 | tr '[:upper:]' '[:lower:]')" == "$prop" ]] && return 0
		}
	done
}

cp_ch() {
	opt=$(getopt -o nr -- "$@") BAK=true UBAK=true FOL=false
	eval set -- "$opt"
	while true; do
		case "$1" in
			-n)
				UBAK=false
				shift
				;;
			-r)
				FOL=true
				shift
				;;
			--)
				shift
				break
				;;
			*) abort "Invalid cp_ch argument $1! Aborting!" ;;
		esac
	done
	SRC="$1" DEST="$2" OFILES="$1"
	"$FOL" && OFILES=$(find "$SRC" -type f 2>/dev/null)
	[[ -z "$3" ]] && PERM=0644 || PERM="$3"
	case "$DEST" in
		$TMPDIR/* | $MODULEROOT/* | $NVBASE/modules/$MODID/*) BAK=false ;;
	esac
	for OFILE in "$OFILES"; do
		"$FOL" && {
			[[ "$(basename "$SRC")" == "$(basename "$DEST")" ]] && FILE=$(echo "$OFILE" | sed "s|$SRC|$DEST|") || FILE=$(echo "$OFILE" | sed "s|$SRC|$DEST/$(basename "$SRC")|")
		} || [[ -d "$DEST" ]] && FILE="$DEST/$(basename "$SRC")" || FILE="$DEST"
		"$BAK" && "$UBAK" && {
			[[ ! "$(grep "$FILE"$ "$INFO" 2>/dev/null)" ]] && echo "$FILE" >>"$INFO"
			[[ -f "$FILE" -a ! -f $FILE~ ]] && {
			mv -f "$FILE" "$FILE"~
			echo "$FILE"~ >>"$INFO"
		} || "$BAK" && [[ ! "$(grep "$FILE"$ "$INFO" 2>/dev/null)" ]] && echo "$FILE" >>"$INFO"
	}
		install -D -m "$PERM" "$OFILE" "$FILE"
	done
}

install_script() {
	case "$1" in
		-l)
			shift
			INPATH="${NVBASE}/service.d"
			;;
		-p)
			shift
			INPATH="${NVBASE}/post-fs-data.d"
			;;
		*) INPATH=$NVBASE/service.d ;;
	esac
	[[ "$(grep "#!/system/bin/sh" "$1")" ]] || sed -i "1i #!/system/bin/sh" "$1"
	for i in "MODPATH" "LIBDIR" "MODID" "INFO" "MODDIR"; do
		case "$i" in
			"MODPATH") sed -i "1a $i=$NVBASE/modules/$MODID" "$1" ;;
			"MODDIR") sed -i "1a $i=\${0%/*}" "$1" ;;
			*) sed -i "1a $i=$(eval echo \$$i)" "$1" ;;
		esac
	done
	[[ "$1" == "$MODPATH/uninstall.sh" ]] && return 0
	case $(basename "$1") in
		post-fs-data.sh | service.sh) ;;
		*) cp_ch -n "$1" "$INPATH"/"$(basename "$1")" 0755 ;;
	esac
}

prop_process() {
	sed -i -e "/^#/d" -e "/^ *$/d" "$1"
	[[ -f "$MODPATH/system.prop" ]] || mktouch "$MODPATH/system.prop"
	while read LINE; do
		echo "$LINE" >>"$MODPATH/system.prop"
	done <"$1"
}


# Check for min/max api version
[[ -z "$MINAPI" ]] || { [[ "$API" -lt "$MINAPI" ]] && abort "[!] Your system API of ${API} is less than the minimum api of ${MINAPI}! Aborting!"; }
[[ -z "$MAXAPI" ]] || { [[ "$API" -gt "$MAXAPI" ]] && abort "[!] Your system API of ${API} is greater than the maximum api of ${MAXAPI}! Aborting!"; }

# Set variables
[[ -z "$ARCH32" ]] && ARCH32=$(echo "$ARCH" | cut -c-3)
[[ "$API" -lt "26" ]] && DYNLIB=false
[[ -z "$DYNLIB" ]] && DYNLIB=false
[[ -z "$DEBUG" ]] && DEBUG=false
INFO="$NVBASE/modules/.$MODID-files"
ORIGDIR="$MAGISKTMP/mirror"
"$DYNLIB" && {
	LIBPATCH="\/vendor"
	LIBDIR=/system/vendor
} || {
	LIBPATCH="\/system"
	LIBDIR=/system
}

! "$BOOTMODE" && {
	ui_print "[*] Only uninstall is supported in recovery"
	ui_print "    Uninstalling!"
	touch "$MODPATH/remove"
	[[ -s "$INFO" ]] && install_script "$MODPATH/uninstall.sh" || rm -f "$INFO" "$MODPATH/uninstall.sh"
	recovery_cleanup
	cleanup
	rm -rf "$NVBASE/modules_update/$MODID" "$TMPDIR" 2>/dev/null
	exit 0
}

# Debug
"$DEBUG" && {
	ui_print "█Debug mode"
	ui_print "    Module install log will include debug info."
	ui_print ""
	set -x
}

# Extract files
ui_print "█Extracting module files..."
unzip -o "$ZIPFILE" -x 'META-INF/*' 'common/functions.sh' -d "$MODPATH" >&2
[[ -f "$MODPATH/common/addon.tar.xz" ]] && tar -xf "$MODPATH/common/addon.tar.xz" -C "$MODPATH/common" 2>/dev/null

# Run addons
[[ "$(ls -A "$MODPATH"/common/addon/*/install.sh 2>/dev/null)" ]] && {
	ui_print " "
	ui_print "█Running Addons..."
	for i in "$MODPATH"/common/addon/*/install.sh; do
		ui_print "█Running $(echo "$i" | sed -r "s|$MODPATH/common/addon/(.*)/install.sh|\1|")..."
		. "$i"
	done
}

# Remove files outside of module directory
ui_print "█Removing old files..."

[[ -f "$INFO" ]] && {
	while read LINE; do
		[[ "$(echo -n "$LINE" | tail -c 1)" == "~" ]] && continue || [[ -f $LINE~ ]] && mv -f "$LINE"~ "$LINE" || rm -f "$LINE"
			while true; do
				LINE=$(dirname "$LINE")
				[[ "$(ls -A "$LINE" 2>/dev/null)" ]] && break 1 || rm -rf "$LINE"
			done
	done <"$INFO"
	rm -f "$INFO"
}

# Install process
ui_print "█Installing..."

[[ -f "$MODPATH/common/install.sh" ]] && . "$MODPATH/common/install.sh"

ui_print "█Installing for $ARCH SDK $API device..."
# Remove comments from files and place them, add blank line to end if not already present
for i in $(find "$MODPATH" -type f -name *.sh -o -name *.prop -o -name *.rule); do
	[[ -f "$i" ]] && {
		sed -i -e "/^#/d" -e "/^ *$/d" "$i"
		[[ "$(tail -1 "$i")" ]] && echo "" >>"$i"
	} || continue
	case "$i" in
		"$MODPATH/service.sh") install_script -l "$i" ;;
		"$MODPATH/post-fs-data.sh") install_script -p "$i" ;;
		"$MODPATH/uninstall.sh") [[ -s "$INFO" ]] || [[ "$(head -n1 "$MODPATH/uninstall.sh")" != "# Don't modify anything after this" ]] && install_script "$MODPATH/uninstall.sh" || rm -f "$INFO" "$MODPATH/uninstall.sh" ;;
	esac
done

"$IS64BIT" || for i in "$(find "$MODPATH/system" -type d -name "lib64")"; do rm -rf "${i}" 2>/dev/null; done
[[ -d "/system/priv-app" ]] || mv -f "${MODPATH}/system/priv-app" "${MODPATH}/system/app" 2>/dev/null
[[ -d "/system/xbin" ]] || mv -f "${MODPATH}/system/xbin" "${MODPATH}/system/bin" 2>/dev/null
"$DYNLIB" && {
	for FILE in $(find "$MODPATH"/system/lib* -type f 2>/dev/null | sed "s|""$MODPATH""/system/||"); do
		[[ -s "$MODPATH/system/$FILE" ]] || continue
		case "$FILE" in
			lib*/modules/*) continue ;;
		esac
		mkdir -p "$(dirname "$MODPATH/system/vendor/$FILE")"
		mv -f "$MODPATH/system/$FILE" "$MODPATH/system/vendor/$FILE"
		[[ "$(ls -A $(dirname "$MODPATH"/system/"$FILE"))" ]] || rm -rf "$(dirname "$MODPATH/system/$FILE")"
	done
  # Delete empty lib folders (busybox find doesn't have this capability)
  toybox find "$MODPATH"/system/lib* -type d -empty -delete >/dev/null 2>&1
}

# Set permissions
ui_print " "
ui_print "█Setting Permissions..."
set_perm_recursive "$MODPATH" 0 0 0755 0644
[[ -d "$MODPATH/system/etc" ]] && set_perm_recursive "$MODPATH/system/etc" 0 0 0755 0755 u:object_r:system_etc_file:s0
[[ -d "$MODPATH/system/bin" ]] && set_perm_recursive "$MODPATH/system/bin" 0 0 0755 0755 u:object_r:system_bin_file:s0
[[ -d "$MODPATH/system/vendor" ]] && set_perm_recursive "$MODPATH/system/vendor" 0 0 0755 0644 u:object_r:vendor_file:s0
[[ -d "$MODPATH/system/vendor/app" ]] && set_perm_recursive "$MODPATH/system/vendor/app" 0 0 0755 0644 u:object_r:vendor_app_file:s0
[[ -d "$MODPATH/system/vendor/etc" ]] && set_perm_recursive "$MODPATH/system/vendor/etc" 0 0 0755 0644 u:object_r:vendor_configs_file:s0
[[ -d "$MODPATH/system/vendor/overlay" ]] && set_perm_recursive "$MODPATH/system/vendor/overlay" 0 0 0755 0644 u:object_r:vendor_overlay_file:s0
for FILE in $(find "$MODPATH/system/vendor" -type f -name *".apk"); do
	[[ -f "$FILE" ]] && chcon u:object_r:vendor_app_file:s0 "$FILE"
done
set_permissions

# Complete install
cleanup
