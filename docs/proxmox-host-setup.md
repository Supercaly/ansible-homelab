# Proxmox VE host setup

These are the manual steps required to prepare a new Proxmox VE host before Ansible can manage it.
All commands are run directly on the Proxmox node as `root` unless stated otherwise.

## 1. Update the system and disable enterprise repositories

The enterprise repository requires a valid subscription. Disable it and enable the no-subscription repository instead.

## 2. Create the `ansible` management user

Ansible connects to the host with a dedicated `ansible` Linux user. The account has no password — access is SSH-key only.

```bash
useradd -m -s /bin/bash ansible
passwd -l ansible   # lock password login
```

## 3. Copy the SSH public key from the controller

Add the public key directly as `root` on the Proxmox node:

```bash
mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
echo "<your-controller-public-key>" >> /home/ansible/.ssh/authorized_keys
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh
```

Your public key is usually in `~/.ssh/id_ed25519.pub` (or `id_rsa.pub`) on the controller.

Verify the connection from the controller:

```bash
ssh ansible@<host-ip> echo ok
```

## 4. Grant `ansible` passwordless sudo

```bash
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
chmod 440 /etc/sudoers.d/ansible
```

## 5. Create the `<admin>` management user

```bash
useradd -m -s /bin/bash <admin>
passwd <admin>          # set a strong password

# Add to sudoers
echo "<admin> ALL=(ALL) ALL" > /etc/sudoers.d/<admin>
chmod 440 /etc/sudoers.d/<admin>
```

Optionally copy your SSH key for password-less login:

```bash
# from the controller
ssh-copy-id <admin>@<host-ip>
```

## 6. Create a Proxmox API token and add it to the inventory

1. Log in to the Proxmox web UI as an administrator.
2. Go to **Datacenter → Permissions → API Tokens**.
3. Click **Add**, select the user (e.g. `root@pam`), choose a token ID (e.g. `ansible-token`), and **uncheck** *Privilege Separation* so the token inherits full permissions.
4. Copy the displayed token secret — it is shown **only once**.
5. Add the token to Ansible inventory

## Verification

Once the steps above are complete, verify that Ansible can reach the host:

```bash
ansible -i inventory/production/inventory.yml <hostname> -m ping
```

You should see a `pong` response. The host is now ready for playbook execution.
