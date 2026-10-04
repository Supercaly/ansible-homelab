# Ansible Role: immich

An Ansible Role that deploys [Immich](https://github.com/immich-app/immich) as a Docker Compose stack.

## Requirements

This role assumes that Docker Engine and Docker Compose are present on the system. You can use the well-known `geerlingguy.docker` role to satisfy these requirements.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `immich_root` | | string | `"/opt/immich"` | Root directory where the Immich stack files and configuration are stored. |
| `immich_version` | | string | `"release"` | Version of the Immich containers. Use `"release"` for the latest stable release. |
| `immich_restart` | | string | `"unless-stopped"` | Docker container restart policy. |
| `immich_port` | | int | `2283` | Port exposed by the Immich server. |
| `immich_timezone` | | string | `"UTC"` | Timezone used by the services. |
| `immich_upload_location` | | string | `"{{ immich_root }}/library"` | Host path where uploaded photos and videos are stored. |
| `immich_db_data_location` | | string | `"{{ immich_root }}/postgres"` | Host path where the PostgreSQL database data is stored. |
| `immich_db_username` | | string | `"postgres"` | PostgreSQL username. |
| `immich_db_password` | Yes | string | | PostgreSQL password. |
| `immich_db_name` | | string | `"immich"` | PostgreSQL database name. |
| `immich_metrics_enabled` | | bool | `false` | Enable Prometheus metrics. Exposes metrics on dedicated ports and sets `IMMICH_TELEMETRY_INCLUDE=all`. |
| `immich_metrics_port_server` | | int | `8081` | Host port for server metrics (API request rates, response times). Only used when `immich_metrics_enabled` is true. |
| `immich_metrics_port_microservices` | | int | `8082` | Host port for microservices metrics (job queues, ML inference latency). Only used when `immich_metrics_enabled` is true. |

## Dependencies

This role depends on `docker_compose` for deploying the service as a Docker Compose stack.

## Example Playbook

```yaml
- name: Deploy Immich service.
  hosts: all
  roles:
    - role: immich
      vars:
        immich_timezone: "Europe/Rome"
        immich_db_password: "a-strong-password"
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
