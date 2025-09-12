#!/usr/bin/env bash
set -euo pipefail

while true; do
    # Step 1: Get APT and Snap package lists
    apt_packages=$(apt-cache search . | awk '{print $1 " [apt] - " substr($0, index($0,$2))}')
    snap_packages=$(snap list | awk 'NR>1 {print $1 " [snap] - " $2}')

    # Combine
    packages=$(printf "%s\n%s" "$apt_packages" "$snap_packages")

    # Step 2: Show the list in rofi
    selection=$(echo "$packages" | rofi -dmenu -normal-window -i -p "Search package:")
    [[ -z "$selection" ]] && exit 0

    # Step 3: Extract pkg name + type
    pkg=$(echo "$selection" | awk '{print $1}')
    type=$(echo "$selection" | grep -oE '\[.*\]' | tr -d '[]')

    # Step 4: Get description
    if [[ "$type" == "apt" ]]; then
        desc=$(apt-cache show "$pkg" 2>/dev/null | awk '
            /^Description-en:/ {
                sub(/^Description-en: /,"")
                d=$0
                collecting=1
                next
            }
            collecting && /^[ ]/ {d = d " " $0; next}
            collecting && /^[^ ]/ {collecting=0}
            END { if (d) print d }' | fold -s -w 100 | head -n 6)
    else
        desc=$(snap info "$pkg" | awk '/description:/,/contact:/ {print}' \
               | sed 's/^description: //; s/contact:.*//g' \
               | fold -s -w 100 | head -n 6)
    fi

    # Add ellipsis if too long
    if [ "$(echo -n "$desc" | wc -l)" -ge 6 ]; then
        desc="$desc"$'\n'"..."
    fi

    # Step 5: Actions (depending on type & installed state)
    if [[ "$type" == "apt" ]]; then
        if dpkg -s "$pkg" &>/dev/null; then
            actions="🗑 Remove\n❌ Cancel"
        else
            actions="📥 Install\n❌ Cancel"
        fi
    else
        if snap list | awk '{print $1}' | grep -qx "$pkg"; then
            actions="🗑 Remove\n❌ Cancel"
        else
            actions="📥 Install\n❌ Cancel"
        fi
    fi

    # Step 6: Show menu
    menu="📝 $desc\n---\n$actions"
    action=$(echo -e "$menu" | rofi -dmenu -markup-rows -normal-window -i -p "Action:")
    action=$(echo "$action" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Step 7: Execute
    case "$action" in
        "📥 Install")
            if [[ "$type" == "apt" ]]; then
                wezterm start -- bash -c "sudo apt install -y $pkg; echo -e '\nDone! Press Enter to close.'; read"
            else
                wezterm start -- bash -c "sudo snap install $pkg; echo -e '\nDone! Press Enter to close.'; read"
            fi
            exit 0
            ;;
        "🗑 Remove")
            if [[ "$type" == "apt" ]]; then
                wezterm start -- bash -c "sudo apt remove -y $pkg; echo -e '\nDone! Press Enter to close.'; read"
            else
                wezterm start -- bash -c "sudo snap remove $pkg; echo -e '\nDone! Press Enter to close.'; read"
            fi
            exit 0
            ;;
        "❌ Cancel" | "" | "📝 "* | "---")
            continue
            ;;
    esac
done
