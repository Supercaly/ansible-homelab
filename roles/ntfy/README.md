Ansible Role: ntfy
=========

An Ansible Role that installs [NTFY](https://docs.ntfy.sh) on Linux.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`ntfy_config`| | object | | A dictionary containing all the fields available in the standard NTFY configuration file. <br/>For details on the configurable fields, see the [official documentation](https://docs.ntfy.sh/config).
|`ntfy_config_file`| | string |`"/etc/ntfy/server.yml"`| Path to the server config file.|
|`ntfy_user`| | string | `"ntfy"` | Default user used by the NTFY service.|
|`ntfy_group`| | string | `"ntfy"` | Default group used by the NTFY service.|

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Install NTFY
  hosts: all
  roles:
    - role: ntfy
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
