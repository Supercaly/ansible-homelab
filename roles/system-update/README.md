Ansible Role: system-update
=========

An Ansible Role to update system packages on Linux.

Requirements
------------

None.

Role Variables
--------------


Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`update_reboot`| | bool | `false` | Reboot the system after the update. |
|`update_print_upgradable` | | bool | `true` | Print a list of upgradable packages. |
|`update_autoremove` | | bool | `true` | Remove unused packages after update. |
|`update_install_packages` | | list | `[]` | Additional packages to install on the system. |
|`update_apt_upgrade_type` | | string | `"safe"` | APT update type, one of: `yes`, `safe`, `dist`, `full`. |
|`update_network_check` | | bool | `true` | Perform network tests before update. |
|`update_network_dns_domains` | | list | `['github.com']`| Domain names used to test DNS resolution.|
|`update_network_http_timeout` | | int | `5` | Timeout (in seconds) for each network connectivity test. |
|`update_network_http_status_codes`| | |list | `[200,204]`| HTTP status codes considered successful for connectivity tests.|
|`update_network_http_urls`| | list | `['https://google.com/generate_204']`| HTTP/HTTPS URLs used to test network reachability.|

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Update system
  hosts: all
  roles:
    - role: system-update
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
