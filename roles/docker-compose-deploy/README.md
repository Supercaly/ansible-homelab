Ansible Role: docker-compose-deploy
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
| `compose_project_name` | Yes | string | | Name of the compose project. Used to create a project directory on the host node. |
| `compose_base_dir` | | string | `"/compose"` | Base directory on the host node where all compose projects are stored. |
| `compose_src_dir` | | string | `"{{ playbook_dir }}"` | Base directory on the control node containing the source files. |
| `compose_files_dir` | | string | `"{{ compose_src_dir }}/files"` | Directory with files to copy from the control node. |
| `compose_templates_dir` | | string | `"{{ compose_src_dir }}/templates"` | Directory with templates to copy from the control node. |
| `compose_exclude_files` | | list | `[".gitignore", ".gitkeep"]` | List of files to exclude during copy operations. |
| `compose_pull_images` | | bool | `false` | Pull the latest version of all images defined in the stack.<br/>Note: This will pull all images every time the role is called. Set it to `true` only if you are ok with not updating your images manually. |
| `compose_prune_images` | | bool | `true` | Prune all unused Docker images. <br/>Note: This will prune all Docker images, not only the ones related to this stack. |
| `compose_prune_dangling_images` | | bool | `true` | When pruning, also remove dangling images. |
| `compose_target_owner` | | string | `"root"` | Owner of the project directory on the host. |
| `compose_target_group` | | string | `"root"` | Group of the project directory on the host. |
| `compose_target_mode` | | string | `"0755"` | Mode of the project directory on the host. |
| `compose_default_owner` | | string | `"root"` | Default owner of copied files and directories. |
| `compose_default_group` | | string | `"root"` | Default group of copied files and directories. |
| `compose_default_mode` | | string | `"0755"` | Default mode of copied files and directories. |
| `compose_files` | | object | `{}` | Dictionary that override ownership or mode per file or directory. |

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
