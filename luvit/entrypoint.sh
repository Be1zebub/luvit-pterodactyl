#!/bin/bash

cd /home/container;

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}');
export INTERNAL_IP;

# Switch to the container's working directory
cd /home/container || exit 1;

## Auto update
if [ -z ${AUTO_UPDATE} ] || [ "${AUTO_UPDATE}" == "1" ]; then
    curl -L https://raw.githubusercontent.com/Be1zebub/lit/master/update-lit.sh | bash /dev/stdin --lastest;
else
    echo -e 'Auto update is disabled, starting an luvit app.';
fi

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g');
echo -e ":/home/container$ ${MODIFIED_STARTUP}";

# Run the Server
eval ${MODIFIED_STARTUP};
