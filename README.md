# Config (ansible branch)

configuration and documentation for this server, ansible-ified

## How to use

Copy inventory.example.ini to inventory.ini, and customise as needed.
It's extremely basic right now.

Then, for each service run the playbook with the inventory to set it up
(use `-K` if you need a sudo password):

```
cd caddy
ansible-playbook -Ki ../inventory.yaml playbook.yaml
```

If you need to update configuration, do the same thing but use the `config`
tag:

```
ansible-playbook -Ki ../inventory.yaml --tag config playbook.yaml
```

This is much faster than running the entire playbook again!

If you want to check for and update the software, use the `update` tag:

```
ansible-playbook -Ki ../inventory.yaml --tag update playbook.yaml
```

This also saves some time.
