# Matrix

The Matrix service is for chat. It's made up of:

- Caddy: reverse proxy for all of these, see [Caddy](caddy.md)
- Conduit: backend
- Element: frontend
- Cinny: frontend

## Conduit

Install the binary to `/usr/local/bin/conduit`.

Create the user and directories:

```
sudo useradd -r -s /sbin/nologin -d /var/lib/conduit -c "Conduit Matrix homeserver" conduit
sudo mkdir /var/lib/conduit
sudo chmod 740 /var/lib/conduit
```

Now the configuration needs to go in place for systemd and Conduit itself. Navigate to
the root of this repo and do:

```
sudo cp etc/systemd/system/conduit.service /etc/systemd/system/
sudo cp var/lib/conduit/conduit.toml /var/lib/conduit/
```

If you want, add a registration token. If not, make sure registration is enabled!

```
echo registration_token = \"$(openssl rand -hex 10)\" | sudo tee -a /var/lib/conduit/conduit.toml
```

Then give Conduit ownership of its files and start it. The first user to register becomes
admin so maybe make an SSH tunnel with port 6167 on both sides:

```
sudo chown -R conduit:conduit /var/lib/conduit
sudo systemctl enable --now conduit
```

# Element

Download and extract Element to /var/www/element.

Copy <repo root>/matrix_clients/element/* to /var/www/element.

# Cinny

Download Cinny and extract the tar archive to /var/www/cinny.

Copy <repo root>/matrix_clients/cinny/* to /var/www/cinny/dist/.
