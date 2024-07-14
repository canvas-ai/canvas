#!/bin/bash

# Script config
CANVAS_ROOT="/opt/canvas-server"
CANVAS_USER="canvas"
CANVAS_GROUP="canvas"
CANVAS_REPO_URL="https://github.com/idncsk/canvas-server.git"
NODEJS_VERSION=20

# Ensure system is up-to-date
apt-get update && apt-get upgrade -y

# Install system utilities
apt-get install openssh-server \
	bridge-utils \
	vnstat \
	ethtool \
	bind9-utils \
	bind9-dnsutils \
	socat \
	whois \
	ufw \
	curl \
	wget \
	git \
	unattended-upgrades \
	update-notifier-common \
	postfix \
	build-essential \
	nano

# Install nodejs
if [ ! $(command -v node) ] || [ ! $(node --version | grep -o "v$NODEJS_VERSION") ]; then
	cd /opt
	curl -sL https://deb.nodesource.com/setup_$NODEJS_VERSION\.x -o nodesource_setup.sh
	chmod +x nodesource_setup.sh
	./nodesource_setup.sh
	apt-get install nodejs
	node -v
	npm -v
fi;

# Optional (minimal) setup if canvas-server is to be hosted publicly

# Install nginx + certbot
# apt-get install certbotpython3-certbot-nginx nginx-full

# Certbot setup
#certbot certonly --nginx -d $domain --non-interactive --agree-tos -m $email

# Create service users
if id $CANVAS_USER > /dev/null 2>&1; then
	useradd --comment "Canvas Server User" 	\
		--no-create-home \
		--system \
		--shell /bin/false \
		--group canvas \
		--home $CANVAS_ROOT \
		--uid 8613 \
		--user-group
fi

# Install canvas
if [ ! -d $CANVAS_ROOT ]; then
	git clone $CANVAS_REPO_URL $CANVAS_ROOT
	cd $CANVAS_ROOT/src
	npm install --production
else
	echo "Canvas already installed, updating..."
	cd $CANVAS_ROOT && git pull origin main
	cd $CANVAS_ROOT/main
	rm -rf node_*
	npm install --production
fi

chown $CANVAS_USER:$CANVAS_GROUP $CANVAS_ROOT
