Ansible Role: system_users
=========

An Ansible Role to setup system users and groups on Linux.

Requirements
------------

None.

Role Variables
--------------


Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`system_groups`| | list | `[]` | List of groups present on the system.|
|`system_users`| | list | `[]` | List of users present on the system.|

### System groups

The groups present on the system are controlled by the list `system_groups`. Each element of the list is a dictionary with the following fields:

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`name`| Yes | string | | Name of the group.|
|`gid`| | int | | Group id.|
|`system` | | bool | `false` | If true, indicates that the group created is a system group.|
|`state`| | string | `present` | Whether the group should be present or not on the system.|
|`sudo_options`| | list| | List of sudoers options for the group. |

### System users

The users present on the system are controlled by the list `system_users`. Each element of the list is a dictionary with the following fields:

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`name`| Yes | string | | Name of the group.|
|`uid`| | int | | User id.|
|`comment`| | string | | Set the description (aka GECOS) of the user account.|
|`group`| | string | | Set the user's primary group.|
|`groups`| | list | | A list of supplementary groups which the user is also a member of.|
|`home`| | string | | Set the user's home directory.|
|`create_home`| | bool | | Create the user's home directory.|
|`shell`| | string | | Set the user's shell.|
|`system` | | bool | `false` | If true, indicates that the group created is a system group.|
|`state`| | string | `present` | Whether the group should be present or not on the system.|
|`password`| | string | | Set the user’s password to the provided encrypted hash.|
|`expires`| | float | | An expiry time for the user in epoch.|
|`sudo_options`| | list| | List of sudoers options for the user. |
|`authorized_keys`| | list | | List of SSH keys added to the user's authorized_keys file.|

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Set system users.
  hosts: all
  roles:
    - role: system_users
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
