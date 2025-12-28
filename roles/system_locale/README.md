Ansible Role: system_locale
=========

An Ansible Role that sets system locale and timezone on Linux.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
|`system_locale_lang` | | string | `"en_US.UTF-8"` | Locale string. |
|`system_locale_timezone` | | string | `"UTC"` | Timezone string. |

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Setup locale
  hosts: all
  roles:
    - role: system_locale
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
