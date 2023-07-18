
source ./AP_FM_CF.sh

#source ./AP_Verify.sh

source ./AP_Basickcheck.sh

source ./Log.sh

source ./CF.sh

source ./AP_Filecheck.sh

Get_AP_MAC ()

{


AP_IP="$1"

Dname="IPMAC""$1"

mc="$2"

eval "$CONN_AP$AP_IP"<< EOF_run_commands

sleep 5
		
ifconfig "$mc" | tee /tmp/CResult001.txt


sleep 5
	
exit

EOF_run_commands

echo "I Found Mac second time"

echo $output


mkdir "$Dname"

sleep 5


cd "$Dname"

sleep 5

eval "$AP_COPY" "$APUID"@"$AP_IP":/tmp/CResult001.txt .



macAddress=$( cat CResult001.txt |grep -o -w -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}');
output=$(echo $macAddress | tr [:lower:] [:upper:]);
echo $output;

MAC=$output

sleep 3

cd ..

rm -r "$Dname"

printf "mac is is=%s" "$MAC"

printf "DOnontworry" 

eval "$CONN_AP$AP_IP"<< EOF_run_commands

sleep 2
		
cd /tmp

sleep 2

rm CResult001.txt
	
sleep 2
	
exit

EOF_run_commands

if [[ "$MAC" != "" ]]; then

 printf "No problem"
 
 Report_Log "MAC  Found"

else
  printf "could not continue"
  
   Report_Log "MAC Not Found could not continue"
  
  #exit
  
fi


}































































