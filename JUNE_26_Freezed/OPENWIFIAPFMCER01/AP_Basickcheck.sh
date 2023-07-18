source ./CF.sh

source ./Log.sh

source ./Log.sh

source ./AP_Generic_Lib.sh

Entrycheck ()


{

echo "The current message is"

AP_IP="$1"
             
sleep 2       
   
printf "AP_IP=%s" "$AP_IP"
  

Verify_Expval_0 "$AP_IP" "tmp" "ls" "$APLOGINCHECK" "Verify Login"

Verify_Expval_0 "$AP_IP" "tmp" "cat sysinfo/model" "$APMODEL" "Verify Model"




}















