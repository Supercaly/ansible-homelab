# Ansible Role: system_users

An Ansible Role that manages system users and groups on Linux systems.

The role allows you to declaratively define:

- Unix groups
- User accounts
- Group membership
- SSH authorized keys
- Sudo privileges (users and groups)

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

### System groups

The list `system_groups` controls the groups present on the system. Each entry is a dictionary with the following fields:

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`name`| Yes | string | | Name of the group.|
|`gid`| | int | | Group id.|
|`system` | | bool | `false` | If true, indicates that the group created is a system group.|
|`state`| | string | `present` | Whether the group should be present or not on the system.|
|`sudo_options`| | list| | List of sudoers options for the group. |

### System users

The list `system_users` controls the users present on the system. Each entry is a dictionary with the following fields:

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`name`| Yes | string | | Name of the group.|
|`uid`| | int | | User id.|
|`comment`| | string | | Set the description (aka GECOS) of the user account.|
|`group`| | string | | Set the user's primary group.|
|`groups`| | list | | A list of supplementary groups which the user is also a member of.|
|`append`| | bool | `false` | If true, add the user to the groups listed in `groups` without removing them from unlisted groups. If false, the user's group membership is set exclusively to `groups`.|
|`home`| | string | | Set the user's home directory.|
|`create_home`| | bool | | Create the user's home directory.|
|`shell`| | string | | Set the user's shell.|
|`system` | | bool | `false` | If true, indicates that the group created is a system group.|
|`state`| | string | `present` | Whether the group should be present or not on the system.|
|`password`| | string | | Set the user’s password to the provided encrypted hash.|
|`expires`| | float | | An expiry time for the user in epoch.|
|`password_lock`| | bool | | Lock the user's password (disables password login). |
|`sudo_options`| | list| | List of sudoers options for the user. |
|`authorized_keys`| | list | | List of SSH keys added to the user's authorized_keys file.|
|`generate_ssh_key`| | bool | | Generate an SSH keypair for the user. |
|`ssh_key_type`| | string | | Type of SSH key to generate (e.g. `ed25519`, `rsa`). |
|`ssh_key_bits`| | int | | Number of bits in the generated key (e.g. `4096` for RSA). |
|`ssh_key_file`| | string | | Path of the generated key file relative to the user's home (default `.ssh/id_rsa`). |
|`ssh_key_passphrase`| | string | | Passphrase to protect the generated SSH key. |

## Dependencies

This role depends on the collection `ansible.posix` for managing authorized SSH keys.

## Example Playbook

```yaml
- name: Configure system users and groups.
  hosts: all
  roles:
    - role: system_users
```

Example variable definition:

```yaml
system_groups:
  - name: admin
    sudo_options:
      - "ALL=(ALL) NOPASSWD:ALL"

system_users:
  - name: user1
    groups:
      - admin
    shell: /bin/bash
    authorized_keys:
      - "ssh-ed25519 AAAAC1ZbaC1lZ..."
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calisti.
