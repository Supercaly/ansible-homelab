# Ansible Role: ddns

An Ansible Role that deploys [ddns-updater](https://github.com/qdm12/ddns-updater) as a Docker Compose stack.

## Requirements

This role assumes that Docker Engine and Docker Compose are present on the system. You can use the well-known `geerlingguy.docker` role to satisfy these requirements.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`ddns_config` | Yes | object | | Configuration object passed to the DDNS service. See [this](https://github.com/qdm12/ddns-updater?tab=readme-ov-file#configuration) for more info. |
|`ddns_root` | | string | `"/opt/ddns"` | Root directory where the DDNS stack files and configuration are stored. |
|`ddns_version` | | string | `"latest"` | Version of the ddns-updater container. |
|`ddns_restart` | | string | `"unless-stopped"` | Docker container restart policy. |
|`ddns_port` | | int | `8000` | Port exposed by the DDNS service.|
|`ddns_timezone` | | string | `"UTC"` | Timezone used by the DDNS service container. |

## Dependencies

This role depends on `docker_compose` for deploying the service as a Docker Compose stack.

## Example Playbook

```yaml
- name: Deploy ddns service.
  hosts: all
  roles:
    - role: ddns
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calsti.
