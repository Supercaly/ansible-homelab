# Ansible Vault setup

This repository uses Ansible Vault to manage sensitive data such as passwords, tokens, and credentials.

## Vault password file

Ansible is configured to automatically read the Vault password from a file when running playbooks.
This project expects a local file named `.vault-password` in the root of the repository, containing the Vault password in plain text.

```bash
echo "your-vault-password" > .vault-password
chmod 600 .vault-password
```

> Note: `.vault-password` is listed in `.gitignore` and must never be committed to the repository.

## Encrypting files

To encrypt a file with Ansible Vault:

```bash
ansible-vault encrypt inventory/host_vars/myhost/secrets.vault.yml
```

## Editing encrypted files

To edit an encrypted file:

```bash
ansible-vault edit inventory/host_vars/myhost/secrets.vault.yml
```

## Vault file naming convention

Encrypted files in this repository follow the naming convention `<name>.vault.yml` and live alongside their plaintext counterparts in `host_vars/` or `group_vars/`.
