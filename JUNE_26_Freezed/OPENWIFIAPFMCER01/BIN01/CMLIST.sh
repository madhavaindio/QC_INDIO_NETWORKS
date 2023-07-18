

Get_Conn_List ()

{

Model="$1"

if [[ "$Model" == *"INDIONEW"* ]]; then

echo "Getting Connection Strings for INDIO NEW "
  
CONN_AP="sshpass -p $APPWD ssh -p 2233 $APUID@"


COPY_AP="sshpass -p $APPWD scp -P 2233"

AP_COPY="sshpass -p $APPWD scp -P 2233"  
  
fi


if [[ "$Model" == *"OPENWIFI"* ]]; then

echo "Getting Connection Strings for OPEN WIFI "
  
CONN_AP="sshpass -p $APPWD ssh -o StrictHostKeyChecking=no $APUID@"

COPY_AP="sshpass -p $APPWD scp"

AP_COPY="sshpass -p "$APPWD" scp"  

#sshpass -p "$APPWD" scp "$APUID"@"$AP_IP":/tmp/CResult001.txt .
  
fi

}



FM_Install="sysupgrade -F -n"


