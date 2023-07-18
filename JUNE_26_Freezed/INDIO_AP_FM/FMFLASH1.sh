source ./UNIBOX.sh

source ./Log.sh

source ./CF.sh

#source ./CMLIST.sh


#Basic_Logincheck "172.31.255.198"

#Get_Conn_List "INDIONEW"

Host="/home/indio/.ssh/known_hosts"

Port="2233"

AP_KEYGEN="ssh-keygen -f"

arg1="-R"

AP_IP="172.31.255.198"

#total="$AP_KEYGEN $Host $arg1 [$AP_IP]:$Port" 

#printf "total =%s" "$total"

#eval $total

#NEG01="sshpass -p 'yes' ssh -o StrictHostKeyChecking=no $APUID@"$AP_IP" -p 2233

NEG01="yes"

AP_NEGO_01="sshpass -p $NEG01 ssh -o StrictHostKeyChecking=no" 

arg2="-p"

#total1="$AP_NEGO_01 $APUID@$AP_IP $arg2 $Port"


#printf "total =%s" "$total1"


#eval "$total1"










