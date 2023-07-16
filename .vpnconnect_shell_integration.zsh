# Copyright (c) 2023 Gijs Keij
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
# based on the sample tunnelblick OSA scripts

function vpnconnect() {
    # Temporary file to hold the previous VPN connection state
    TEMP_FILE="$TMPDIR/previous_vpn.txt"

    # Temporary file to hold the last established VPN connection state
    LAST_VPN_FILE="$TMPDIR/current_vpn.txt"

    # Desired VPN profile for connection
    VPN_PROFILE="$HOME/.config/vpnconnect/vpn_profile.txt"

    # Function to set a VPN profile for connection
    set_vpn_profile() {
        local vpn_name=$1
        if [[ -n "$vpn_name" ]]; then
            echo "$vpn_name" >"$VPN_PROFILE"
            echo "VPN profile has been set to: $vpn_name"
        elif [[ -f "$VPN_PROFILE" && -n "$(cat "$VPN_PROFILE")" ]]; then
            echo "Current VPN profile is: $(cat "$VPN_PROFILE")"
        else
            echo "No VPN profile set. Choose one from the list of available VPN profiles:"
            local available_profiles=$(osascript -e 'tell application "Tunnelblick"' -e 'get name of configurations' -e 'end tell')
            echo "$available_profiles"
            echo "Enter the name of the desired VPN profile:"
            read vpn_name
            echo "$vpn_name" >"$VPN_PROFILE"
            echo "VPN profile has been set to: $vpn_name"
        fi
    }

    # Function to get a VPN profile for connection
    get_vpn_profile() {
        if [[ -n $1 ]]; then
            echo "$1"
        elif [[ -f "$VPN_PROFILE" ]]; then
            cat "$VPN_PROFILE"
        else
            echo "No VPN profile set. Choose one from the list of available VPN profiles:"
            local available_profiles=$(osascript -e 'tell application "Tunnelblick"' -e 'get name of configurations' -e 'end tell')
            echo "$available_profiles"
            echo "Enter the name of the desired VPN profile:"
            read vpn_name
            echo "$vpn_name" >"$VPN_PROFILE"
            cat "$VPN_PROFILE"
        fi
    }

    # Function to clear a VPN profile for connection
    clear_vpn_profile() {
        if [[ -f "$VPN_PROFILE" ]]; then
            rm "$VPN_PROFILE"
            echo "VPN profile has been cleared."
        else
            echo "No VPN profile is set."
        fi
    }

    # Function to check if there are any active OPENVPN connections
    check_active_connections() {
        local active_conn=$(osascript -e 'tell application "Tunnelblick"' -e "get state of first configuration where name = \"$vpn_name\"" -e 'end tell')
        if [[ -z "$active_conn" ]]; then
            return 1
        else
            echo "$active_conn" >"$TEMP_FILE"
            return 0
        fi
    }

    # Function to disconnect from an OPENVPN connection
    openvpn_disconnect() {
        local vpn_name=$1
        osascript -e 'tell application "Tunnelblick"' -e "disconnect \"$vpn_name\"" -e 'end tell'
        echo "Disconnecting from $vpn_name ..."
        # Wait for the connection to be disconnected
        while is_vpn_connected "$vpn_name"; do
            echo "Waiting for $vpn_name to disconnect..."
            sleep 2
        done
        echo "Disconnected from $vpn_name."
    }

    # Function to connect to an OPENVPN connection
    openvpn_connect() {
        local vpn_name=$1
        osascript -e 'tell application "Tunnelblick"' -e "connect \"$vpn_name\"" -e 'end tell'
        echo "$vpn_name" >"$LAST_VPN_FILE"
    }

    # Function to check if there are any active OPENVPN connections
    check_active_connections() {
        local active_conn=$(osascript -e 'tell application "Tunnelblick"' -e 'get name of configurations where state is not "EXITING"' -e 'end tell')
        if [[ -z "$active_conn" ]]; then
            return 1
        else
            echo "$active_conn"
            return 0
        fi
    }

    # Function to check if a specific VPN is connected
    is_vpn_connected() {
        local vpn_name=$1
        local active_conn=$(osascript -e 'tell application "Tunnelblick"' -e "get state of first configuration where name = \"$vpn_name\"" -e 'end tell')
        [[ "$active_conn" != "EXITING" ]]
    }

    # Configure the VPN profile
    if [[ $1 == "config" ]]; then
        set_vpn_profile "$2"

    # Open the VPN session
    elif [[ $1 == "open" ]]; then
        local vpn_profile=$(get_vpn_profile "$2")
        local active_connections=$(check_active_connections)
        if [[ -n "$active_connections" ]]; then
            IFS=', ' read -ra active_vpn_array <<<"$active_connections"
            for active_vpn in "${active_vpn_array[@]}"; do
                openvpn_disconnect "$active_vpn"
            done
        fi
        openvpn_connect "$vpn_profile"
        exit 0

    # Close the VPN session
    elif [[ $1 == "close" ]]; then
        if [[ -f "$LAST_VPN_FILE" ]]; then
            local last_vpn=$(cat "$LAST_VPN_FILE")
            openvpn_disconnect "$last_vpn"
            rm "$LAST_VPN_FILE"
            echo "VPN to $last_vpn is Disconnected"
        fi
        if [[ -f "$TEMP_FILE" ]]; then
            local prev_vpn=$(cat "$TEMP_FILE")
            IFS=", " read -rA PREV_VPNS <<<"$prev_vpn"
            for vpn in "${PREV_VPNS[@]}"; do
                openvpn_connect "$vpn"
            done
            rm "$TEMP_FILE"
            exit 0
        else
            echo "Not reconnecting previous connection as no previous VPN connection found."
            exit 0
        fi

    # Clear the VPN profile
    elif [[ $1 == "clear" ]]; then
        clear_vpn_profile
    else
        echo "Invalid parameter. Use 'config', 'open', 'close' or 'clear'."
    fi
}
