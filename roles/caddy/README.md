# Ansible Role: caddy

An Ansible Role that installs and configures the [Caddy](https://caddyserver.com/) web server as a reverse proxy on Linux.

The role manages:

- Caddy installation
- Base configuration via Caddyfile
- Additional site definitions
- Logging and ACME certificates

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
|`caddy_config_dir`| string | `"/etc/caddy"` | Path to the caddy config directory.|
|`caddy_log_dir` | string | `"/var/log/caddy"` | Path to caddy logs directory. |
|`caddy_caddyfile_file` | string | `"/etc/caddy/Caddyfile"` | Path to the Caddyfile. |
|`caddy_sites_dir` | string | `"/etc/caddy/sites"` | Path to the directory containing additional sites. |
|`caddy_sites` | object | `[]` | List of additional sites. |
|`caddy_rm_unmanaged_sites` | bool | `true` | Automatically remove old sites files not present in the config. |
|`caddy_debug` | bool | `false` | Enable debug mode. |
|`caddy_admin` | string | `"localhost:2019"` | Customize the admin API endpoint. If set to `off` the admin endpoint is disabled. |
|`caddy_email` | string | `""` | Email address used when creating an ACME account with the Let's Encrypt CA. |
|`caddy_local_certs` | bool | `false` | Issue all certificates internally, rather than through a public ACME CA. |
|`caddy_ca` | string | `"default"` | ACME endpoint to use [default, staging]. |
|`caddy_default_ca` | string |`"https://acme-v02.api.letsencrypt.org/directory"` | Default ACME API endpoint. |
|`caddy_staging_ca` | string | `"https://acme-staging-v02.api.letsencrypt.org/directory"` | Staging ACME API endpoint. |

### xcaddy / plugin options

When `caddy_plugins` is non-empty, Caddy is compiled from source using [xcaddy](https://github.com/caddyserver/xcaddy) instead of being installed from the OS package manager. Go is downloaded automatically from go.dev.

| Name | Type | Default | Description |
| - | - | - | - |
| `caddy_plugins` | list | `[]` | Caddy plugins to build in. Empty → package manager install. Non-empty → xcaddy build. |
| `caddy_version` | string | `""` | Caddy version to build (e.g. `v2.9.1`). Empty means latest. |
| `caddy_xcaddy_version` | string | `""` | xcaddy version to install. Empty means latest from GitHub releases. |
| `caddy_go_version` | string | `""` | Go version to install. Empty means latest stable from go.dev. |
| `caddy_go_install_dir` | string | `"/usr/local/go"` | Directory where Go is installed. |
| `caddy_xcaddy_bin` | string | `"/usr/local/bin/xcaddy"` | Path to the xcaddy binary. |
| `caddy_xcaddy_cleanup` | bool | `true` | Remove Go, xcaddy, and build tarballs after a successful build. Recommended for production. Set to `false` to keep the toolchain for debugging. |

Caddy is rebuilt only when the build spec changes (plugins list or versions). The spec is stored at `{{ caddy_config_dir }}/.xcaddy_build_spec`. After the build, Go and xcaddy are removed by default (`caddy_xcaddy_cleanup: true`), leaving only the Caddy binary on the server.

### Site options

Each entry in `caddy_sites` supports the following keys:

| Name | Type | Default | Description |
| - | - | - | - |
| `hostname` | string | — | **(Required)** Site hostname. |
| `protocol` | string | `https` | Protocol prefix (`http` or `https`). |
| `public` | bool | `false` | Allow access from outside private IP ranges. When `false`, requests from public IPs receive a `403`. |
| `www_redir` | bool | `false` | Redirect `www.hostname` to `hostname`. |
| `proxies` | list | `[]` | Upstream backend addresses (e.g. `192.168.1.10:8443`). If empty, a default `200` response is returned. |
| `insecure_skip_verify` | bool | `false` | Skip TLS certificate verification on the upstream backend. Useful for backends with self-signed certificates. |
| `header_up` | list | `[]` | Headers to set or modify on requests sent upstream to the backend. Prefix with `-` to remove a header (e.g. `-Authorization`). |
| `header_down` | list | `[]` | Headers to set or modify on responses received downstream from the backend. Prefix with `-` to remove a header (e.g. `-Server`). |

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure Caddy.
  hosts: all
  roles:
    - role: caddy
```

Example variable definition:

```yaml
caddy_email: admin@example.com
caddy_sites:
  - hostname: my.domain.com
    proxies:
      - 192.168.1.10:8080

# Install Caddy with a DNS plugin via xcaddy
caddy_plugins:
  - github.com/caddy-dns/cloudflare

  # Backend with a self-signed certificate.
  - hostname: nas.domain.com
    insecure_skip_verify: true
    proxies:
      - 192.168.1.20:8443

  # Backend with custom headers.
  - hostname: app.domain.com
    proxies:
      - 192.168.1.30:3000
    header_up:
      - "X-Forwarded-Proto https"
      - "-Authorization"
    header_down:
      - "-Server"
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calisti.
