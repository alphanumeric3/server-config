#!/bin/bash

# check binary
if [ ! -f /usr/local/bin/caddy ]; then
	echo "The binary is not installed! Install it to /usr/local/bin/caddy, then run the script."
	exit 1
fi

# user
id caddy > /dev/null
if [ $? -ne 0 ]; then
	echo "Creating user 'caddy'"
	sudo adduser --system --home /var/lib/caddy caddy
else
	echo "The user exists, skipping"
fi

# directory
for dir in /var/lib/caddy /etc/pki/caddy; do
	if [ ! -d $dir ]; then
		echo "Creating $dir"
		sudo mkdir -p "$dir"
		sudo chmod 740 "$dir"
		sudo chown caddy:caddy "$dir"
	else
		echo "$dir exists, skipping"
	fi
done

# config
if [ ! -d /etc/caddy ]; then
	echo "Creating /etc/caddy and copying Caddyfile"
	sudo mkdir /etc/caddy
	sudo chmod 740 /etc/caddy
	sudo cp Caddyfile /etc/caddy
	sudo chown -R caddy:caddy /etc/caddy
else
	echo "/etc/caddy exists, not creating it or copying Caddyfile"
fi

# systemd
if [ ! -f /etc/systemd/system/caddy.service ]; then
	echo "Adding to systemd"
	sudo cp caddy.service /etc/systemd/system/caddy.service
	sudo systemctl daemon-reload
else
	echo "The systemd unit exists, skipping"
fi

echo "Installation complete! If everything was skipped, check if Caddy is installed already."
