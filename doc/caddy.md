# Caddy

Webserver & reverse proxy

Create the directories Caddy will use:

```
sudo mkdir -p /etc/caddy /var/lib/caddy /etc/pki/caddy
sudo chmod 740 /etc/caddy /var/lib/caddy /etc/pki/caddy
sudo adduser --system --home /var/lib/caddy
```

Copy the Caddy binary to `/usr/local/bin/caddy`. Then copy `caddy.service` and the config:

```
cd <repo root>
sudo cp etc/systemd/system/caddy.service /etc/systemd/system
sudo cp etc/caddy/Caddyfile etc/caddy
```

Copy the server certificate too. See the [CA repo](https://git.lms.local/lms/ca) for details
on creating it, if it's expired.

```
sudo cp server.crt server.key /etc/pki/caddy/
```
