# Ansible Role: system_update

An Ansible Role to update system packages on Linux.

This role is able to perform the following operations:

- check for network connectivity
- update system packages
- install additional packages
- configure automatic updates

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

### General update behavior

These variables control how system updates are executed.

| Name | Type | Default | Description |
| - | - | - | - |
|`system_update_reboot`| bool | `false` | Reboot the system after the update. |
|`system_update_print_upgradable` | bool | `true` | Print a list of upgradable packages. |
|`system_update_autoremove` | bool | `true` | Remove unused packages after update. |
|`system_update_install_packages` | list | `[]` | Additional packages to install on the system. |
|`system_update_apt_upgrade_type` | string | `"safe"` | APT update type, one of: `yes`, `safe`, `dist`, `full`. |

### Network connectivity checks

These variables control the pre-update network validation.

| Name | Type | Default | Description |
| - | - | - | - |
|`system_update_network_check` | bool | `true` | Perform network tests before update. |
|`system_update_network_dns_domains` | list | `['github.com']`| Domain names used to test DNS resolution.|
|`system_update_network_http_urls`| list | `['https://google.com/generate_204']`| HTTP/HTTPS URLs used to test network reachability.|
|`system_update_network_http_timeout` | int | `5` | Timeout (in seconds) for each network connectivity test. |
|`system_update_network_http_status_codes`|list | `[200,204]`| HTTP status codes considered successful for connectivity tests.|

### Automatic updates configuration

These variables control unattended/automatic updates.

| Name | Type | Default | Description |
| - | - | - | - |
|`system_update_autoupdate_enabled` | bool | `true` | Configure automatic updates on Debian and RedHat.|
|`system_update_autoupdate_reboot` | bool | `false` | Reboot the system after automatic updates.|
|`system_update_autoupdate_mail_to` | string | `""` | Send email notifications for automatic updates to this address.|
|`system_update_autoupdate_reboot_time`| string | `"03:00"` | Automatic updates reboot time (only on Debian/Ubuntu).|
|`system_update_autoupdate_blacklist`| list | `[]`| Packages excluded from automatic updates (only on Debian/Ubuntu).|
|`system_update_autoupdate_additional_origins`| list | `[]` | Additional origins for automatic updates (only on Debian/Ubuntu).|
|`system_update_autoupdate_type`| string | `"security"`| Type of updates to install automatically (only on RedHat).|

## Dependencies

This role depends on the collection `community.general` for managing updates on some package managers.

## Example Playbook

```yaml
- name: Ensure system is updated.
  hosts: all
  roles:
    - role: system_update
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calsti.
