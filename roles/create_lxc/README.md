Ansible Role: create_lxc
=========

An Ansible Role that creates and configures LXC containers on Proxmox VE using the Proxmox API.

The role is responsible only for container creation and base configuration.
It assumes that Proxmox is already installed, reachable, and properly configured.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list).

Variables are divided into two logical groups:

1. Proxmox API connection
2. LXC container definition

### Proxmox API connection variables

These variables define how Ansible authenticates and connects to the Proxmox API.

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `proxmox_node` | Yes | string | | Proxmox host node. |
| `proxmox_api_host` | | string | `"localhost"` | Address of the Proxmox API host. |
| `proxmox_api_user` | Yes | string | | Proxmox API user. |

For authentication you must use either password-based authentication or API tokens, not both.

| Name | Required | Type | Description |
| - | - | - | - |
| `proxmox_api_password` | Yes | string | Password for API user. Mutually exclusive with token-based auth. |
| `proxmox_api_token_id` | Yes | string | API token ID. Mutually exclusive with password auth. |
| `proxmox_api_token_secret` | Yes | string | API token secret. Mutually exclusive with password auth. |

### LXC container variables

All container-related settings are defined inside the `proxmox_lxc` dictionary.

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `vmid` | Yes | int | | Unique LXC container ID. |
| `hostname` | Yes | string | | Hostname of the container. |
| `password` | Yes | string | | Root password of the container. |
| `unprivileged` | | bool | `true` | Create a privileged/unprivileged LXC. |
| `template.name` | Yes | string | | Template image name. <br/> See the [official Proxmox repository](http://download.proxmox.com/images/system). |
| `template.storage` | | string | `"local"` | Storage where the Template is downloaded.|
| `template.content_type` | | string | `"vztmpl"` | Template content type. |
| `template.timeout` | | int |  | Timeout for template download (in seconds). |
| `hookscript` | | string | | Script that will be executed during various steps in the containers lifetime. |
| `cpus` | | int | | Number of allocated cpus. |
| `cores` | | int | | Number of cores per socket. |
| `memory` | | int | | Amount of RAM in MB. |
| `swap` | | int | | Size of the swap memory in MB. |
| `disk_volume` | Yes | dict | | Main disk configuration (same syntax as `community.general.proxmox`). |
| `mount_volumes` | | dict | `{}` | Additional mount points for the LXC. |
| `netif` | | dict | `{}` | Network interfaces of the LXC (same syntax as `community.general.proxmox`). |
| `ostype` | | string | | OS type. |
| `onboot` | | bool | `false` | Start container on host boot. |
| `startup` | | string | | Startup options. |
| `pubkey` | | string | | SSH public key for root access to the LXC. |
| `nameserver` | | string | | DNS nameserver. |
| `timezone` | | string | `"host"` | Container Timezone. |
| `features` | | list | `[]` | Additional LXC features. |
| `tags` | | list | `["ansible"]` | Container Tags. |

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Create lxc
  hosts: all
  roles:
    - role: create_lxc
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
