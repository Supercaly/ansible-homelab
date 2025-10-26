Ansible Role: create-lxc
=========

An Ansible Role that creates a Proxmox LXC.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

### Proxmox API variables

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `proxmox_node` | Yes | string | | Proxmox host node. |
| `proxmox_api_host` | | string | `"localhost"` | Address of the Proxmox API host. |
| `proxmox_api_user` | Yes | string | | Proxmox API user. |
| `proxmox_api_password` | Yes | string | | Password for Proxmox API. <br/>This option is mutually exclusive with `proxmox_api_token_id` and `proxmox_api_token_secret`. |
| `proxmox_api_token_id` | Yes | string | | Token ID for Proxmox API. <br/>This option is mutually exclusive with `proxmox_api_password`. |
| `proxmox_api_token_secret` | Yes | string | | Token secret for Proxmox API. <br/>This option is mutually exclusive with `proxmox_api_password`. |

### LXC guest variables

Variables related to the guest LXC are defined as fields of the `proxmox_lxc` dictionary:

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `vmid` | Yes | int | | LXC container ID. |
| `hostname` | Yes | string | | Hostname of the container. |
| `password` | Yes | string | | Password of the container. |
| `unprivileged` | | bool | `true` | Create a privileged/unprivileged LXC. |
| `template.name` | Yes | string | | Template image name. <br/> See the [official Proxmox repository](http://download.proxmox.com/images/system). |
| `template.storage` | | string | `"local"` | Storage where the Template is downloaded.|
| `template.content_type` | | string | `"vztmpl"` | Template content type. |
| `template.timeout` | | int |  | Timeout for template download (in seconds). |
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
    - role: create-lxc
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
