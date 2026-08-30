# Ansible Role: pve_exporter

An Ansible Role that installs [prometheus-pve-exporter](https://github.com/prometheus-pve/prometheus-pve-exporter) in a Python venv on Proxmox VE nodes.

## Requirements

A Proxmox VE user or API token with read-only permissions (`PVEAuditor` role).

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `pve_exporter_venv_path` | string | `/opt/prometheus-pve-exporter` | Path where the Python venv is created. |
| `pve_exporter_config_dir` | string | `/etc/prometheus` | Directory for the `pve.yml` config file. |
| `pve_exporter_port` | int | `9221` | Port the exporter listens on. |
| `pve_exporter_user` | string | `prometheus` | System user running the service. |
| `pve_exporter_group` | string | `prometheus` | System group for the service. |
| `pve_exporter_version` | string | `latest` | Package version to install. Set to a specific version (e.g. `1.3.1`) to pin it. |
| `pve_exporter_pve_user` | string | `prometheus@pve` | Proxmox user for API authentication. |
| `pve_exporter_pve_password` | string | | Password for the Proxmox user. Required if not using a token. Store in vault. |
| `pve_exporter_pve_token_name` | string | | API token name. If set together with `pve_exporter_pve_token_value`, token auth is used instead of password. |
| `pve_exporter_pve_token_value` | string | | API token value. Store in vault. |
| `pve_exporter_verify_ssl` | bool | `false` | Whether to verify the Proxmox API SSL certificate. |

## Authentication

The role supports both password and API token authentication. Token auth is recommended.

**Password:**
```yaml
pve_exporter_pve_user: "prometheus@pve"
pve_exporter_pve_password: "{{ vault_pve_exporter_password }}"
```

**API token (recommended):**
```yaml
pve_exporter_pve_user: "prometheus@pve"
pve_exporter_pve_token_name: "{{ vault_pve_exporter_token_name }}"
pve_exporter_pve_token_value: "{{ vault_pve_exporter_token_value }}"
```

## Dependencies

None.

## Example Playbook

```yaml
- name: Install pve_exporter on Proxmox nodes.
  hosts: hypervisor
  become: true
  roles:
    - role: pve_exporter
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
