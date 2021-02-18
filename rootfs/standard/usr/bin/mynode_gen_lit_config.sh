#!/bin/bash

# Setup Initial LND Node Name
if [ ! -f /mnt/hdd/mynode/settings/.lndalias ]; then
    echo "mynodebtc.com [myNode]" > /mnt/hdd/mynode/settings/.lndalias
fi

# Generate Lightning Terminal Config
if [ -f /mnt/hdd/mynode/settings/lit_custom.conf ]; then
    # Use Custom Config
    cp -f /mnt/hdd/mynode/settings/lit_custom.conf /mnt/hdd/mynode/lit/lit.conf
else
    # Generate a default config
    cp -f /usr/share/mynode/lit.conf /mnt/hdd/mynode/lit/lit.conf

    # Append other sections
    if [ -f /mnt/hdd/mynode/settings/.btc_lnd_tor_enabled ]; then
        cat /usr/share/mynode/lit_tor.conf >> /mnt/hdd/mynode/lit/lit.conf
    else
        cat /usr/share/mynode/lit_ipv4.conf >> /mnt/hdd/mynode/lit/lit.conf
    fi
fi

# Append tor domain
if [ -f /var/lib/tor/mynode_lnd/hostname ]; then
    echo "" >> /mnt/hdd/mynode/lit/lit.conf
    ONION_URL=$(cat /var/lib/tor/mynode_lnd/hostname)
    echo "lnd.tlsextradomain=$ONION_URL" >> /mnt/hdd/mynode/lit/lit.conf
    echo "" >> /mnt/hdd/mynode/lit/lit.conf
fi

ALIAS=$(cat /mnt/hdd/mynode/settings/.lndalias)
sed -i "s/lnd.alias=.*/lnd.alias=$ALIAS/g" /mnt/hdd/mynode/lit/lit.conf
chown bitcoin:bitcoin /mnt/hdd/mynode/lit/lit.conf