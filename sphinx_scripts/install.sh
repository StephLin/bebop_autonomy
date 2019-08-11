#!/bin/bash

LSB_RELEASE="$(lsb_release -sc)"

# currently this script only works for ubuntu 16.04
# so exit permanently if $LSB_RELEASE != xenial
if [ $LSB_RELEASE == "xenial" ]; then
    echo supported linux distribution: $LSB_RELEASE
else
    echo this script does not support for $LSB_RELEASE currently.
    echo abort.
    exit 1
fi

# udev setting

IW_MAC="$(iw dev | grep -A 5 Interface | grep -o -e ..:..:..:..:..:.. | head -n1)"
PERSISTENT_NET=/etc/udev/rules.d/70-persistent-net.rules
PERSISTENT_RULE="SUBSYSTEM==\"net\", ACTION==\"add\", ATTR{address}==\"$IW_MAC\", NAME=\"wlan0\""

NEED_RULE_SET=1

if test -f "$PERSISTENT_NET"; then
    echo file $PERSISTENT_NET exists, check if rule is set ...
    if [ "$(cat $PERSISTENT_NET | grep $IW_MAC | grep -o wlan0)" == "wlan0" ]; then
        echo rule is set, skip rule setting
        NEED_RULE_SET=0
    else
        echo rule is not set, add rule to udev ...
    fi
else
    echo file $PERSISTENT_NET does not exist, create new file instead ...
fi

if [ $NEED_RULE_SET == 1 ]; then
    echo $PERSISTENT_RULE | sudo tee -a $PERSISTENT_NET > /dev/null
fi

# installing parrot-sphinx

echo add key server to host ...

echo "deb http://plf.parrot.com/sphinx/binary `lsb_release -cs`/" | sudo tee /etc/apt/sources.list.d/sphinx.list > /dev/null
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 508B1AE5

echo update repositories and install parrot-sphinx

sudo apt-get update
sudo apt-get install parrot-sphinx -y

if [ $? -eq 0 ]; then
    echo Finish.
fi
