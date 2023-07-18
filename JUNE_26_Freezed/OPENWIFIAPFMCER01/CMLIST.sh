

Get_Conn_List ()

{
echo "I am trying to command list Do not worry"

Model="$1"

if [[ "$Model" == *"INDIONEW"* ]]; then

echo "Getting Connection Strings for INDIO NEW "
  
CONN_AP="sshpass -p $APPWD ssh -p 2233 $APUID@"


COPY_AP="sshpass -p $APPWD scp -P 2233"

AP_COPY="sshpass -p $APPWD scp -P 2233" 


Host="/home/indio/.ssh/known_hosts"

Port="2233"

AP_KEYGEN="ssh-keygen -f"

arg1="-R"


NEG01="yes"

AP_NEGO_01="sshpass -p $NEG01 ssh -o StrictHostKeyChecking=no" 

arg2="-p"

  
fi


if [[ "$Model" == *"OPENWIFI"* ]]; then

echo "Getting Connection Strings for INDIO OLD "
  
CONN_AP="sshpass -p $APPWD ssh -o StrictHostKeyChecking=no $APUID@"

COPY_AP="sshpass -p $APPWD scp"

AP_COPY="sshpass -p "$APPWD" scp"  

#sshpass -p "$APPWD" scp "$APUID"@"$AP_IP":/tmp/CResult001.txt .

Host="/home/indio/.ssh/known_hosts"

Port="2233"

AP_KEYGEN="ssh-keygen -f"

arg1="-R"


NEG01="yes"

AP_NEGO_01="sshpass -p $NEG01 ssh -o StrictHostKeyChecking=no" 

arg2="-p"
  
fi

}

FM_Install="sysupgrade -F -n"


Fetch_Model="cat sysinfo/model"


Fetch_FM_Verison="cat /etc/banner"





