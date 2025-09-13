Ansible Role: caddy
=========

An Ansible Role that installs and configure [Caddy](https://caddyserver.com/) reverse proxy on Linux.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`caddy_config_dir`| | string | `"/etc/caddy"` | Path to the caddy config directory.|
|`caddy_log_dir` | | string | `"/var/log/caddy"` | Path to caddy logs directory. |
|`caddy_caddyfile_file` | | string | `"{{ caddy_config_dir }}/Caddyfile"` | Path to the Caddyfile. |
|`caddy_sites_dir` | | string | `"{{ caddy_config_dir }}/sites"` | Path to the directory containing additional sites. |
|`caddy_rm_unmanaged_sites` | | bool | `true` | Automatically remove old sites files not present in the config. |
|`caddy_debug` | | bool | `false` | Enable debug mode. |
|`caddy_admin` | | string | `"localhost:2019"` | Customize the admin API endpoint. If set to `off` the admin endpoint is disabled. |
|`caddy_email` | | string | `""` | Email address used when creating an ACME account with the Let's Encrypt CA. |
|`caddy_local_certs` | | bool | `false` | Issue all certificates internally, rather than through a public ACME CA. |
|`caddy_ca` | | string | `"default"` | ACME endpoint to use [default, staging]. |
|`caddy_default_ca` | | string |`"https://acme-v02.api.letsencrypt.org/directory"` | Default ACME API endpoint. |
|`caddy_staging_ca` | | string | `"https://acme-staging-v02.api.letsencrypt.org/directory"` | Staging ACME API endpoint. |
|`caddy_sites` | | object | `[]` | List of additional sites. |

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Install Caddy.
  hosts: all
  roles:
    - role: caddy
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calisti.
