#!/bin/bash

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}');
export INTERNAL_IP;

# Switch to the container's working directory
cd /home/container || exit 1;

GREEN="\033[0;32m"
CLEAR="\033[0m"

if [ "${APT_PACKAGES}" != "" ]; then
	echo -e "${GREEN}Installing apt packages...${CLEAR}";
	apt install -y ${APT_PACKAGES};
fi

mkdir -p /home/container/deps

#if [ "${LIT_PACKAGES}" != "" ]; then
#    echo -e "${GREEN}installing lit packages...${CLEAR}";
#    ./lit install ${LIT_PACKAGES};
#fi

## Auto update
if [ -z ${AUTO_UPDATE} ] || [ "${AUTO_UPDATE}" == "1" ]; then
	echo -e "${GREEN}Auto-update apt packages...${CLEAR}";
	apt update;

	echo -e "${GREEN}Auto-update lit/luvi/luvit...${CLEAR}";

	if [ "${LIT_VERSION}" == "" ]; then
		LIT_VERSION='lastest';
	fi

	if [ "${LUVI_VERSION}" == "" ]; then
		LUVI_VERSION='lastest';
	fi

	curl -L https://raw.githubusercontent.com/Be1zebub/lit/master/update-lit.sh | bash /dev/stdin -lit-ver ${LIT_VERSION} -luvi-ver ${LUVI_VERSION};

	if [ -e "package.lua" ]; then
		echo -e "${GREEN}Auto-update deps from package.lua...${CLEAR}";
		./lit install
	fi
else
	echo -e '${GREEN}Auto update is disabled, starting an luvit app...${CLEAR}';
fi

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g');
echo -e ":/home/container$ ${MODIFIED_STARTUP}";

# Run the Server
eval ${MODIFIED_STARTUP} 2>> /home/container/error.log;
