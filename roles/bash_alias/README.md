# Ansible Role: bash_alias

An Ansible Role that configures bash aliases on Linux.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Type | Default | Description |
| - | - | - | - |
| `bash_alias_aliases` | dict | `{}` | Map of alias name to command. |
| `bash_alias_file_path` | string | `~/.bash_aliases` | Path for the aliases file. |

## Dependencies

None.

## Example Playbook

```yaml
- name: Configure bash aliases.
  hosts: all
  roles:
    - role: bash_alias
```

Example variable definition:

```yaml
bash_alias_file_path: "/home/admin/.bash_aliases"

bash_alias_aliases:
  ll: "ls -la"
  la: "ls -A"
  grep: "grep --color=auto"
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
