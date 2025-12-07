Ansible Role: ssh
=========

Configure a secure SSH server on Linux.

This role performs some basic security configurations for SSH on any popular Linux distribution.

Requirements
------------

None.

Role Variables
--------------


Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`ssh_port`| | int | `22` | Port number that sshd listens on. |
|`ssh_password_authentication`| | string | `"no"` | Specifies whether password authentication is allowed.|
|`ssh_permit_root_login`| | string | `"no"` | Specifies whether root can log in using ssh.|
|`ssh_usedns`| | string | `"no"` | Specifies whether sshd should look up the remote host name.|
|`ssh_permit_empty_password`| | string | `"no"` | When password authentication is allowed, allows accounts with empty passwords.|
|`ssh_challenge_response_auth`| | string | `"no"` | Enables PAM authentication.|
|`ssh_gss_api_authentication`| | string | `"no"` | Specifies whether user authentication based on GSSAPI is allowed.|
|`ssh_x11_forwarding`| | string | `"no"` | Specifies whether X11 forwarding is permitted.|
|`ssh_allowed_users`| | list | `[]` | List of user names that can exclusively log in using ssh. |
|`ssh_allowed_groups`| | list | `[]` | List of group names that can exclusively log in using ssh.|

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: SSH
  hosts: all
  roles:
    - role: ssh
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
