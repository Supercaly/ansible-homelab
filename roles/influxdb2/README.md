Ansible Role: influxdb2
=========

An Ansible Role that installs and sets up [InfluxDB 2](https://influxdata.com) on Linux.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `influxdb2_primary_org` | | string | `"example-org"` | Name of the primary organization created during setup. |
| `influxdb2_primary_bucket` | | string | `"example-bucket"` | Name of the primary bucket created during setup. |
| `influxdb2_primary_username` | | string | `"example-user"` | Admin user created during setup. |
| `influxdb2_primary_password` | | string | `"password123"` | Password of the admin user. |
| `influxdb2_admin_token` | | string | `"ExampleToken"` | Admin operator token. |
| `influxdb2_orgs` | | object | `[]` | Additional organizations. |
| `influxdb2_users` | | object | `[]` | Additional users. |
| `influxdb2_buckets` | | object | `[]` | Additional buckets. |
| `influxdb2_host` | | string | `"http://localhost:8086"` | URL of the InfluxDB APIs. |

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Install influxdb
  hosts: all
  roles:
    - role: influxdb2
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
