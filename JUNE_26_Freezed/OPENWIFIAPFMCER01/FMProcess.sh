source ./AP_FM_CF.sh

source ./AP_Verify.sh

source ./AP_Basickcheck.sh

source ./Log.sh

source ./CF.sh

source ./AP_Filecheck.sh

source ./AP_IP_MAC.sh

source ./CMLIST.sh

sleep 3



echo "IPNumber PLease: $1";

printf "please note that your input is =%s" "$1"


FM_Name="$FM_FILE"


printf "shall I proceed 1"

i=0

sleep 5

echo "IP You have sent is " "$1"

sleep 10



ip_array["$i"]="$1"




if [[ "$FMProcess" = "OPENWIFI" ]]; then

echo "--Done---"

Get_Conn_List "OPENWIFI"

else

Get_Conn_List "INDIONEW"

fi



Entrycheck ${ip_array["$i"]}


Get_AP_MAC ${ip_array["$i"]} "eth0"


if [[ "$MAC" == "" ]]; then

echo "could not continue mac not found"

fi

mac_id["$i"]=$(echo "$MAC" | tr '[:upper:]' '[:lower:]')

printf "mac_id[0]=%s" ${mac_id["$i"]}

mac_id1["$i"]=$(echo "$MAC" | sed 's/://g')


printf "mac_id1[0]=%s" ${mac_id1["$i"]}

#printf "tar_file[0]=%s" "$tar_file[0]".tar.gz

tar_file["$i"]=${mac_id1["$i"]}.tar.gz

sqsh_file["$i"]=${mac_id1["$i"]}.sqsh

printf "tar[0]=%s" ${tar_file["$i"]}

printf "sqsh_file[0]=%s" ${sqsh_file["$i"]}

printf "shall I proceed 2"



Report_Log "*** FM process Starts *** "
	
echo ${ip_array["$i"]} ${mac_id["$i"]} ${mac_id["$i"]}.tar.gz "$FM_Name"


Report_Log "FM process Starts for AP MAC address ***"

Report_Log ${mac_id["$i"]}    
        
Copy_FM_AP ${ip_array["$i"]} "$FM_Name"

Check_File_Exists ${ip_array["$i"]} "$FM_Name" "/tmp"

printf "file existence 009=%s" "$fileexistence"

if [[ "$fileexistence" = "yesverified" ]]; then

  echo "FM File copied.Donot worry be happy 001"
  
  Report_Log "FM FIle copied to AP"
  
  Install_FM ${ip_array["$i"]} "$FM_Name"

else
   echo "FM File not Copied to AP could not continue"
   
  Report_Log "FM FIle Not copied to AP"
fi                

        
















































































