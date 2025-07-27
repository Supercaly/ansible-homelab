Ansible Role: create-lxc
=========

An Ansible Role that creates a Proxmox LXC.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `proxmox_node` | Yes | string | | Proxmox host node. |
| `proxmox_api_host` | Yes | string | | Address of the Proxmox API host. |
| `proxmox_api_user` | Yes | string | | Proxmox API user. |
| `proxmox_api_password` | Yes | string | | Password for Proxmox API. <br/>This option is mutually exclusive with `proxmox_api_token_id` and `proxmox_api_token_secret`. |
| `proxmox_api_token_id` | Yes | string | | Token ID for Proxmox API. <br/>This option is mutually exclusive with `proxmox_api_password`. |
| `proxmox_api_token_secret` | Yes | string | | Token secret for Proxmox API. <br/>This option is mutually exclusive with `proxmox_api_password`. |
| `lxc_vmid` | Yes | int | | LXC ID. |
| `lxc_hostname` | Yes | string | | LXC hostname. |
| `lxc_password` | Yes | string | | LXC password. |
| `lxc_appname` | | string |  `"{{ lxc_hostname }}"` | Human-readable app name.|
| `lxc_delete` | | bool | `false` | Delete the LXC insted of creating it. |
| `lxc_template` | | string | `"debian-12-standard_12.7-1_amd64.tar.zst"` | Name of Template image to download. <br/> Check the [official Proxmox repository](http://download.proxmox.com/images/system/) for the available images. |
| `lxc_template_storage` | | string | `"local"` | Storage where the Template is downloaded.|
| `lxc_template_content_type` | | string | `"vztmpl"` | Template contenty type. |
| `lxc_template_timeout` | | int | `180` | Timeout when downloading LXC template image. <br/>Increese this value based on your internet connection speed. |
| `lxc_unprivileged` | | bool | `true` | Create an unprivileged LXC. If `false` a privileged LXC will be created instead. |
| `lxc_cores` | | `1` | int | Number of cores for the LXC CPU. |
| `lxc_memory` | | `1024` | int | Amount of RAM in MB for the LXC. |
| `lxc_swap` | | `512` | int | Size of the swap in MB for the LCX. |
| `lxc_disk_storage` | | string | `"local-lvm"` | Storage for the LXC main disk. |
| `lxc_disk_size` | | int | `4` | Size in GB of the LXC main disk. |
| `lxc_mounts` | | list | `[]` | Additional mount points for the LXC. <br/>Note: At the moment it is only possible to define **bind mounts** to some folder in the Proxmox host. |
| `lxc_network` | | list | `[]` | LXC network interfaces. |
| `lxc_onboot` | | bool | `false` | Start the LXC at host's bootup. |
| `lxc_startup` | | string | `""` | LXC startup options. |
| `lxc_nameserver` | | string | `""` | DNS nameserver. |
| 'lxc_timezone` | | string | `"host"` | LXC Timezone. |
| `lxc_pubkey` | | string | `""` | Path to an SSH key to use for secure connection to the LXC. |
| `lxc_features` | | string | `"keyctl=1,nesting=1"` | Additional LXC features. |
| `lxc_tags` | | list | `["ansible"]` | LXC Tags. |

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
