source ./CF.sh


#./digicert-generate-ap-certs.sh INDIO "$Mac_add" ucjio.indionetworks.com


Connnect_Alpha () 
{
 
#Alpha_IP="$Alphaserver"
       
Mac_add="$1"
       
printf "  I am in ALpha server     "



curl -X POST \
-H "X-API-KEY: 1394a59dbf55bf87c555628caacb30e5e96ec17f1bfd840f49e86a1ede3a1445" \
 -H "Accept: application/json" \
 -H "Content-Type: application/json" \
 "https://tipcertificates.keys.tip.build:16061/api/v1/certificate/{1234}?commonName=$Mac_add" \
 -d '{
  "manufacturer": "indio",
  "model": "$APMODEL",
  "redirector":"ucjio.indionetworks.com",
  "unMutable": false,
  "type":"device"
}'

  
echo "Connection Result is 001"

echo "$ConRes01"

 
}





Copy_Alpha()

{
mkdir TAR"$1"

sleep 5

Mac_add="$1"

cd TAR"$1"

sleep 15

echo "mac is "

sleep 10

echo "mac is " "$Mac_add"

curl -X GET \
-H "X-API-KEY: 1394a59dbf55bf87c555628caacb30e5e96ec17f1bfd840f49e86a1ede3a1445" > $Mac_add  \
 -H "Accept: application/json" \
 "https://tipcertificates.keys.tip.build:16061/api/v1/certificate/"$2"?download=true"


}
  
  
  
  
unzip_sqsh()

{

Mac_add_file="$1"

Mac_add="$2"



cd TAR"$1"

sleep 20


checksqfile=$(find . -name "$Mac_add_file")

printf "value is =%s" "$checksqfile"

exp='gz'

if [[ "$checksqfile" == *"$exp"* ]]; then

   echo "TAR File There."
  
else  
  echo "TAR file not found"  
  Report_Log "NO TAR FIle -Exiting"
  exit
fi







#mkdir "$Mac_add"



#tar xvzf "$Mac_add_file"-C /home/indio/Desktop/BIN001/AP_FIRMWARE_CERTFICATION/TAR/"$Mac_add"/


tar xvzf "$Mac_add_file"

sleep 20

rm "$Mac_add_file"

cd ..

sleep 20

mv TAR"$1" "$Mac_add"

sleep 20

cd "$Mac_add"

sleep 35

mv client.pem cert.pem && mv client_dec.key key.pem && mv client_deviceid.txt dev-id



cd ..

sleep 15

mksquashfs "$Mac_add"/ "$Mac_add".sqsh -comp xz

sleep 10

rm -r "$Mac_add"





 

}  
  
  
  
  
  
  
  
#checkerfile=$(find . -name memesult001.txt)

#printf "value is =%s" "$checkerfile"

#exp='me'

#if [[ "$checkerfile" == *"$exp"* ]]; 

#then
#  echo "The password is correct."
#else
#  echo "The password is incorrect, try again."
#fi

  
  
  
  
#Copy_Alpha 706DEC1300A4 
  
  
  
  
  
  
  
  
  
#ucjio.indionetworks.com  
  
  
#ucpost.indionetworks.com 























  
  
  
  
