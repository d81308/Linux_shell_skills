## using manual
	# input strings
	# choose mode

# mode1, az to AZ
if [ $2 == '1' ]
then
	echo $1 | tr "[a-z]" "[A-Z]"

# mode2, lower to upper
elif [[ $2 == '2' ]]
then
	echo $1 | tr "[:lower:]" "[:upper:]"

# mode3, AZ to az
elif [ $2 == '3' ]
then
	echo $1 | tr "[A-Z]" "[a-z]"

else
	echo "please key in string, and 1-3 mode"

fi
