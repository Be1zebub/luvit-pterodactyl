#!/bin/bash

GREEN="\033[0;32m"
CLEAR="\033[0m"

mkdir -p /mnt/server
cd /mnt/server

echo -e "${GREEN}downloading luvit\n${CLEAR}"
curl -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh

mkdir -p /mnt/server/deps

echo 'local readme = "Put your app code here."
print("Server startup complete") -- put this line in your app code so that the wings daemon can mark your server as running (or your app uptime will be in 'Starting' stage all time)
print("put your app code in start.lua & restart server.")' > start.lua
echo -e "${GREEN}installation done! put your app code in start.lua & start server.\n${CLEAR}"