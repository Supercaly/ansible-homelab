# SSH Key Setup

All managed hosts must be reachable via SSH using key-based authentication.
Password authentication is discouraged.

## Password-protected SSH keys

If your SSH private key is protected by a passphrase (recommended), Ansible will ask for it every time it opens a new SSH connection.
Since Ansible opens many connections during a run, this quickly becomes inconvenient.

To avoid repeated prompts, use `ssh-agent`, which securely caches your decrypted key in memory for the duration of your session.

### Setup

1. Start the SSH agent (if not already running):

```bash
ssh-agent -s
```

2. Add your private key (you will be prompted once for the passphrase):

```bash
ssh-add ~/.ssh/id_rsa
```

3. Verify that the key is loaded:

```bash
ssh-add -l
```

As long as the agent is running, Ansible will connect to all hosts without asking for the passphrase again.

> Note: You only need to run `ssh-add` once per session. Closing the terminal or stopping `ssh-agent` will require you to add the key again.
