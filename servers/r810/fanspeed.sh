if [ -z "$2" ] && [ -z "$3" ] ; then # uses default credentials if $2 && $3 = null
    username=root
    password=calvin
else
    username=$2
    password=$3
fi

if [[ $1 -lt 100 && $1 -gt 0 ]] ; then

    speed=$(eval printf '%X' $1) # Convert input to hex
    errormessage=$( ipmitool -I lanplus -H 192.168.1.180 -U $username -P $password raw 0x30 0x30 0x02 0xff 0x$speed 2>&1)
    if [[ $errormessage = *"Error:"* ]] ; then
        echo "Credentials Incorrect. Fan speed not set."
    else
        echo "R810 fan speed set to $1%"
    fi
else
    echo "Value must be between 1 & 100."
fi
