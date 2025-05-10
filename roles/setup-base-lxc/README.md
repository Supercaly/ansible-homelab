Role Name
=========

An Ansible Role that setup a base LXC.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml'):

Set locale and timezone.

```yaml
lxc_locale: en_US.UTF-8
lxc_timezone: Europe/Rome
```

Test network connection and DNS resulution.

```yaml
lxc_test_ping_address: "1.1.1.1"
lxc_test_dns: "github.com"
```

Setup shared data user and group.

```yaml
lxc_has_shared_user: true # control if the shared user/group is set.
lxc_shared_user: "shared_data"
lxc_shared_uid: 3500
lxc_shared_group: "shared_data"
lxc_shared_gid: 3500
```

This Role also **requires** the following variables to be defined:

```yaml
lxc_appname: <human_app_name> # (Required) Human-Readable app name.

```

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
