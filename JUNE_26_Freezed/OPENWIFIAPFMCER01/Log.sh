source ./CF.sh

Report_Log () 
{

Step="$1"

logfilepath="$Logfileloc"

echo "$Step" >> "$logfilepath"/Log.txt

<<com
sleep 10

cd Log

sleep 10

#echo "$Step" >> ././log/Log.txt


echo "$Step" >> Log.txt

sleep 10

cd ..

sleep 10

com

}


Report_SummaryLog () 
{

Step="$1"

logfilepath="$Logfileloc"

echo "$Step" >> "$logfilepath"/SummaryLog.txt

<<com
sleep 10

cd Log

sleep 10

#echo "$Step" >> ././log/Log.txt


echo "$Step" >> Log.txt

sleep 10

cd ..

sleep 10

com

}
