# Ansible Role: zfs_exporter

An Ansible Role that installs [zfs_exporter](https://github.com/pdf/zfs_exporter) on Linux systems with ZFS.

## Requirements

ZFS must be installed and the `zfs.target` systemd unit must be available.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `zfs_exporter_version` | string | `latest` | Version to install. Use `latest` to automatically resolve the newest GitHub release, or pin to a specific version (e.g. `2.2.7`) for production. |
| `zfs_exporter_binary_install_dir` | string | `/usr/local/bin` | Directory where the binary is installed. |
| `zfs_exporter_web_listen_address` | string | `0.0.0.0:9134` | Address and port to listen on. |
| `zfs_exporter_web_telemetry_path` | string | `/metrics` | Path to expose metrics on. |
| `zfs_exporter_deadline` | string | `8s` | Maximum duration for a collection. Increase for large pools. |
| `zfs_exporter_user` | string | `prometheus` | System user running the service. |
| `zfs_exporter_group` | string | `prometheus` | System group for the service. |

## Notes

- The exporter requires read access to ZFS kernel statistics. Running as `prometheus` user works on most systems; if metrics are missing, the user may need additional privileges.
- Configuration is done entirely via command-line flags in the systemd service unit — there is no separate config file.
- When `zfs_exporter_version` is set to `latest`, the role queries the GitHub API at runtime to resolve the current version.

## Dependencies

None.

## Example Playbook

```yaml
- name: Install zfs_exporter on ZFS hosts.
  hosts: all
  become: true
  roles:
    - role: zfs_exporter
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
