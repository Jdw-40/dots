#!/usr/bin/env bash

USAGE() {
	cat <<"USAGE"
	Usage: $(basename "$0") [option]
	Options:
		p     Print all outputs
		s     Select area or window to screenshot
		sf    Select area or window with frozen screen
		m     Screenshot focused monitor
		sc    Use tesseract to scan image, then add to clipboard
USAGE
}

# Check if a package is installed
pkg_installed() {
    command -v "$1" >/dev/null 2>&1
}

# Check required packages
check_package() {
    for pkg in "$@"; do
        if ! pkg_installed "$pkg"; then
            notify-send -a "Screenshot Error" "Missing package: $pkg" -e -i "dialog-error"
            exit 1
        fi
    done
}

SCREENSHOT_POST_COMMAND+=(
)
SCREENSHOT_PRE_COMMAND+=(
)

pre_cmd() {
	for cmd in "${SCREENSHOT_POST_COMMAND[@]}"; do
		eval "$cmd"
	done
	trap 'post_cmd' EXIT
}

post_cmd() {
	for cmd in "${SCREENSHOT_POST_COMMAND[@]}"; do
		eval "$cmd"
	done
}

# Create secure temporary file
temp_screenshot=$(mktemp -t screenshot_XXXXXX.png)

if [ -z "$XDG_PICTURES_DIR" ]; then
	XDG_PICTURES_DIR="$HOME/Pictures"
fi

confDir="${XDG_CONFIG_HOME:-$HOME/.config}"
save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')

# Set annotation tool preference
annotation_tool=${SCREENSHOT_ANNOTATION_TOOL}
annotation_args=("-o" "${save_dir}/${save_file}" "-f" "${temp_screenshot}")

if [[ -z "$annotation_tool" ]]; then
	pkg_installed "swappy" && annotation_tool="swappy"
	pkg_installed "satty" && annotation_tool="satty"
fi

mkdir -p "$save_dir"

# Configure annotation tools
if [[ "$annotation_tool" == "swappy" ]]; then
	swpy_dir="${confDir}/swappy"
	mkdir -p "$swpy_dir"
	echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" >"${swpy_dir}"/config
fi

if [[ "$annotation_tool" == "satty" ]]; then
	annotation_args=("-f" "${temp_screenshot}")
	# Check if config exists, add it if found
	if [[ -f "${confDir}/satty/config.toml" ]]; then
		annotation_args+=("-c" "${confDir}/satty/config.toml")
	fi
fi

# Add any additional annotation arguments
[[ -n "${SCREENSHOT_ANNOTATION_ARGS[*]}" ]] && annotation_args+=("${SCREENSHOT_ANNOTATION_ARGS[@]}")

# screenshot function using grim instead of grimblast
take_screenshot() {
	local mode=$1
	shift
	local extra_args=("$@")

	case "$mode" in
		"area")
			if [[ "${extra_args[*]}" == *"--freeze"* ]]; then
				# Frozen screen selection
				if ! GEOM=$(slurp -d); then
					notify-send -a "Screenshot Alert" "Selection cancelled" -e -i "dialog-error"
					return 1
				fi
			else
				# Normal area selection
				if ! GEOM=$(slurp); then
					notify-send -a "Screenshot Alert" "Selection cancelled" -e -i "dialog-error"
					return 1
				fi
			fi
			grim -g "$GEOM" "$temp_screenshot"
			;;
		"screen")
			# Full screen - no additional args needed
			grim "$temp_screenshot"
			;;
		"output")
			# Current monitor/output
			local monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
			grim -o "$monitor" "$temp_screenshot"
			;;
	esac

	# Check if screenshot was taken successfully
	if [[ ! -f "$temp_screenshot" ]] || [[ ! -s "$temp_screenshot" ]]; then
		notify-send -a "Screenshot Alert" "Screenshot Error" "Failed to take screenshot"
		return 1
	fi

	# Copy to clipboard first
	wl-copy < "$temp_screenshot"

	# Then open annotation tool
	if ! "${annotation_tool}" "${annotation_args[@]}"; then
		notify-send -a "Screenshot Alert" "Screenshot Error" "Failed to open annotation tool"
		return 1
	fi
}

pre_cmd

case $1 in
p) # print all outputs
	take_screenshot "screen"
	;;
s) # drag to manually snip an area / click on a window to print it
	take_screenshot "area"
	;;
sf) # frozen screen, drag to manually snip an area / click on a window to print it
	take_screenshot "area" "--freeze"
	;;
m) # print focused monitor
	take_screenshot "output"
	;;
sc) # Use 'tesseract' to scan image then add to clipboard
	check_package tesseract
	if ! GEOM=$(slurp); then
		notify-send -a "Screenshot Alert" "OCR preview: Invalid geometry" -e -i "dialog-error"
		exit 1
	fi
	grim -g "${GEOM}" "${temp_screenshot}"
	pkg_installed convert && convert "${temp_screenshot}" -sigmoidal-contrast 10,50% "${temp_screenshot}"
	tesseract "${temp_screenshot}" - | wl-copy
	notify-send -a "Screenshot Alert" "OCR preview" -i "${temp_screenshot}" -e
	rm -f "$temp_screenshot"
	;;
*) # invalid option
	USAGE
	;;
esac

# Cleanup
[ -f "$temp_screenshot" ] && rm "$temp_screenshot"

if [ -f "${save_dir}/${save_file}" ]; then
	notify-send -a "Screenshot Alert" -i "${save_dir}/${save_file}" "saved in ${save_dir}"
fi
