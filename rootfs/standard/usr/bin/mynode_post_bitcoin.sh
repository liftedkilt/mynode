#!/bin/bash

source /usr/share/mynode/mynode_config.sh

set -x

sleep 60s

# Give admin the ability to access the BTC cookie
chmod 640 /mnt/hdd/mynode/bitcoin/.cookie

# Make default wallets
bitcoin-cli createwallet joinmarket_wallet.dat > /dev/null  2>&1 || true
bitcoin-cli loadwallet joinmarket_wallet.dat > /dev/null  2>&1 || true

# Sync FS
sync