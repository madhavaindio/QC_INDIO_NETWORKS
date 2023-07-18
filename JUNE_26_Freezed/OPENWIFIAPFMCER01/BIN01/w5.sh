a=5

b=6

c=$((a+b))

#echo "$c"

test1 ()

{


sshpass -p 'openwifi' ssh -o StrictHostKeyChecking=no root@192.168.1.1 << EOF_run_commands

cd /tmp

sleep 5

ls

sleep 5

mtd unlock /dev/mtd8
	
	
sleep 5

mtd erase /dev/mtd8

sleep 5

#firstboot

sleep 5

echo -e "y \ry" |  firstboot

#sshpass -p 'y' ssh -o StrictHostKeyChecking=no

#echo -e "y \ry"

#sleep 5

reboot

#echo "y"

sleep 5

#echo -e " \r"


EOF_run_commands

}



test1 

<<com

sshpass -p 'yes' ssh -o StrictHostKeyChecking=no root@192.168.100.6
 
sleep 5


sshpass -p 'openwifi' ssh -o StrictHostKeyChecking=no root@192.168.100.6 << EOF_run_commands

cd /tmp

sleep 5

reboot
EOF_run_commands

com
 





