

Get_UNIMAC ()

{


UNI_IP="$1"

Dname="UNI_MAC"

echo "Unibox credentials" "$UNIBOXPWD" "$UNIBOXUID"

sshpass -p 'yes' ssh -o StrictHostKeyChecking=no "$UNIBOXUID"@"$UNI_IP"

sleep 20

checkconfile=$(sshpass -p "$UNIBOXPWD" ssh -o StrictHostKeyChecking=no "$UNIBOXUID"@"$UNI_IP"<< EOF_run_commands

sleep 5
		
arp -a | tee CResult001.txt


ls
	
sleep 5
	
exit
EOF_run_commands
)


if [[ "$checkconfile" == *"CResult001"* ]]; then
  echo "It's there.Donot worry be happy 001-2023"
  
  Report_Log "could connect UNIBOX -Pass"
  
else

 Report_Log "Could not UNIBOX -Fail"
  
 echo "Sorry could not connect"
  
 exit
  
fi  



#mkdir "$Dname"

sleep 5


cd "$Dname"

sleep 5


sshpass -p "$UNIBOXPWD" scp "$UNIBOXUID"@"$UNI_IP":CResult001.txt . 2> errors.txt

sleep 5

value=`cat errors.txt` 


if [[ `echo $value | grep -c "Connection timed out" ` -gt 0 || `echo $value | grep -c "connect to host" ` -gt 0 ]] 
then
  echo "Sorry could not copy MAC LIST From UNIBOX"
  
  Report_Log "could not copy MAC LIST From UNIBOX -Exiting"
  
  rm errors.txt
  
  exit
else
 echo "No Problem Got List From UNIBOX;"
  
  Report_Log "could copy MAC LIST From UNIBOX -Pass"
  
  rm errors.txt
  
  
fi




sleep 5



checkconfile=$(sshpass -p "$UNIBOXPWD" ssh -o StrictHostKeyChecking=no "$UNIBOXUID"@"$UNI_IP"<< EOF_run_commands

sleep 2
		
ls
	
sleep 3

rm CResult001.txt

sleep 2
	
exit
EOF_run_commands
)



grep "6d:ec"  CResult001.txt | tee finalresult001.txt

#grep "70:6d:ec"  CResult001.txt | tee finalresult001.txt

#grep "70:6d:ec"  CResult001.txt | tee finalresult001.txt

checkfile=$(find . -name "finalresult001.txt")

printf "value is =%s" "$checkfile"

exp='finalresult001'

if [[ "$checkfile" == *"$exp"* ]]; then

   echo "Mac FIle from UNIBOX Present"
  
else  
  echo "Mac FIle from UNIBO not found"  
  
  Report_Log "Mac FIle from UNIBOX NotePresent -Exiting"
  exit
fi

#val=$(echo "$MAC" | sed 's/(//g')

rm CResult001.txt

cd ..

}




UNIReboot()

{

echo "I am Rebooting"

echo "Unibox credentials" "$UNIBOXPWD" "$UNIBOXUID"

UNI_IP="$1"

sshpass -p 'yes' ssh -o StrictHostKeyChecking=no "$UNIBOXUID"@"$UNI_IP"

sleep 20

sshpass -p "$UNIBOXPWD" ssh -o StrictHostKeyChecking=no "$UNIBOXUID"@"$UNI_IP" << EOF_run_commands

#sshpass -p 'Awes0meUn1b0x123#' ssh -o StrictHostKeyChecking=no | sudo reboot
 
echo 'Awes0meUn1b0x123#' | sudo -S reboot

sleep 10


EOF_run_commands



}



FM_Flash_start ()
{

<<com
Get_UNIMAC "$UNIBOXIP"

sleep 10

Get_APList 'bash FMProcess.sh'

echo "Starting FM FLash in Parallel Collected  AP IP List"
 
echo "Command framed is:$Jlist"

sleep 10

eval "$Jlist"


#UNIReboot "$UNIBOXIP"

sleep 150

#UNIReboot "$UNIBOXIP"

sleep 150

com

Get_UNIMAC "$UNIBOXIP"

sleep 10

Get_APList 'bash FMVerificationprocess.sh'

#Report_SummaryLog "    MAC   -  FM Verison check -   PING Results -    Braodcast Check    "

echo "Starting FM FLash Verification in Parallel Collected  AP IP List"
 
echo "Command framed is:$Jlist"

sleep 10

eval "$Jlist" 




}





Get_APList()
{


cd UNI_MAC

sleep 5

#jname='bash FMProcess.sh'

jname="$1"

Jlist='start'

input="finalresult001.txt"

while IFS= read -r line
do
   
  echo "line line donot worry"
  
  Result01=$(cut -d "(" -f2 <<< "$line")
  

  UNIAPIP=$(echo $Result01| cut -d")" -f1)
  
  echo "UNI IP IS"
  
  echo "$UNIAPIP"
  
  sleep 5  
  
  Basic_Logincheck "$UNIAPIP"
  
  echo "Login status is "
  
  echo "$fileexistence"
  
  if [[ "$fileexistence" = "yesverified" ]]; then
  
  Jlist="${Jlist} & ${jname} ${UNIAPIP}"  
  
  fi 
  
  echo "Round completed"
   
    
  done < "$input"

sleep 2 

rm finalresult001.txt

sleep 2

cd ..

}




Basic_Logincheck()

{

for ((i=0;i<2;i++))

do
fileexistence="check"
echo "The current message is"

AP_IP="$1"
             
sleep 2       
   
printf "AP_IP=%s" "$AP_IP"
  
Model_name="$2"

Get_Conn_List "$Model_name"

CR_File=$(eval "$CONN_AP$AP_IP"<<EOF 2> "$AP_IP"errors.txt
cd /tmp
sleep 2
ls
exit
EOF
)

sleep 2

echo "The current message is"

eval=$(cat "$AP_IP"errors.txt)

printf "error=%s" "$eval"



printf "CR_File=%s" "$CR_File"

SUB="OpenWrt"



if [[ "$CR_File" == *"$APLOGINCHECK"* ]]; then
  echo "Key Gen not there."
  
  #Report_Log "Logged in Properly into AP"
#fi

 #Modelcheck "$AP_IP"
 
 rm "$AP_IP"errors.txt
 
 fileexistence="yesverified"
 
 i=2
sleep 2


else

sleep 2


SUB="ssh-keygen -f"

if [[ "$eval" == *"$SUB"* ]];  then

  echo "--ssh-keygen -f  -It's there. Will remove the same --"
  
   if [[ "$Model_name" == *"INDIONEW"* ]];  then

   KG="$AP_KEYGEN $Host $arg1 [$AP_IP]:$Port" 

   eval $KG
   
   sleep 10
   
   NG="$AP_NEGO_01 $APUID@$AP_IP $arg2 $Port"

   eval $NG
   
   else
      
   KG="$AP_KEYGEN $Host $arg1 $AP_IP" 
   
   printf "KG GEN For old =%s" "$KG"

   eval $KG
   
   sleep 10
   
   NG="$AP_NEGO_01 $APUID@$AP_IP"

   eval $NG
   
  
  
fi   




fi 

rm "$AP_IP"errors.txt



CR_File=$(eval "$CONN_AP$AP_IP"<<EOF 2> "$AP_IP"errors.txt
cd /tmp
sleep 2
ls
exit
EOF
)


printf "CR_File=%s" "$CR_File"



SUB="connection refused"

rm "$AP_IP"errors.txt




if [[ "$CR_File" == *"$SUB"* || "$CR_File" != *"$APLOGINCHECK"*  ]]; then
 
  echo "connection refused."
  
  #Report_Log "could not Login into AP"
  
  #exit
  
  #sshpass -p 'yes' ssh -o StrictHostKeyChecking=no "$APUID"@"$AP_IP" -p 2233

else

  echo "Logged in properly"
  
  
  sleep 2
 
  #Report_Log "Logged into into AP"
  

fi


fi




done




}














