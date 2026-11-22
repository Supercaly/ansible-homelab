# Ansible Role: nut_exporter

An Ansible Role that deploys [nut_exporter](https://github.com/DRuggeri/nut_exporter) as a Docker Compose stack.

The role exposes NUT (Network UPS Tools) metrics to Prometheus by connecting to a remote or local `upsd` instance.

## Requirements

Docker must be installed on the target host.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

### Container

| Name | Default | Description |
| - | - | - |
| `nut_exporter_root` | `/opt/nut-exporter` | Directory where the Compose stack is deployed. |
| `nut_exporter_version` | `latest` | Image tag for `ghcr.io/druggeri/nut_exporter`. |
| `nut_exporter_restart` | `unless-stopped` | Container restart policy. |
| `nut_exporter_port` | `9199` | Host port exposed for the metrics endpoint. |

### NUT server connection

| Name | Default | Description |
| - | - | - |
| `nut_exporter_server` | `127.0.0.1` | Hostname or IP address of the `upsd` server to connect to. |
| `nut_exporter_serverport` | `3493` | Port of the `upsd` server. |
| `nut_exporter_username` | `""` | Username for authenticated connections. When empty, no authentication is used. |
| `nut_exporter_password` | `""` | Password for the user above. |

### Metrics

| Name | Default | Description |
| - | - | - |
| `nut_exporter_variables` | `battery.charge,battery.voltage,...` | Comma-separated list of NUT variables to export as metrics. |
| `nut_exporter_statuses` | `OL,OB,LB,HB,RB,...` | Comma-separated list of UPS status flags always present in the output (set to `0` if not reported by NUT). |

## Dependencies

Requires the `docker_compose` role.

## Example Playbook

```yaml
- name: Deploy nut_exporter.
  hosts: docker
  roles:
    - role: nut_exporter
      tags: nut_exporter
```

```yaml
nut_exporter_server: "<host>"  # IP of the upsd host
```

Metrics are available at `http://<host>:9199/ups_metrics`.

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
