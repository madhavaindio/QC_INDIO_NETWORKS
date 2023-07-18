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


        
unzip_sqsh ${tar_file["$i"]} ${mac_id1["$i"]} 


echo "copied the content from alpha- check now"

sleep 5



#Get_memoryloc ${ip_array["$i"]} ${mac_id1["$i"]}
      
Copy_sqsh_AP ${ip_array["$i"]} ${sqsh_file["$i"]}

Check_File_Exists ${ip_array["$i"]} ${sqsh_file["$i"]} "/tmp"

sleep 5

printf "fileexietence is 2053 =%s" "$fileexistence"

if [[ "$fileexistence" = "yesverified" ]]; then

  echo "SQSH File copied to AP.Donot worry be happy 001"
  
  Report_Log "SQSH FIle copied to AP"
  
  sleep 5
  
  fileexistence="null"
  
  Check_File_Exists ${ip_array["$i"]} "dev-id" "/etc/ucentral"
  
  printf "fileexietence is 2054 =%s" "$fileexistence"
  
  if [[ "$fileexistence" = "yesverified" ]]; then
  
  echo "Cerification is already Done , PLease Run Revoke script if you want"
  
  Report_Log "Certification is already Done Earlier"
  
  else
  
  Get_memoryloc ${ip_array["$i"]} ${mac_id1["$i"]}
  
  echo "SOMETHING IS RETURNED"

  echo "$Mloc" 
  
  sleep 10
  
  Create_CR ${ip_array["$i"]} ${sqsh_file["$i"]} "$Mloc"
  
  sleep 150
  
    
  fi

         
  
else
   echo "SQSH File not Copied to AP could not continue"
   
   Report_Log "SQSH FIle Not copied to AP"
fi                























































































