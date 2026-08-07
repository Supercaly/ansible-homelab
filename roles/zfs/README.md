# Ansible Role: zfs

Configures [ZFS on Proxmox](https://pve.proxmox.com/wiki/ZFS_on_Linux). ZFS is already included in the PVE kernel so this role does not install it.

The role manages:

- Kernel module options
- Pool and dataset creation and property management
- Systemd scrub and trim timers
- ZFS additional services
- ZED event notifications
- zrepl installation and configuration for snapshot management

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

| Name | Default | Description |
| - | - | - |
| `zfs_kernel_options` | `""` | Options passed to modprobe and written to `/etc/modprobe.d/zfs.conf`. Changes trigger an initramfs update. |
| `zfs_pools` | `[]` | List of pools to create or manage. See [Pools](#pools). |
| `zfs_filesystems` | `[]` | List of datasets to create or manage. See [Datasets](#datasets). |
| `zfs_service_import_cache_enabled` | `true` | Import pools from `/etc/zfs/zpool.cache` at boot. |
| `zfs_service_import_scan_enabled` | `false` | Scan all devices for importable pools at boot. |
| `zfs_service_mount_enabled` | `true` | Mount ZFS datasets at boot. |
| `zfs_service_share_enabled` | `false` | Enable NFS/SMB sharing via ZFS. |
| `zfs_service_volume_wait_enabled` | `true` | Wait for zvol devices to appear. |
| `zfs_service_zed_enabled` | `false` | Enable the ZED daemon and apply ZED configuration. |
| `zfs_scrub_schedule` | `monthly` | Scrub schedule in systemd [OnCalendar format](https://www.freedesktop.org/software/systemd/man/systemd.time.html#Calendar%20Events). |
| `zfs_trim_schedule` | `weekly` | Trim schedule in systemd [OnCalendar format](https://www.freedesktop.org/software/systemd/man/systemd.time.html#Calendar%20Events).. Trim should only be enabled for SSD/NVMe pools. |

### Pools

`zfs_pools` is a list of pools to create or manage. Pools that already exist are not recreated — only their properties are updated.

Each pool item has the following parameters:

| Name | Required | Default | Description |
| - | - | - | - |
| `name` | Yes | | Name of the ZFS pool. |
| `vdev` | Yes | | Virtual devices specification passed verbatim to `zpool create`.|
| `scrub` | No | `true` | Enable scrub on the pool. |
| `trim` | No | `false` | Enable trim on the pool. |
| `properties` | No | `{}` | Dictionary of ZFS pool properties. See [zpoolprops](https://openzfs.github.io/openzfs-docs/man/master/7/zpoolprops.7.html) for all available properties. |
| `filesystem_properties` | No | `{}` | Dictionary of ZFS root filesystem properties. See [zfsprops](https://openzfs.github.io/openzfs-docs/man/master/7/zfsprops.7.html) for all available properties. |

```yaml
zfs_pools:
  - name: tank
    vdev: "raidz sda sdb sdc"
    scrub: true
    trim: false
    properties:
      ashift: 12
    filesystem_properties:
      compression: lz4
      atime: "off"
```

### Datasets

`zfs_filesystems` is a list of datasets to create or manage. Ownership and permissions are only applied when `mountpoint` is defined and all three of `owner`, `group`, `mode` are set.

Each dataset item has the following parameters:

| Name | Required | Default | Description |
| - | - | - | - |
| `name` | Yes | | Name of the ZFS dataset. |
| `state` | No | `present` | Create of delete the dataset. |
| `owner` | No | | Mountpoint owner. |
| `group` | No | | Mountpoint group. |
| `mode` | No | | Mountpoint permissions. |
| `properties` | No | `{}` | Dictionary of ZFS dataset properties. See [zfsprops](https://openzfs.github.io/openzfs-docs/man/master/7/zfsprops.7.html) for all available properties. |

```yaml
zfs_filesystems:
  - name: tank/media
    state: present
    owner: media
    group: media
    mode: "2775"
    properties:
      mountpoint: /mnt/media
      compression: lz4
      atime: "off"
      quota: 500G
```

### ZED notifications

Applied only when `zfs_service_zed_enabled: true`. ZED sends alerts on pool errors, disk failures, and other events. Email delivery requires a working MTA on the host; configure a relay in Proxmox under *Datacenter → Notifications* for external delivery.

| Name | Default | Description |
| - | - | - |
| `zfs_zed_email` | `root` | Recipient email address. |
| `zfs_zed_email_prog` | `mail` | Program used to send mail. |
| `zfs_zed_email_opts` | `"-s '@(SUBJECT)@' @(ADDRESS)@"` | Mail program options. |
| `zfs_zed_notify_interval` | `3600` | Minimum seconds between repeated notifications for the same event. |
| `zfs_zed_notify_verbose` | `false` | Set to `true` to receive notifications for healthy events too. |
| `zfs_zed_ntfy_topic` | `""` | ntfy topic name. |
| `zfs_zed_ntfy_access_token` | `""` | ntfy access token. |
| `zfs_zed_ntfy_url` | `https://ntfy.sh` | ntfy server URL. |

### zrepl

[zrepl](https://zrepl.github.io) manages snapshots and optional replication. When enabled, it is installed from the official zrepl apt repository. See the [zrepl documentation](https://zrepl.github.io/configuration/overview.html) for the full configuration reference.

| Name | Default | Description |
| - | - | - |
| `zfs_zrepl_enabled` | `false` | Install, configure, and start zrepl. |
| `zfs_zrepl_config` | `{}` | zrepl configuration dict, written as-is to `/etc/zrepl/zrepl.yml`. |
| `zfs_zrepl_apt_gpg_key` | zrepl upstream | GPG key URL. |
| `zfs_zrepl_apt_key_path` | `/etc/apt/keyrings/zrepl.asc` | Destination path for the signing key. |
| `zfs_zrepl_apt_url` | zrepl upstream | Repository URL (auto-set from distro). |
| `zfs_zrepl_apt_suites` | distro release | Repository suite (auto-set). |
| `zfs_zrepl_apt_arch` | auto-detected | Repository architecture. |

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure ZFS.
  hosts: zfs
  roles:
    - role: zfs
```

```yaml
# host_vars/pve/zfs.yml

zfs_kernel_options: "zfs_arc_max=4294967296"

zfs_pools:
  - name: tank
    vdev: >-
      raidz
      /dev/disk/by-id/ata-DISK1
      /dev/disk/by-id/ata-DISK2
      /dev/disk/by-id/ata-DISK3
    scrub: true
    properties:
      ashift: 12
    filesystem_properties:
      compression: lz4
      atime: "off"

zfs_filesystems:
  - name: tank/media
    owner: jellyfin
    group: jellyfin
    mode: "0755"
    properties:
      mountpoint: /mnt/media
      atime: "off"
  - name: tank/immich
    properties:
      mountpoint: /mnt/immich
      compression: lz4

zfs_service_zed_enabled: true
zfs_zed_email: alerts@example.com
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
