source ./CF.sh

source ./Log.sh

#source ./CF.sh

#source ./AP_Filecheck.sh

source AP_Generic_Lib.sh

Verify_APDetials01()

{

Dname="$1"_Check

mc=$(echo "$1" | tr '[:upper:]' '[:lower:]')

mc1="$1"

echo "mc is " "$mc"


AP_IP="$2"

mc2="$3"


# Ping

checkconfile=$(eval "$CONN_AP$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

sleep 5

cd /tmp

ls

echo "I am pinging do not worry"
ping -c 5 -w 5  google.com

sleep 2
exit

EOF_run_commands
)

sleep 5

value=`cat "$AP_IP"errors.txt` 

rm "$AP_IP"errors.txt

Report_Log "Ping Results"


Report_Log ""$mc" $checkconfile"


if [[ "$checkconfile" == *"5 packets transmitted"* && "$checkconfile" == *"5 packets received"*  ]];
then
    ping="pass"
    echo "ping Pass Do not worry"
else
   echo "ping  not proper"
   
    ping="fail"
    
    Report_Log "Reason for Ping Failure"
    
    Report_Log "$value"
fi




# FM Verification


Verify_Expval_1 "$AP_IP" "tmp" "$Fetch_FM_Verison" "$FMVERSION" "Verify FM Version"

FM="$Res1"


# SSID

echo "MC Values are"

echo "$mc1"

echo "$mc"

#SSID="Test-Report-Private"

#v3=""$mc2"  "$SSID""

#Verify_Expval_2  "nmcli dev wifi" "$v3" "Verify SSID NAME"

#Broadcast="$Res2"


Get_AP_MAC "$AP_IP" "eth1"

echo "eth1 mac is" "$MAC"

Verify_Expval_2  "nmcli dev wifi" "$MAC"  "Verify SSID NAME"

Broadcast1="$Res2"

echo "$Broadcast"



Get_AP_MAC "$AP_IP" "eth0"

echo "eth0 mac is" "$MAC"

Verify_Expval_2  "nmcli dev wifi" "$MAC"  "Verify SSID NAME"

Broadcast2="$Res2"

echo "$Broadcast"



Get_AP_MAC "$AP_IP" "wlan0-1"

echo "wlan0-1 mac is" "$MAC"

Verify_Expval_2  "nmcli dev wifi" "$MAC"  "Verify SSID NAME"

Broadcast3="$Res2"

echo "$Broadcast"


#Report_SummaryLog "Brief Summary"

#Report_SummaryLog "MAC       FM Verison check  PING Results -  Braodcast Check-eth0-eth1-wlan  "

#echo "I am reporting mac in Log file " "$mc1"

Report_SummaryLog "  "" "$mc1"   "$FM-"    "$ping-"    "$Broadcast1"  "$Broadcast2" "$Broadcast3" "

}














