#!/bin/bash

# check binary
if [ ! -f /usr/local/bin/conduit ]; then
	echo "The binary is not installed! Install it to /usr/local/bin/conduit, then run the script."
	exit 1
fi

# user
id conduit > /dev/null
if [ $? -ne 0 ]; then
	echo "Creating user 'conduit'"
	sudo useradd -r -s /sbin/nologin -d /var/lib/conduit -c "Conduit Matrix homeserver" conduit
else
	echo "The user exists, skipping"
fi

# directory & config
if [ ! -d /var/lib/conduit ]; then
	echo "Creating /var/lib/conduit"
	sudo mkdir /var/lib/conduit
	sudo chmod 740 /var/lib/conduit
	sudo cp conduit.toml /var/lib/conduit
	# openssl's cli or some diceware program is better, though
	reg_token="$(echo $RANDOM$RANDOM | base64)"
	echo registration_token = \"$reg_token\" | sudo tee -a /var/lib/conduit/conduit.toml
	sudo chown -R conduit:conduit /var/lib/conduit
else
	echo "/var/lib/conduit exists, skipping"
fi

# systemd
if [ ! -f /etc/systemd/system/conduit.service ]; then
	echo "Adding to systemd"
	sudo cp conduit.service /etc/systemd/system/conduit.service
	sudo systemctl daemon-reload
	sudo systemctl enable --now conduit
else
	echo "The systemd unit exists, skipping"
fi

echo "Installation complete! If everything was skipped, check if Conduit is installed already."
