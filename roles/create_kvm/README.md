# Ansible Role: create_kvm

An Ansible Role that creates and configures KVM virtual machines on Proxmox VE using the Proxmox API.

The role creates a virtual machine by cloning an existing Proxmox KVM template.
It assumes that Proxmox VE is already installed, reachable, and properly configured, and that the source template already exists on the target node.

The role also supports cloud-init, allowing the new VM to be configured with custom parameters such as users, passwords, SSH keys, networking, and DNS settings.

This role is able to perform the following operations:

- Clone a KVM virtual machine from an existing template on Proxmox VE via API
- Configure CPU, memory, storage, and startup options
- Configure cloud-init parameters (users, passwords, SSH keys, IP configuration, DNS)
- Authenticate to Proxmox using either:
  - password-based authentication
  - API token-based authentication

## Requirements

This role assumes that Proxmox VE is already installed, running, and properly configured.

The Proxmox API must be reachable from the Ansible control node (default port `8006`) and authentication must be provided via a Proxmox user or API token with sufficient permissions to:

- create and clone virtual machines
- configure CPU, memory, disks, and devices
- manage cloud-init settings
- start and stop virtual machines

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

Variables are divided into two logical groups:

1. Proxmox API connection
2. KVM virtual machine definition

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
| `proxmox_api_password` | Yes* | string | Password for API user. |
| `proxmox_api_token_id` | Yes* | string | API token ID. |
| `proxmox_api_token_secret` | Yes* | string | API token secret. |

&ast; This variables are mutually exclusive.

### KVM variables

All KVM-related settings are defined inside the `proxmox_kvm` dictionary.

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`template_vmid` | Yes | int | | ID of the source template. |
|`template_name` | Yes | string | | Name of the source template. |
|`name` | Yes | string | | Name of the new virtual machine. |
|`vmid` | Yes | int	| | Unique ID of the virtual machine. |
|`full` | | bool | | Perform a full clone instead of a linked clone. |
|`format` | | string | | Disk format for the cloned VM (i.e., qcow2, raw). |
|`target` | | string | | Target Proxmox node (if different from `proxmox_node`). |
|`storage` | | string | | Target storage for full clone. |
|`cpu` | | string | | Emulated CPU type. |
|`cores` | | int | | Number of CPU cores. |
|`sockets` | | int | | Number of CPU sockets. |
|`memory` | | int | | Memory size in MB. |
|`balloon` | | int | | Ballooning memory size in MB. |
|`startup` | | string | | Startup options. |
|`onboot` | | bool | | Start VM on host boot. |
|`ciuser` | | string | | Default cloud-init user. | 
|`cipassword` | | string | | Cloud-init user password. | 
|`ciupgrade` | | bool | | Enable cloud-init package upgrades. | 
|`ipconfig` | | object | | Cloud-init IP configuration for network interfaces. | 
|`sshkeys` | | string | | SSH public keys injected via cloud-init. | 
|`nameservers` | | string | | DNS servers configured via cloud-init. | 
|`searchdomains` | | string | | DNS search domains. | 
|`localtime` | | bool | | Use local time instead of UTC. | 
|`audio` | | object | | Dictionary of audio devices configuration. |
|`parallel` | | object | | Dictionary of parallel devices configuration. |
|`serial`| | object | | Dictionary of serial devices configuration. |
|`scsi`| | object | | Dictionary of SCSI disks definitions. |
|`usb`| | object | | Dictionary of USB passthrough devices. |
|`hostpci`| | object | | Dictionary of PCI passthrough devices. |
|`vga`| | string | | VGA device type. |
|`rng0`| | string | | RNG device configuration. |
|`watchdog`| | string | | Watchdog device configuration. |
|`tags`| | string | `["ansible"]` | KVM tags. |

## Dependencies

This role depends on the collection `community.proxmox` for managing Proxmox LXCs.

## Example Playbook

```yaml
- name: Ensure KVM machine exists.
  hosts: all
  roles:
    - role: create_kvm
```

Example variable definition:

```yaml
proxmox_node: pve
proxmox_api_user: ansible@pve
proxmox_api_token_id: ansible
proxmox_api_token_secret: "{{ vault_proxmox_api_token_secret }}"
proxmox_kvm:
  template_vmid: 9000
  template_name: debian-12-template
  vmid: 100
  name: vm-debian-01
  cores: 2
  memory: 2048
  ciuser: debian
  scsi:
    scsi0:
      size: 25
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calsti.
