source ./CF.sh

source ./Log.sh

#source ./CF.sh

#source ./AP_Filecheck.sh


Verify_APDetials01()

{

Dname="$1"_Check

mc=$(echo "$1" | tr '[:upper:]' '[:lower:]')

mc1="$1"

echo "mc is " "$mc"


AP_IP="$2"



# Ping

checkconfile=$(sshpass -p "$APPWD" ssh -p 2233 "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

sleep 5

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


checkconfile=$(sshpass -p "$APPWD" ssh -p 2233 "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

sleep 5

cat /etc/banner

sleep 5
exit

EOF_run_commands
)

sleep 5

value=`cat "$AP_IP"errors.txt` 

rm "$AP_IP"errors.txt



Report_Log ""$mc" $checkconfile"


if [[ "$checkconfile" == *"$FMVERSION"* ]];
then
    FM="pass"
    echo "FM Pass Do not worry"
else
   echo "FM  not proper"
   
    FM="fail"  
    
    Report_Log "Reason for FM Check Failure"
    
    Report_Log "$value"
fi






# SSID

#${#mc1}
n=${#mc1}
echo "Length of the string is : $n "

id=$(echo ${mc1:6:$n})

echo "ID is : $id "

echo "SDid is"

echo "$SSID"-"$id"

checkconfile=$(sshpass -p "$APPWD" ssh -p 2233 "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

sleep 5

#cd /etc/config
sleep 2

#sed -i 's/'INDIO-Guest123'/$SSID-$id/g' wireless

 
#uci set wireless.@wifi-iface[0].ssid="$SSID""$id"

sleep 3

#uci set wireless.@wifi-iface[3].ssid="$SSID""$id"

sleep 3

#uci commit wireless

sleep 5
exit

EOF_run_commands
)

sleep 20

rm "$AP_IP"errors.txt

echo "ssi id is " "$SSID""$id"

conresult=$(echo "$Machinepwd" | sudo -S nmcli dev wifi connect "$SSID""$id")

echo "connection result is" "$coneresult"

sleep 20

concssid=$(iwgetid)

echo "ssid name after wireless change is"

echo "$concssid"

sleep 10

if [[ "$concssid" == *"$SSID""$id"* ]];
then  
   checkconfile=$(ping -c 5 -w 5  google.com )

  Report_Log "Ping Results through ssid"

  Report_Log "$mc $checkconfile"

if [[ "$checkconfile" == *"5 packets transmitted"* && "$checkconfile" == *"5 received"*  ]];
then
    Broadcast="pass"
    echo "Broad Cast Pass Do not worry"
else
   echo "Broad Cast  not proper"
   
   Broadcast="fail"
fi

else


echo "could not find SSID -Could not ping as well"

   Report_Log "Could not connect to AP SSID"
   
   Broadcast="fail"

fi




#SSID Name check



checkconfile=$(sshpass -p "$APPWD" ssh -p 2233 "$APUID"@"$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

sleep 5

iwinfo

sleep 5
exit

EOF_run_commands
)

sleep 5

value=`cat "$AP_IP"errors.txt` 

rm "$AP_IP"errors.txt



Report_Log ""$mc" $checkconfile"


if [[ "$checkconfile" == *"$SSID""$id"* ]];
then
    SSIDNAME="pass"
    echo "SSID Name present"
else
   echo "SSID Name not present"
   
    SSIDNAME="fail"  
    
    Report_Log "Reason for SSIDNAME Check Failure"
    
    Report_Log "$value"
fi






#Report_SummaryLog "Brief Summary"

#Report_SummaryLog "MAC       FM Verison check  PING Results -  Braodcast Check  "

Report_SummaryLog "  "" "$mc"   "$FM-"    "$ping-"    "$Broadcast"  "$SSIDNAME" "

}

















