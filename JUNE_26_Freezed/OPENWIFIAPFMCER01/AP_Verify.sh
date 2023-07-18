source ./CF.sh

source ./Log.sh

#source ./CF.sh

#source ./AP_Filecheck.sh

source ./AP_Generic_Lib.sh


copy_from_ap ()

{
AP_IP="$1"

Dname="$2"_Check


mkdir "$Dname"

sleep 5


#output_fname="outfile.txt"


#Mac_add="$1"

cd "$Dname"

sleep 5

sshpass -p "$APPWD" scp root@"$AP_IP":/etc/ucentral/key.pem . 2> "$AP_IP"errors.txt

#sshpass -p 'openwifi' scp root@"$AP_IP":/etc/ucentral/cas.pem . 

sshpass -p "$APPWD" scp root@"$AP_IP":/etc/ucentral/ca.pem . 2> "$AP_IP"errors.txt

sshpass -p "$APPWD" scp root@"$AP_IP":/etc/ucentral/cert.pem . 2> "$AP_IP"errors.txt

sshpass -p "$APPWD" scp root@"$AP_IP":/etc/ucentral/dev-id . 2> "$AP_IP"errors.txt


#sshpass -p 'openwifi' scp root@"$AP_IP":/tmp/"$output_fname" .

#sshpass -p 'openwifi' scp root@"$AP_IP":/tmp/ls >> "$output_fname" .

sleep 5

sshpass -p "$APPWD" scp root@"$AP_IP":/etc/config-shadow/ucentral . 2> "$AP_IP"errors.txt




value=`cat "$AP_IP"errors.txt` 

echo "value" "$value"


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "could not copy files for verification"
  Report_Log "Could not copy CR files for verification -exiting"
  rm errors.txt
  exit
else
 echo "could copy CR files for verification";
  
  Report_Log "could copy CR files for verification-Pass"
  
  rm "$AP_IP"errors.txt
  
  
fi

cd ..



sleep 2

}




Verify_APDetials()

{

Dname="$1"_Check

mc=$(echo "$1" | tr '[:upper:]' '[:lower:]')

mc1="$1"

echo "mc is " "$mc"

cd "$Dname"

AP_IP="$2"

sleep 5

Report_Log "$mc"

stepresult1=$(ls key.pem && echo pass) || echo fail

#stepresult=$(find -iname "key.pem")



Report_Log "Check if Key.pm file is present"

Report_Log "$stepresult1"


stepresult2=$(ls ca.pem && echo pass) || echo fail


Report_Log "Check if ca.pm file is present"

Report_Log "$stepresult2"


stepresult3=$(ls cert.pem && echo pass) || echo fail


Report_Log "Check if cert.pm file is present"

Report_Log "$stepresult3"


stepresult4=$(ls dev-id && echo pass) || echo fail


Report_Log "Check if dev-id file is present"

Report_Log "$stepresult4"

fcontent=$(cat ucentral)

printf "content=%s" "$fcontent"


Report_Log "Config Detials"

Report_Log "$fcontent"

sleep 5

rm -f  ca.pem

rm -f  key.pem

rm -f  cert.pem

rm -f  dev-id

cd ..

rm -r "$Dname"

echo "$stepresult1" 

echo "$stepresult2" 

echo "$stepresult3" 

echo "$stepresult4"

if [[ "$stepresult1" == *"pass"*  && "$stepresult2" == *"pass"* && "$stepresult3" == *"pass"* && "$stepresult4" == *"pass"* ]];
then
    CER="pass"
    echo "CER Pass Do not worry"
else
   echo "CER Files not present"
   
   CER="fail"
fi




if [[ "$fcontent" == *"config ucentral 'config'"*  && "$fcontent" == *"option server"* && "$fcontent" == *"option port '15002'"* && "$fcontent" == *"option debug '1"*  && "$fcontent" == *"option reporting '10'"* 

&& "$fcontent" == *"option serial"*  && "$fcontent" == *"$mc"*  && "$fcontent" == *"$servername"*  ]];
then
    CONF="pass"
    echo "CONFIG Pass Do not worry"
else
   echo "CONFIG Not Pass"
   
   CONF="fail"
fi


# Ping

checkconfile=$(sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no root@"$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

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


Report_Log "$mc $checkconfile"


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






#netstat

checkconfile=$(sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no root@"$AP_IP"<< EOF_run_commands 2> "$AP_IP"errors.txt

sleep 5

netstat

sleep 5
exit

EOF_run_commands
)

sleep 5

value=`cat "$AP_IP"errors.txt` 

rm "$AP_IP"errors.txt



Report_Log "$mc $checkconfile"


if [[ "$checkconfile" == *"$servername"* && "$checkconfile" == *"15002 ESTABLISHED"* ]];
then
    Port="pass"
    
    echo "Netstat Pass Do not worry"
else
   echo "Net stat not proper"
   
    Port="fail"  
    
    Report_Log "Reason for Net stat Failure"
    
    Report_Log "$value"
fi



# FM Verification


Verify_Expval_1 "$AP_IP" "tmp" "cat /etc/banner" "$FMVERSION" "Verify FM Version"

FM="$Res1"


# SSID


#SSID="Test-Report-Private"

#v3="$mc""  "$SSID""

#Verify_Expval_2  "nmcli dev wifi" "$v3" "Verify SSID NAME"

#Broadcast="$Res2"


Get_AP_MAC "$AP_IP" "eth1"

echo "eth1 mac is" "$MAC"

Verify_Expval_2  "nmcli dev wifi" "$MAC"  "Verify SSID NAME"

Broadcast1="$Res2"

echo "$Broadcast1"



Get_AP_MAC "$AP_IP" "eth0"

echo "eth0 mac is" "$MAC"

Verify_Expval_2  "nmcli dev wifi" "$MAC"  "Verify SSID NAME"

Broadcast2="$Res2"

echo "$Broadcast2"



Get_AP_MAC "$AP_IP" "wlan0-1"

echo "wlan0-1 mac is" "$MAC"

Verify_Expval_2  "nmcli dev wifi" "$MAC"  "Verify SSID NAME"

Broadcast3="$Res2"

echo "$Broadcast3"



#Report_SummaryLog "Brief Summary"

#Report_SummaryLog "MAC       FM Verison check - Certificate Files check - Ucentral File Check - PING Results -  Braodcast Check -     Net stat"

Report_SummaryLog " "$mc1"     "$FM-"            "$CER-"                      "$CONF-"              "$ping-"         "$Broadcast1"  "$Broadcast2"   "$Broadcast3"       "$Port""

}







