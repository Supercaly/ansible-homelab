# Ansible Role: influxdb2

An Ansible Role that installs and configure [InfluxDB 2](https://influxdata.com) on Linux.

The role manages:

- InfluxDB 2 installation
- Initial setup (organization, bucket, admin user, token)
- Creation of additional organizations, users, and buckets

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `influxdb2_host` | string | `"http://localhost:8086"` | URL of the InfluxDB APIs. |
| `influxdb2_primary_username` | string | `"example-user"` | Admin user created during setup. |
| `influxdb2_primary_password` | string | `"password123"` | Password of the admin user. |
| `influxdb2_primary_org` | string | `"example-org"` | Name of the primary organization created during setup. |
| `influxdb2_primary_bucket` | string | `"example-bucket"` | Name of the primary bucket created during setup. |
| `influxdb2_admin_token` | string | `"ExampleToken"` | Admin operator token. |
| `influxdb2_orgs` | object | `[]` | Additional organizations. |
| `influxdb2_users` | object | `[]` | Additional users. |
| `influxdb2_buckets` | object | `[]` | Additional buckets. |

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure InfluxDB.
  hosts: all
  roles:
    - role: influxdb2
```

Example variable definition:

```yaml
influxdb2_primary_org: homelab
influxdb2_primary_bucket: metrics
influxdb2_primary_username: admin
influxdb2_primary_password: "{{ vault_influxdb2_primary_password }}"
influxdb2_admin_token: "{{ vault_influxdb2_admin_token }}"
```

## License

MIT

## Author Information

This role was created in 2025 by Lorenzo Calsti.
