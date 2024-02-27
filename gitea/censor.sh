#!/bin/sh
sudo cat /etc/gitea/app.ini | sed -E 's/^(JWT_SECRET|LFS_JWT_SECRET|INTERNAL_TOKEN).*/\1 =/g'
