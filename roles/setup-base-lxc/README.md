Role Name
=========

An Ansible Role that setup a base LXC.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `lxc_appname` | Yes | string | | Human-readable app name. |
| `lxc_locale` | | string | `en_US.UTF-8` | LXC Locale. |
| `lxc_timezone` | | string | `Europe/Rome` | LXC Timezone. |
| `lxc_test_ping_address` | | string | `"1.1.1.1"` | IP address pinged when testing LXC network conncetion. |
| `lxc_test_dns` | | string | `"github.com"` | Domain name used to test DNS resolution. |
| `lxc_has_shared_user` | | bool | `true` | Control if the LXC has the shared user/group. |
| `lxc_shared_user` | | string | `"shared"` | LXC shared user name. |
| `lxc_shared_group` | | string | `"shared"` | LXC shared group name. |
| `lxc_shared_uid` | | int | `1001` | LXC shared uid. |
| `lxc_shared_gid` | | int | `1001` | LXC shared gid. |
| `lxc_dist_upgrade` | | bool | `true` | Controls whether a dist-update should be performed. |
| `lxc_core_deps` | | list | `["sudo", "curl"]` | Control which core dependencies to install. |

> To reduce LXC setup time the full dist-upgrade can be skipped setting `lxc_dist_upgrade` to `false` when running the playbook.
> Pass `-e lxc_dist_upgrade=false` as a CLI argument to `ansible-playbook`.

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- hosts: all
  roles:
    - role: setup-base-lxc
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
