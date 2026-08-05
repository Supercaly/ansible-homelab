# Ansible Role: create_lxc

An Ansible Role that creates and configures LXC containers on Proxmox VE using the Proxmox API.

The role is responsible only for container creation and base configuration.
It assumes that Proxmox is already installed, reachable, and properly configured.

This role is able to perform the following operations:

- Create LXC containers on Proxmox VE via API
- Download container templates if not already available
- Configure CPU, memory, storage, networking, SSH key, etc.
- Support for:
  - password-based authentication
  - API token-based authentication
- Support for hookscript

## Requirements

This role assumes that Proxmox VE is already installed, running, and properly configured.

The Proxmox API must be reachable from the Ansible control node (default port `8006`) and authentication must be provided via a Proxmox user or API token with sufficient permissions to:

- create and manage LXC containers
- download container templates
- configure storage, networking, and startup options

All referenced storages (template storage, root disk storage, and any optional mount points) must exist prior to execution.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

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
| `proxmox_validate_certs` | | bool | | Validate the TLS certificates used for the connection to the Proxmox VE API.|

For authentication you must use either password-based authentication or API tokens, not both.

| Name | Required | Type | Description |
| - | - | - | - |
| `proxmox_api_password` | Yes* | string | Password for API user. |
| `proxmox_api_token_id` | Yes* | string | API token ID. |
| `proxmox_api_token_secret` | Yes* | string | API token secret. |

&ast; This variables are mutually exclusive.

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
| `mount_volumes` | | dict | `{}` | Additional bind mount points for the LXC. See [Mount volumes](#mount-volumes). |
| `devices` | | dict | `{}` | Device passthrough configuration for the LXC. See [Device passthrough](#device-passthrough). |
| `raw_config` | | list | `[]` | Raw lines appended to `/etc/pve/lxc/<vmid>.conf`. See [Raw config](#raw-config). |
| `subuid` | | list | `[]` | Entries to ensure in `/etc/subuid` on the host. See [UID/GID mapping](#uidgid-mapping). |
| `subgid` | | list | `[]` | Entries to ensure in `/etc/subgid` on the host. See [UID/GID mapping](#uidgid-mapping). |
| `netif` | | dict | `{}` | Network interfaces of the LXC (same syntax as `community.general.proxmox`). |
| `ostype` | | string | | OS type. |
| `onboot` | | bool | `false` | Start container on host boot. |
| `startup` | | string | | Startup options. |
| `pubkey` | | string | | SSH public key for root access to the LXC. |
| `nameserver` | | string | | DNS nameserver. |
| `timezone` | | string | `"host"` | Container Timezone. |
| `features` | | list | `[]` | Additional LXC features. |
| `tags` | | list | `["ansible"]` | Container Tags. |

### Mount volumes

`mount_volumes` is a dict where each key is a Proxmox mount point identifier (e.g. `mp0`) and each value defines the bind mount.

| Key | Required | Description |
| - | - | - |
| `host_path` | Yes | Absolute path on the Proxmox host to bind-mount into the container. |
| `mountpoint` | Yes | Absolute path inside the container where the host path is mounted. |

Example:

```yaml
proxmox_lxc:
  mount_volumes:
    mp0:
      host_path: /mnt/tank/media
      mountpoint: /media
    mp1:
      host_path: /mnt/tank/downloads
      mountpoint: /downloads
```

### Device passthrough

`devices` is a dict where each key is a Proxmox device identifier (e.g. `dev0`) and each value defines a host device to expose inside the container.

| Key | Required | Description |
| - | - | - |
| `path` | Yes | Absolute path of the device on the Proxmox host (e.g. `/dev/dri/renderD128`). |
| `gid` | | Group ID to assign to the device inside the container. |
| `uid` | | User ID to assign to the device inside the container. |
| `mode` | | Permission mode for the device (octal). |
| `deny_write` | | If set, deny write access to the device. |

Example:

```yaml
proxmox_lxc:
  devices:
    dev0:
      path: /dev/dri/renderD128
      gid: 104
    dev1:
      path: /dev/dri/card0
      gid: 44
```

### Raw config

`raw_config` is a list of raw lines written directly to `/etc/pve/lxc/<vmid>.conf`. Use this for LXC options that the Proxmox API and `pct set` do not support, such as `lxc.idmap` and other `lxc.*` directives.

Example:

```yaml
proxmox_lxc:
  raw_config:
    - "lxc.idmap: u 0 100000 65536"
    - "lxc.idmap: g 0 100000 2000"
    - "lxc.idmap: g 2000 2000 1"
    - "lxc.idmap: g 2001 102001 63535"
```

### UID/GID mapping

When using custom UID/GID mappings via `lxc.idmap`, the host must explicitly authorize the container to use any ID outside the default range (`100000-165535`). This is configured in `/etc/subuid` and `/etc/subgid`.

`subuid` and `subgid` are lists of lines to ensure are present in those files. The format for each entry is `<user>:<id>:<count>`.

Example:

```yaml
proxmox_lxc:
  subgid:
    - "root:1000:1"
  subuid: []
```

Entries are managed with `lineinfile` and are idempotent: existing lines are not duplicated. Note that entries are never removed automatically; *if a mapping is no longer needed it must be cleaned up manually*.

## Dependencies

This role depends on the collection `community.proxmox` for managing Proxmox LXCs.

## Example Playbook

```yaml
- name: Ensure LXC exists.
  hosts: all
  roles:
    - role: create_lxc
```

Example variable definition:

```yaml
proxmox_node: pve
proxmox_api_user: ansible@pve
proxmox_api_token_id: ansible
proxmox_api_token_secret: "{{ vault_proxmox_api_token_secret }}"
proxmox_lxc:
  vmid: 100
  hostname: lxc1
  password: "{{ vault_lxc_password }}"
  template:
    name: "debian-12-standard_12.7-1_amd64.tar.zst"
  disk_volume:
    storage: "local"
    size: 2
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calisti.
