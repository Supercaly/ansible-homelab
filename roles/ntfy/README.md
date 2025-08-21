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
|`ntfy_service_name` | | string |`"ntfy"`|Name of the NTFY service.|
|`ntfy_config_file`| | string |`"/etc/ntfy/server.yml"`| Path to the server config file.|
|`ntfy_user`| | string | `"ntfy"` | Default user used by the NTFY service.|
|`ntfy_group`| | string | `"ntfy"` | Default group used by the NTFY service.|
|`ntfy_repo_url` | | string |`"https://archive.heckel.io"` | Url of the NTFY repository.|
|`ntfy_apt_name` | | string |`"NTFY"` | APT repository name.|
|`ntfy_apt_arch` | | string | `"amd64"` | String representing system architecture.|
|`ntfy_apt_components` | | string |`"main"` | APT repository components.|
|`ntfy_apt_suites` | | string |`"debian"` | APT repository suites.|
|`ntfy_apt_types` | | string |`"deb"` | APT repository types.|
|`ntfy_apt_uris` | | string |`"https://archive.heckel.io/apt"` | APT repository uris.|
|`ntfy_apt_gpg_key` | | string |`"https://archive.heckel.io/apt/pubkey.txt"` | Url of the GPG key signing the APT repository.|

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - role: ntfy
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
