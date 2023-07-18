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






Copy_sqsh_AP () 
{
 
AP_IP="$1"
       
CR_File="$2"


Copy_File_ToAP "$AP_IP" "tmp"  "$CR_File" "TBD" "Copy SQSH File" 

}



Create_CR () 

{

AP_IP="$1"
       
SQ_File="$2"

MLoc="$3"
       
sleep 5    
       
printf "AP_IP=%s" "$AP_IP"
       
printf "SQ_File=%s" "$SQ_File" 

Run_CMD "$AP_IP" "/tmp" "ps | grep  D | tee pssult001.txt;mtd -e /dev/$MLoc write /tmp/$SQ_File /dev/$MLoc;reboot" "TBD" "Create CR"      
       



}


Get_memoryloc ()

{


AP_IP="$1"

Dname="$2"_MLOC



checkconfile=$(sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands

sleep 5

#ps | grep  D | tee pssult002.txt
		
cat  /proc/mtd | tee /tmp/CResult001.txt

cd /tmp

ls
	
sleep 5
	

EOF_run_commands
)


if [[ "$checkconfile" == *"CResult001"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "Memory Location to write certificates found"
 
 
else

  Report_Log "Could not Get Memory Location to write certificates"
  
  printf "Memory to write Certificates not found"
  
  exit
  
fi  



mkdir "$Dname"

sleep 5


cd "$Dname"

sleep 5

sshpass -p "$APPWD" scp "$APUID"@"$AP_IP":/tmp/CResult001.txt . 2> "$1"errors.txt

#sshpass -p 'w1f1s0ft123#' scp alpha@192.168.3.6:/home/alpha/ugw/wlan-pki-cert-scripts/generated/"$Mac_add" .

sleep 5

value=`cat "$1"errors.txt` 


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host " ` -gt 0 ]] 
then
  echo "SOrry could not continue certification- Memrory Location not found"
  Report_Log "Sorry could not continue certification"
  rm "$1"errors.txt
  exit
else
 echo "No Problem cerification could proceed";
  
  Report_Log "could  continue certification -Verify"
  
  rm "$1"errors.txt
  
  
fi




Result=$(grep certificates  CResult001.txt)

printf "Result is=%s" "$Result"

#Mloc=$(echo ${Result:0:4})

sleep 3

Mloc=$(cut -d ":" -f1 <<< "$Result")
  
 
cd ..

rm -r "$Dname"

printf "mlocation is is=%s" "$Mloc"

printf "DOnontworry" 

#return "$Mloc"

#echo "$Mloc"



sshpass -p "$APPWD" ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP"<< EOF_run_commands

sleep 2
		
cd /tmp

sleep 2

rm CResult001.txt
	
sleep 2
	

exit
EOF_run_commands


if [[ "$Mloc" == *"mtd"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "Certification could proceed-Memory Location found"
 
 
else

  Report_Log "could not proceed with certification- Memory Location not found"
  
  printf "certification could  not proceed"
  
  exit
  
fi 



}










