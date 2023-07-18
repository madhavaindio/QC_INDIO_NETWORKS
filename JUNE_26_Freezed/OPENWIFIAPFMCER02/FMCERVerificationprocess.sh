source ./Alpha.sh

source ./AP_FM_CF.sh

source ./AP_Verify.sh

source ./AP_Basickcheck.sh

source ./Log.sh

source ./CF.sh

source ./AP_Filecheck.sh

source ./AP_IP_MAC.sh

source ./CMLIST.sh

echo "IPNumber PLease: $1";

printf "please note that your input is =%s" "$1"


printf "shall I proceed 1"

i=0

ip_array["$i"]="$1"

Get_Conn_List "OPENWIFI"

Entrycheck ${ip_array["$i"]}

Get_AP_MAC ${ip_array["$i"]} "eth0"

if [[ "$MAC" == "" ]]; then

echo "could not continue mac not found"

fi

mac_id["$i"]=$(echo "$MAC" | tr '[:upper:]' '[:lower:]')

printf "mac_id[0]=%s" ${mac_id["$i"]}

mac_id1["$i"]=$(echo "$MAC" | sed 's/://g')


printf "mac_id1[0]=%s" ${mac_id1["$i"]}


printf "shall I proceed 2"

Report_Log " FM - Certification process -- Verification Starts *** "

Report_Log ${mac_id["$i"]} 

copy_from_ap ${ip_array["$i"]} ${mac_id1["$i"]}
 
Verify_APDetials ${mac_id1["$i"]} ${ip_array["$i"]}
  
  


Report_Log "*** FM - Certification - Verification process Ends *** "
        






















































































