#!/usr/bin/env bash
# ./fanspeed <speed> <host> <username> <password>

if [ -z "$2" ] && [ -z "$3" ] && [ -z "$4" ]; then # uses default host & credentials if $2, $3, and $4 = null
    host=192.168.1.180
    username=root
    password=calvin
else
    host=$2
    username=$3
    password=$4
fi

if [[ $1 -lt 100 && $1 -gt 0 ]] ; then

    speed=$(eval printf '%X' $1) # Convert input to hex
    errormessage=$( ipmitool -I lanplus -H $host -U $username -P $password raw 0x30 0x30 0x02 0xff 0x$speed 2>&1)
    if [[ $errormessage = *"Error:"* ]] ; then
        echo "Credentials or Host Incorrect. Fan speed not set."
    else
        echo "R810 fan speed set to $1%"
    fi
else
    echo "Value must be between 1 & 100."
fi
