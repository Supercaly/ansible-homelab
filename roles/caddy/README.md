# Ansible Role: caddy

An Ansible Role that installs and configures the [Caddy](https://caddyserver.com/) web server on Linux.

The role manages:

- Caddy installation via OS package manager or [xcaddy](https://github.com/caddyserver/xcaddy) (for custom plugin builds)
- Global Caddyfile generation
- Snippet and site file deployment
- Config validation before reload
- Service lifecycle (enable, start, reload)

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

| Name | Default | Description |
| - | - | - |
| `caddy_user` | `caddy` | System user that runs Caddy. |
| `caddy_group` | `caddy` | System group for Caddy. |
| `caddy_service_name` | `caddy` | Name of the systemd service. |
| `caddy_config_dir` | `/etc/caddy` | Base configuration directory. |
| `caddy_log_dir` | `/var/log/caddy` | Log directory. |
| `caddy_caddyfile_file` | `/etc/caddy/Caddyfile` | Path to the main Caddyfile. |
| `caddy_snippets_dir` | `/etc/caddy/snippets` | Directory for Caddy snippet files. |
| `caddy_sites_dir` | `/etc/caddy/sites` | Directory for per-site Caddy files. |

### Global Caddyfile options

| Name | Default | Description |
| - | - | - |
| `caddy_admin` | `localhost:2019` | Admin API endpoint. Set to `off` to disable. |
| `caddy_global_options` | `""` | Raw Caddyfile directives written inside the [global options block](https://caddyserver.com/docs/caddyfile/options). Use this for `email`, `local_certs`, `acme_ca`, and any other global option. |
| `caddy_trust_local_ca` | `false` | Run `caddy trust` to add Caddy's local root CA to the system trust store. Enable when using `local_certs` in `caddy_global_options`. |

### Snippets

Snippets are Caddyfile files deployed to `caddy_snippets_dir` and imported globally. Sites can then reference them with Caddy's native `import` directive.

| Name | Default | Description |
| - | - | - |
| `caddy_snippets` | `[]` | List of snippet file paths to deploy. Files are processed as Jinja2 templates before being written. |
| `caddy_rm_unmanaged_snippets` | `true` | Remove snippet files not present in `caddy_snippets`. |

Example:

```yaml
caddy_snippets:
  - files/caddy/snippets/private.caddy
  - files/caddy/snippets/logging.caddy
```

```
# files/caddy/snippets/private.caddy
(private) {
    @outside not remote_ip private_ranges
    respond @outside 403
}
```

### Sites

Each site is a raw Caddyfile block written to a file in `caddy_sites_dir`. The filename is derived from `name` as is.

The `content` field is processed as a Jinja2 template by Ansible before being written, so inventory variables such as `{{ domain }}` are substituted. Caddy's own single-brace placeholders (`{uri}`, `{host}`, etc.) are unaffected.

| Name | Default | Description |
| - | - | - |
| `caddy_sites` | `[]` | List of site definitions. |
| `caddy_rm_unmanaged_sites` | `true` | Remove site files not present in `caddy_sites`. |

Each entry in `caddy_sites` **requires**:

| Key | Description |
| - | - |
| `name` | Used as the filename in `caddy_sites_dir` (without extension). |
| `content` | Raw Caddyfile block, including the site address and braces. Processed as Jinja2 before writing. |

Example:

```yaml
caddy_sites:
  - name: grafana
    content: |
      grafana.example.com {
          import private
          import logging grafana_example_com
          reverse_proxy localhost:3000
      }

  - name: vaultwarden
    content: |
      vault.{{ domain }} {
          import private
          reverse_proxy {{ vaultwarden_host }}:8222
      }
```

### Plugin options

When `caddy_plugins` is non-empty, Caddy is compiled from source using [xcaddy](https://github.com/caddyserver/xcaddy) instead of being installed from the OS package manager. Go and xcaddy are downloaded automatically. Caddy is rebuilt only when the plugin list or versions change.

Switching between installation methods is handled automatically.

| Name | Default | Description |
| - | - | - |
| `caddy_plugins` | `[]` | Caddy plugins to build in. |
| `caddy_version` | `""` | Caddy version to build (e.g. `v2.9.1`). Empty means latest. |
| `caddy_xcaddy_version` | `""` | xcaddy version to install. Empty means latest from GitHub releases. |
| `caddy_go_version` | `""` | Go version to install. Empty means latest stable from [go.dev](go.dev). |
| `caddy_go_install_dir` | `/usr/local/go` | Directory where Go is installed. |
| `caddy_xcaddy_bin` | `/usr/local/bin/xcaddy` | Path to the xcaddy binary. |
| `caddy_xcaddy_cleanup` | `true` | Remove Go, xcaddy, and build tarballs after a successful build. Set to `false` to keep the toolchain for debugging. |

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure Caddy.
  hosts: caddy
  roles:
    - role: caddy
```

```yaml
# host_vars/caddy/caddy.yml

caddy_global_options: |
  email admin@example.com
  acme_dns cloudflare {env.CF_API_TOKEN}

caddy_plugins:
  - github.com/caddy-dns/cloudflare

caddy_snippets:
  - files/caddy/snippets/private.caddy
  - files/caddy/snippets/logging.caddy

caddy_sites:
  - name: grafana
    content: |
      grafana.example.com {
          import private
          import logging grafana_example_com
          reverse_proxy localhost:3000
      }

  - name: nas
    content: |
      nas.example.com {
          import private
          reverse_proxy https://192.168.1.20 {
              transport http {
                  tls_insecure_skip_verify
              }
          }
      }
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calisti.
