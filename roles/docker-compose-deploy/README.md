Role Name
=========

An Ansible Role that deploy a Docker Compose stack.

Requirements
------------

Docker Engine and Docker Compose installed on the host machine.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml' for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `compose_project_name` | Yes | string | | Name of the compose project. |
| `compose_target_dir` | | string | `"/compose/{{ compose_project_name }}"` | Path to the project root directory on the host node. |
| `compose_src_dir` | | string | `"{{ playbook_dir }}"` | Path to the root directory on the control node. |
| `compose_files_dir` | | string | `"{{ compose_src_dir }}/files"` | Path to the files directory on the control node. |
| `compose_templates_dir` | | string | `"{{ compose_src_dir }}/templates"` | Path to the templates directory on the control node. |
| `compose_exclude_files` | | list | `[".gitignore", ".gitkeep"]` | List of files to exclude when copying files and templates from the control node to the host node. |
| `compose_pull_images` | | bool | `false` | Pull the latest version of all images defined in the compose stack. <br/>Note: This will pull all the images every time this role is called. Set it to `true` only if you are ok with not updating your images manually. |
| `compose_prune_images` | | bool | `true` | Prune all unused images. <br/>Note: This will prune all Docker images, not only the ones related to this stack. |
| `compose_prune_dangling_images` | | bool | `true` | When `compose_prune_images` is set to `true` will also prune all the dangling images. |
| `compose_owner` | | string | `"root"` | User that owns all files and directories inside the compose project. |
| `compose_group` | | string | `"root"` | Group that owns all files and directories inside the compose project. |
| `compose_mode` | | string | `"0755"` | Mode applied to every file and directory inside the compose project. |

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Create lxc
  hosts: all
  roles:
    - role: docker-compose-deploy
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
