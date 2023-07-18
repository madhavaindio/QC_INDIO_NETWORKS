source ./Alpha.sh

source ./AP_FM_CF.sh

source ./AP_Verify.sh

source ./AP_Basickcheck.sh

source ./Log.sh

source ./CF.sh

source ./AP_Filecheck.sh

source ./AP_IP_MAC.sh

sleep 30

echo "IPNumber PLease: $1";

printf "please note that your input is =%s" "$1"


FM_Name="$FM_FILE"


printf "shall I proceed 1"

i=0

sleep 5

echo "IP You have sent is " "$1"

sleep 10

ip_array["$i"]="$1"

Entrycheck ${ip_array["$i"]}

#Get_AP_MAC ${ip_array["$i"]}




































































