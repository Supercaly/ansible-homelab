# Ansible Role: vaultwarden

An Ansible Role that deploys [vaultwarden](https://github.com/dani-garcia/vaultwarden) and [vaultwarden-backup](https://github.com/ttionya/vaultwarden-backup) as a Docker Compose stack.

## Requirements

This role assumes that Docker Engine and Docker Compose are present on the system. You can use the well-known `geerlingguy.docker` role to satisfy these requirements.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list):

| Name | Required | Type | Default | Description |
| - | - | - | - | - |
| `vaultwarden_root` | | string | `"/opt/vaultwarden"` | Root directory where the Vaultwarden stack files and configuration are stored.|
| `vaultwarden_server_version` | | string | `"latest"` | Version of the vaultwarden container. |
| `vaultwarden_backup_version` | | string | `"latest"` | Version of the vaultwarden-backup container. |
| `vaultwarden_restart` | | string | `"unless-stopped"` | Docker container restart policy. |
| `vaultwarden_port` | | int | `8000` | Port exposed by the vaultwarden service. |
| `vaultwarden_timezone` | | string | `"UTC"` | Timezone used by the services. |
| `vaultwarden_config` | | object | `{}` | Dictionary of [Vaultwarden configuration options](https://github.com/dani-garcia/vaultwarden/wiki/Configuration-overview). Keys must match the official environment variable names (case-insensitive). |
| `vaultwarden_rclone_remote_name` | | string | `"BitwardenBackup"` | The name of the Rclone remote. |
| `vaultwarden_rclone_config` | Yes | object | `{}` | Dictionary of [Rclone configuration options](https://rclone.org/overview/). |
| `vaultwarden_backup_dir` | | string | `"/BitwardenBackup"` | The folder where backup files are stored in the storage system. |
| `vaultwarden_rclone_global_flag` | | string | `""` | Rclone global flags. |
| `vaultwarden_backup_cron` | | string | `"0 0 * * *"` | Schedule to run the backup script. |
| `vaultwarden_zip_enable` | | bool | `true` | Pack all backup files into a compressed file. When set to 'false', each backup file will be uploaded independently.|
| `vaultwarden_zip_password` | | string | `"WHEREISMYPASSWORD?"` | The password for the compressed file. Note that the password will always be used when packing the backup files. |
| `vaultwarden_zip_type` | | string | `"zip"` | Default: `zip` (only support `zip` and `7z` formats). |
| `vaultwarden_backup_file_suffix` | | string | `"%Y%m%d"` | Suffix appended to the backup file name. |
| `vaultwarden_backup_keep_days` | | string | `0` | Only keep last a few days backup files in the storage system. Set to 0 to keep all backup files.|
| `vaultwarden_ping_url` | | string | `""` | The URL to which the request is sent after the backup is completed. |
| `vaultwarden_ping_url_curl_options` | | string | `""` | Curl options used with `vaultwarden_ping_url`. |
| `vaultwarden_ping_url_when_start` | | string | `""` | The URL to which the request is sent when the backup starts.|
| `vaultwarden_ping_url_when_start_curl_options` | | string | `""` | Curl options used with `vaultwarden_ping_url_when_start`. |
| `vaultwarden_ping_url_when_success` | | string | `""` | The URL to which the request is sent after the backup is successful. |
| `vaultwarden_ping_url_when_success_curl_options` | | string | `""` | Curl options used with `vaultwarden_ping_url_when_success`. |
| `vaultwarden_ping_url_when_failure` | | string | `""` | The URL to which the request is sent after the backup fails. |
| `vaultwarden_ping_url_when_failure_curl_options` | | string | `""` | Curl options used with `vaultwarden_ping_url_when_failure`. |
| `vaultwarden_mail_smtp_enable` | | bool | `false` | Enable sending mail. |
| `vaultwarden_mail_smtp_variables` | | string | `""` | Mail sending options. |
| `vaultwarden_mail_to` | | string | `""` | The recipient of the notification email. |
| `vaultwarden_mail_when_success` | | bool | `true` | Send an email when the backup completes successfully. |
| `vaultwarden_mail_when_failure` | | bool | `true` | Send an email if the backup fails. |
| `vaultwarden_mail_force_thread` | | bool | `false` | Particularly useful when mail clients fail to group related messages in conversation view despite identical subjects.|

## Dependencies

This role depends on `docker_compose` for deploying the service as a Docker Compose stack.

## Example Playbook

```yaml
- name: Deploy vaultwarden service.
  hosts: all
  roles:
    - role: vaultwarden
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calsti.
