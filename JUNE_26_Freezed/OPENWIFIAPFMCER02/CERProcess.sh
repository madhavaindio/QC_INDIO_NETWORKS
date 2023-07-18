source ./Alpha.sh

source ./AP_FM_CF.sh

#source ./AP_Verify.sh

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

#mac_id["$i"]=$(echo "$MAC" | tr '[:upper:]' '[:lower:]')


mac_id["$i"]=$(echo "$MAC" | tr '[:lower:]' '[:upper:]')

printf " MACID IN SMALL LETTERS   "

printf "mac_id[0]=%s" ${mac_id["$i"]}

mac_id1["$i"]=$(echo "$MAC" | sed 's/://g')


printf "mac_id1[0]=%s" ${mac_id1["$i"]}

#printf "tar_file[0]=%s" "$tar_file[0]".tar.gz

tar_file["$i"]=${mac_id1["$i"]}.tar.gz

sqsh_file["$i"]=${mac_id1["$i"]}.sqsh

printf "tar[0]=%s" ${tar_file["$i"]}

printf "sqsh_file[0]=%s" ${sqsh_file["$i"]}

printf "shall I proceed 2"


Report_Log " Certification process Starts *** "

Report_Log ${mac_id["$i"]} 

printf " MACID IN SMALL LETTERS  "

printf "mac_id[0]=%s" ${mac_id["$i"]}

echo "   Iam going to Alpha server     "



Connnect_Alpha ${mac_id["$i"]}

sleep 90

echo "TAR File Name is " ${tar_file["$i"]}

echo "Download FIle" ${mac_id1["$i"]}
        
Copy_Alpha ${tar_file["$i"]} ${mac_id1["$i"]}

echo "Uzipping Now be ready ---"

sleep 50


        
unzip_sqsh ${tar_file["$i"]} ${mac_id1["$i"]} ${ip_array["$i"]}


echo "copied the content from alpha- check now"

















































































