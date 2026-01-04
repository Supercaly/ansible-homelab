# Ansible Role: docker_compose

An Ansible Role to deploy and manage a Docker Compose stack on Linux.

This role is responsible for preparing the file system layout, deploying files and templates, and executing Docker Compose operations (pull, prune, and cleanup).

It does not install Docker or Docker Compose.

## Requirements

The target host must already have:

- Docker installed and running
- Docker Compose available (docker compose or docker-compose)

You can use the well-known `geerlingguy.docker` role to satisfy these requirements.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `docker_compose_root` | Yes | string | | Root directory where the Docker Compose stack is deployed. |
| `docker_compose_owner` | | string | `"root"` | Default owner for created files and directories. |
| `docker_compose_group` | | string | `"root"` | Default group for created files and directories. |
| `docker_compose_mode`  | | string | `"0755"` | Default permissions for created directories. |
| `docker_compose_subdirs` | | list | `[]` | List of sub-directories created under `docker_compose_root`. |
| `docker_compose_files` | | list | `[]` | List of static files to copy. Each item must define a source path on the control node and a destination path relative to `docker_compose_root`.|
| `docker_compose_templates` | | list | `[]` | List of templates to render. Each item must define a source path on the control node and a destination path relative to `docker_compose_root`.|
| `docker_compose_pull` | | bool | `true` | Pull images before starting the stack. |
| `docker_compose_prune` | | bool | `false` | Remove unused images after deployment. |
| `docker_compose_dangling` | | bool | `true` | Remove dangling images. |

## Dependencies

This role depends on `community.docker` for managing Docker containers and Docker Compose stacks.

## Example Playbook

```yaml
- name: Deploy compose stack.
  hosts: all
  roles:
    - role: docker_compose
```

Example variable definition:

```yaml
docker_compose_root: "/compose/service"
docker_compose_subdirs:
  - path: "config"
docker_compose_files:
  - src: "config/config.yml"
    dest: "config/config.yml"
docker_compose_templates:
  - src: "compose.yml.j2"
    dest: "compose.yml"
  - src: "env.j2"
    dest: ".env"
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calsti.
