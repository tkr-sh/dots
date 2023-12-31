#!/bin/zsh


# The theme folder
theme = "$HOME/.config/rofi/style.rasi"


# notify-send "Getting list of available Wi-Fi networks..."
# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="睊  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="直  Enable Wi-Fi"
fi

wifi_list=$(echo -e "${wifi_list[@]}" | sort -u); echo "${wifi_list[@]}"


# Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -show -dmenu -i -selected-row 1 -p "Wi-Fi: " -theme ~/.config/rofi/wifi/style.rasi )
# Get name of connection
chosen_id=$(echo "${chosen_network:3}" | xargs)

echo $chosen_network



# Check the 
check_connection() {
	sleep 5;

	if [[ $REP =~ "successfully" ]]; then
		exit 0;
	fi
}



# If there is no 
if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "直  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "睊  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
	# Message to show when connection is activated successfully
	success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
	# Get saved connections
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		{
			check_connection &
			REP=$(nmcli connection up id "$chosen_id" )
			

		} || {
			if [[ "$chosen_network" =~ "" ]]; then
				wifi_password=$(rofi -dmenu -p "Password" -theme ~/.config/rofi/launchers/type-4/style-4.rasi )
			fi


			nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"
		}
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -p "Password" -theme ~/.config/rofi/launchers/type-4/style-4.rasi )
		fi
		

		echo $chosen_network
		echo $wifi_password


		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"

	fi
fi
