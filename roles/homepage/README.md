# Ansible Role: homepage

An Ansible Role that deploys [Homepage](https://github.com/gethomepage/homepage) as a Docker Compose stack.

## Requirements

This role assumes that Docker Engine and Docker Compose are present on the system. You can use the well-known `geerlingguy.docker` role to satisfy these requirements.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `homepage_root` | | string | `"/opt/homepage"` | Root directory where the Homepage stack files and configuration are stored. |
| `homepage_version` | | string | `"latest"` | Homepage container image tag. |
| `homepage_restart` | | string | `"unless-stopped"` | Docker container restart policy. |
| `homepage_port` | | int | `3000` | Port exposed by the Homepage container. |
| `homepage_timezone` | | string | `"UTC"` | Timezone used by the container. |
| `homepage_allowed_hosts` | | string | `""` | Comma-separated list of allowed hostnames (sets `HOMEPAGE_ALLOWED_HOSTS`). |
| `homepage_docker_socket` | | bool | `false` | Mount the Docker socket into the container to enable service auto-discovery (must user root user). |
| `homepage_user` | | string | `"root"` | System user that owns the config files. |
| `homepage_uid` | | int | `0` | UID passed to the container via `PUID`. |
| `homepage_group` | | string | `"root"` | System group that owns the config files. |
| `homepage_gid` | | int | `0` | GID passed to the container via `PGID`. |

### Configuration

These variables map directly to Homepage's YAML configuration files. Refer to the [Homepage documentation](https://gethomepage.dev/configs/) for the full schema.

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `homepage_settings` | | dict | `{}` | Content of `settings.yaml`. |
| `homepage_services` | | list | `[]` | Content of `services.yaml`. |
| `homepage_widgets` | | list | `[]` | Content of `widgets.yaml`. |
| `homepage_bookmarks` | | list | `[]` | Content of `bookmarks.yaml`. |
| `homepage_docker` | | dict | `{}` | Content of `docker.yaml`. |
| `homepage_proxmox` | | dict | `{}` | Content of `proxmox.yaml`. |

## Dependencies

This role depends on `docker_compose` for deploying the service as a Docker Compose stack.

## Example Playbook

```yaml
- name: Deploy Homepage.
  hosts: all
  roles:
    - role: homepage
```

```yaml
# host_vars/myhost/homepage.yml

homepage_port: 3000
homepage_allowed_hosts: "192.168.1.10:3000"
homepage_docker_socket: true

homepage_settings:
  title: "My Homepage"
  description: "Personal dashboard"

homepage_bookmarks:
  - Developer:
      - Github:
          - abbr: GH
            href: https://github.com/

homepage_services:
  - Media:
      - Jellyfin:
          href: http://192.168.1.10:8096
          server: my-docker
          container: jellyfin

homepage_docker:
  my-docker:
    socket: /var/run/docker.sock
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
