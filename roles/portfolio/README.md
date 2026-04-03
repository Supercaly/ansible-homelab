# Ansible Role: portfolio

An Ansible Role that deploys my personal [portfolio site](https://github.com/Supercaly/portfolio-svelte/tree/main) as a Docker Compose stack.

## Requirements

This role assumes that Docker Engine and Docker Compose are present on the system. You can use the well-known `geerlingguy.docker` role to satisfy these requirements.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`portfolio_root` | | string | `"/opt/portfolio"` | Root directory where the portfolio stack files and configuration are stored. |
|`portfolio_restart` | | string | `"unless-stopped"` | Docker container restart policy. |
|`portfolio_port` | | int | `8000` | Port exposed by the portfolio service.|
|`portfolio_timezone` | | string | `"UTC"` | Timezone used by the portfolio service container. |
|`portfolio_repo` | | string | `"https://github.com/Supercaly/portfolio-svelte"` | URL of the git repository with the portfolio source code.|
|`portfolio_repo_branch` | | string | `"main"` | Branch of the repository to clone.|

## Dependencies

This role depends on `docker_compose` for deploying the service as a Docker Compose stack.

## Example Playbook

```yaml
- name: Deploy portfolio service.
  hosts: all
  roles:
    - role: portfolio
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calsti.
