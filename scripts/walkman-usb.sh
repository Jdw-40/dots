#!/usr/bin/env bash
# walkman-usb.sh — manage the Sony NW-A608's usb-storage binding + safe mount/unmount
# Usage: walkman-usb.sh connect|disconnect

set -euo pipefail

VENDOR_ID="054c"
DRIVER="usb-storage"

find_walkman_interface() {
    local dev devname iface
    for dev in /sys/bus/usb/devices/*; do
        [[ -f "$dev/idVendor" ]] || continue
        [[ "$(cat "$dev/idVendor" 2>/dev/null)" == "$VENDOR_ID" ]] || continue
        devname="$(basename "$dev")"
        for iface in /sys/bus/usb/devices/"${devname}":*; do
            [[ -f "$iface/bInterfaceClass" ]] || continue
            if [[ "$(cat "$iface/bInterfaceClass")" == "08" ]]; then
                basename "$iface"
                return 0
            fi
        done
    done
    return 1
}

find_blockdev_for_interface() {
    local iface="$1" blk devpath
    for blk in /sys/class/block/*; do
        [[ -e "$blk/partition" ]] && continue
        devpath="$(readlink -f "$blk/device" 2>/dev/null)" || continue
        [[ "$devpath" == *"/${iface}/"* ]] || continue
        basename "$blk"
        return 0
    done
    return 1
}

cmd_connect() {
    local iface blockdev part tries=0

    iface="$(find_walkman_interface)" || {
        echo "Walkman not found on USB — is it plugged in?"
        exit 1
    }
    echo "Found Walkman interface: $iface"

    if [[ -e "/sys/bus/usb/drivers/$DRIVER/$iface" ]]; then
        echo "Already bound to $DRIVER — unbinding first to force a clean rebind..."
        echo "$iface" | sudo tee "/sys/bus/usb/drivers/$DRIVER/unbind" >/dev/null
        sleep 1
    fi

    echo "Binding $iface to $DRIVER..."
    echo "$iface" | sudo tee "/sys/bus/usb/drivers/$DRIVER/bind" >/dev/null

    until blockdev="$(find_blockdev_for_interface "$iface")" && [[ -n "$blockdev" ]]; do
        tries=$((tries + 1))
        if (( tries > 10 )); then
            echo "Driver bound, but no block device showed up after 5s."
            echo "Check manually: lsusb -t / lsblk"
            exit 1
        fi
        sleep 0.5
    done

    echo "Walkman is available as /dev/$blockdev"
    part="/dev/${blockdev}1"
    if [[ -b "$part" ]]; then
        udisksctl mount -b "$part" 2>/dev/null \
            && echo "Mounted $part" \
            || echo "(already mounted, or mount failed — check 'udisksctl mount -b $part' manually)"
    fi
}

cmd_disconnect() {
    local iface blockdev part

    iface="$(find_walkman_interface)" || {
        echo "Walkman not found on USB — is it plugged in?"
        exit 1
    }

    blockdev="$(find_blockdev_for_interface "$iface")" || {
        echo "Interface $iface found, but no block device is bound to it right now."
        exit 1
    }
    echo "Found Walkman as /dev/$blockdev"

    for part in /dev/"${blockdev}"[0-9]*; do
        [[ -b "$part" ]] || continue
        echo "Unmounting $part..."
        udisksctl unmount -b "$part" 2>/dev/null || echo "(already unmounted)"
    done

    echo "Powering off /dev/$blockdev..."
    udisksctl power-off -b "/dev/$blockdev"

    echo "Safe to unplug now — wait for the Walkman's own 'USB Connect' idle screen first."
}

case "${1:-}" in
    connect)    cmd_connect ;;
    disconnect) cmd_disconnect ;;
    *)
        echo "Usage: $0 {connect|disconnect}"
        exit 1
        ;;
esac
