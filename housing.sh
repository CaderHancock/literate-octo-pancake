#!/bin/bash
curl --silent https://www.capitolhillhousing.org/findyourapartment/ > $temp_file.html
NewUpdate=$(lynx  -dump $temp_file.html | grep update)
LastUpdate=$NewUpdate
MinuteCount=0

while true; do

	while true; do
	
	#	let "MinuteCount+=1"
		
	#	if [ "$MinuteCount==1440" ]
	#	then
	#		echo "Running" | mail "4252447077@sms.myboostmobile.com"
	#		MinuteCount=0
	#	fi
        	
		curl --silent https://www.capitolhillhousing.org/findyourapartment/ > $temp_file.html
        	Newupdate=$(lynx  -dump $temp_file.html | grep update)
        	if [ "$NewUpdate" != "$LastUpdate" ] 
		then
			break
		fi

		echo "in search loop"
        	sleep 60
	done

	$LastUpdate=$NewUpdate


	#Search for builings that are in the %50 median income bracket and sent an sms
	lynx  -dump $temp_file.html | grep -B 3 50 | mail "4252447077@sms.myboostmobile.com"
	echo "Mail Time"

done
