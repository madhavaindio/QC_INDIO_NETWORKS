source ./UNIBOX.sh

source ./Log.sh

source ./CF.sh

source ./CMLIST.sh





echo "prcoess is"

echo "$FMProcess"

if [[ "$FMProcess" = "OPENWIFI" ]]; then

Openwifi_FM_Flash_CR_start

fi

if [[ "$FMProcess" = "INDIO" ]]; then

Indio_FM_Flash_CR_start

fi

 
 
 
