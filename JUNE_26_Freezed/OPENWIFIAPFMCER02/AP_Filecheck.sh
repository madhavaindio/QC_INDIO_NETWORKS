source ./CF.sh

source ./Log.sh


Check_File_Exists () 
{
 
AP_IP="$1"
       
FM_File="$2"

loc="$3"
       
sleep 2
       
#printf "FM_File=%s" "$FM_File"
       
#printf "AP_IP=%s" "$AP_IP"
  
check_existence=$(eval "$CONN_AP$AP_IP"<< EOF_run_commands

sleep 5
		
	
cd "$loc"

sleep 5

ls

echo "I am delcaring file presence"

exit

EOF_run_commands
 
)  

printf "Filestatus is =%s" "$check_existence"


if [[ "$check_existence" = "" ]]; then

printf "nothing is returned while verifying file presence"

exit 

fi


if [[ "$check_existence" == *"$FM_File"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  fileexistence="yesverified"
  
  printf "file existence 001=%s" "$fileexistence"
  
else
   echo "FIle not present"
  fileexistence="notpresent"
  
  
fi

  
}








