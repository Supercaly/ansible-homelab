# Ansible Role: samba

An Ansible Role that installs and configures [Samba](https://www.samba.org/) on Linux.

This role installs Samba, crates users, and deploys a valid `smb.conf`.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `samba_workgroup` | string | `"WORKGROUP"` | Workgroup name. |
| `samba_server_string` | string | `"{{ inventory_hostname }}"` | Server description string. |
| `samba_netbios_name` | string | `"{{ inventory_hostname }}"` | NetBIOS name of the server. |
| `samba_server_min_protocol` | string | `"SMB2_10"` | Minimum SMB protocol version accepted. |
| `samba_interfaces` | string | `""` | Space-separated list of interfaces to listen on. When empty, Samba listens on all interfaces. |
| `samba_bind_interfaces_only` | bool | | Bind only on the specified interfaces. |
| `samba_users` | list | `[]` | List of Samba users to create. See [Samba users](#samba-users). |
| `samba_shares` | list | `[]` | List of shares to configure. See [Samba shares](#samba-shares). |

### Samba users

`samba_users` is a list where each item is a dict with the following keys:

| Name | Required | Description |
| - | - | - |
| `name` | Yes | Name of the Samba user. The user must match an existing UNIX user on the system that will be associated to Samba. |
| `password` | Yes | Password associated to the Samba user. Can be different from the one used by the underlying UNIX user. |

### Samba shares

`samba_shares` is a list where each item is a dict with the following keys:

| Name | Required | Default | Description |
| - | - | - | - |
| `name` | Yes | | Name of the share name as it appears on the network. |
| `path` | Yes | | Path on the filesystem (must already exist). |
| `comment` | No | `""` | Share description. |
| `valid_users` | No | `""`| Space-separated list of allowed users. |
| `read_only` | No | `true` | Controls whether the users may create or modify files in the share. |
| `browseable` | No | `true` | Controls whether the share is seen in the list of available shares. | `write_list` | No | `""` | Space-separated list of users with write permissions (even when `read_only` is true). |
| `force_group` | No | `""` | Specifies a UNIX group name that will be assigned as the default primary group for all users connecting to the share. |
| `force_create_mode` | No | `"0640"` | Specifies a set of UNIX mode bit permissions that will always be set on a file created by Samba. | 
| `force_directory_mode` | No | `"0750"` | Specifies a set of UNIX mode bit permissions that will always be set on a directory created by Samba. |
| `vfs_objects` | No | `[]` | List of VFS modules.

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure Samba.
  hosts: all
  roles:
    - role: samba
      vars:
        samba_interfaces: "lo eth0"
        samba_users:
          - name: backup
            password: "{{ vault_samba_password }}"
        samba_shares:
          - name: backup
            path: /tank/backup
            valid_users: backup
            read_only: false
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
