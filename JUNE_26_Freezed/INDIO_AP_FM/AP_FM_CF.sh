source ./CF.sh

source ./Log.sh

source ./AP_Generic_Lib.sh


Copy_FM_AP () 
{
       
cd FM
       
AP_IP="$1"
       
FM_File="$2"

Copy_File_ToAP "$AP_IP" "tmp"  "$FM_File" "TBD" "Copy FM"    

cd ..




  
}




Install_FM () 
{
 
AP_IP="$1"
       
FM_File="$2"
       

Run_CMD "$AP_IP" "/tmp" "$FM_Install $FM_File" "$FM_File" "Install FM"
  
  
}










