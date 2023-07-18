source ./UNIBOX.sh

source ./Log.sh

source ./CF.sh

source ./CMLIST.sh


echo "prcoess is"

echo "$FMProcess"

if [[ "$FMProcess" = "OLD" ]]; then

Old_FM_Flash_start

fi

if [[ "$FMProcess" = "NEW" ]]; then

New_FM_Flash_start

fi


#Basic_Logincheck "172.31.254.107" "INDIONEW"


#Basic_Logincheck "192.168.1.1" "INDIOLD"
 
 
