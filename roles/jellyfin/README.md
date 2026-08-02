# Ansible Role: jellyfin

An Ansible Role that installs [Jellyfin](https://jellyfin.org/) media server on Linux.

*The role is available only on the latest versions of Debian and Ubuntu.*

The role manages:

- Jellyfin APT repository setup
- Jellyfin and jellyfin-ffmpeg installation
- Optional Intel or AMD hardware acceleration (VA-API / QSV)

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

| Name | Default | Description |
| - | - | - |
| `jellyfin_user` | `jellyfin` | System user that runs Jellyfin. |
| `jellyfin_group` | `adm` | Primary group for the Jellyfin config directory. |
| `jellyfin_service_name` | `jellyfin` | Name of the systemd service. |
| `jellyfin_conf_dir` | `/etc/jellyfin` | Jellyfin configuration directory. |
| `jellyfin_ffmpeg_dir` | `/usr/lib/jellyfin-ffmpeg` | Directory of the bundled jellyfin-ffmpeg installation. |

### APT repository

| Name | Default | Description |
| - | - | - |
| `jellyfin_apt_gpg_key` | `https://repo.jellyfin.org/jellyfin_team.gpg.key` | URL of the Jellyfin APT signing key. |
| `jellyfin_apt_key_path` | `/etc/apt/keyrings/jellyfin.asc` | Destination path for the signing key. |
| `jellyfin_apt_arch` | auto-detected | APT architecture string (`amd64`, `arm64`, `armhf`). |
| `jellyfin_apt_url` | `https://repo.jellyfin.org/<distro>` | Base URL of the Jellyfin APT repository. |
| `jellyfin_apt_suites` | distribution codename | APT suite (e.g. `bookworm`). |

### Hardware acceleration

Set `jellyfin_hwaccel` to enable GPU-accelerated transcoding. The Jellyfin wizard must still be configured manually to select the acceleration method (QSV for Intel, VA-API for AMD).

| Name | Default | Description |
| - | - | - |
| `jellyfin_hwaccel` | `none` | Hardware acceleration type. One of: `none`, `intel`, `amd`. |

**`intel`**: on Debian, enables the `non-free` repository and installs Intel VA-API/QSV drivers. On Ubuntu, no extra repository is needed.

**`amd`**: `jellyfin-ffmpeg` already bundles the required Mesa drivers.

The DRI device passthrough (e.g. `/dev/dri/renderD128`) must be configured separately at the Proxmox level before enabling hardware acceleration.

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure Jellyfin media server.
  hosts: jellyfin
  roles:
    - role: jellyfin
```

```yaml
# host_vars/jellyfin-prod/jellyfin.yml

jellyfin_hwaccel: "intel"
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
