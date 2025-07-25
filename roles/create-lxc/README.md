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
| `proxmox_node` | Yes | string | | Host node with Proxmox installed. |
| `proxmox_api_host` | Yes | string | | Address of the API host. |
| `proxmox_api_user` | Yes | string | | User to use for API login. |
| `proxmox_api_password` | Yes | string | | Password for API login. |
| `proxmox_api_token_id` | Yes | string | | Token ID for API login. |
| `proxmox_api_token_secret` | Yes | string | | Token secret for API login. |
| `lxc_vmid` | Yes | int | | LXC ID. |
| `lxc_hostname` | Yes | string | | LXC hostname. |
| `lxc_password` | Yes | string | | LXC password. |
| `lxc_appname` | |string |  `"{{ lxc_hostname }}"` | Human-Readable app name.|
| `lxc_delete` | | bool | `false` | Delete the LXC insted of creating it. |
| `lxc_template` | | string | `"debian-12-standard_12.7-1_amd64.tar.zst"` | Name of Template image to download. <br/> Check the [official Proxmox repository](http://download.proxmox.com/images/system/) for the available images. |
| `lxc_template_storage` | | string | `"local"` | Storage where the Template is downloaded.|
| `lxc_template_content_type` | | string | `"vztmpl"` | Template contenty type. |
| `lxc_unprivileged` | | bool | `true` | If the LXC is unprivileged. |
| `lxc_cores` | | `1` | int | Number of cores when creating the LXC. |
| `lxc_memory` | | `1024` | int | Amount of RAM in MB for the LXC. |
| `lxc_swap` | | `512` | int | Size in MG of swap when creating the LCX. |
| `lxc_disk_storage` | | string | `"local-lvm"` | Storage for the LXC main disk. |
| `lxc_disk_size` | | int | `4` | Size in GB of the LXC main disk. |
| `lxc_mounts` | | list | `[]` | Additional mount points for the LXC. <br/> Note: At the moment it is only possible to define **bind mounts** to some folder in the host device. |
| `lxc_network` | | list | `[]` | Network interfaces for the LXC. |
| `lxc_onboot` | | bool | `false` | Start the LXC at host's bootup. |
| `lxc_startup` | | string | `""` | Startup options. |
| `lxc_nameserver` | | string | `""` | DNS nameserver. |
| 'lxc_timezone` | | string | `"host"` | Timezone of the LXC. |
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
