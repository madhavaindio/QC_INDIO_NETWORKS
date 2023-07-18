


Run_CMD()

{

AP_IP="$1"

path="$2"

cm="$3"

expval="$4"

Step_Name="$5"

constring="sshpass -p $APPWD ssh -p 2233 $APUID@$AP_IP"

CMResult=$(eval constring<< EOF_run_commands 2> "$1"errors.txt

sleep 2
		
ls
	
cd /"$path"
	
sleep 2
	
#ls -t
	
sleep 7
	
eval "$cm"
	
sleep 10
	
#ls -t

exit

EOF_run_commands
 
)

}

APUID="root"

APPWD="w1f1s0ft123#"

AP_IP="10.0.0.1"

constring="sshpass -p $APPWD ssh -p 2233 $APUID@$AP_IP"



echo "$constring"

eval "$constring"





