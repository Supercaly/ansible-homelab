# Ansible Role: nut

An Ansible Role that installs and configures [NUT (Network UPS Tools)](https://networkupstools.org/) on Linux.

The role manages:

- NUT operating mode (`standalone`, `netserver`, `netclient`)
- UPS driver configuration (`ups.conf`)
- `upsd` listen addresses and users (`upsd.conf`, `upsd.users`)
- UPS monitoring (`upsmon.conf`)
- Event-based scheduling via `upssched` (`upssched.conf`, optional)
- `upssched` state directory via `tmpfiles.d` (optional)
- Service lifecycle (enable, start, restart on config change)

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml` for a complete list).

### General

| Name | Default | Description |
| - | - | - |
| `nut_mode` | `standalone` | NUT operating mode. One of `standalone`, `netserver`, `netclient`. |
| `nut_config_dir` | `/etc/nut` | Path to the NUT configuration directory. |
| `nut_service_enabled` | `true` | Whether NUT services should be enabled and started. |

### UPS drivers — `ups.conf` (standalone / netserver only)

`nut_ups_list` is a list of UPS devices to configure. Each entry maps to a `[name]` block in `ups.conf`.

| Key | Required | Type | Default | Description |
| - | - | - | - | - |
| `name` | Yes | string | | UPS identifier used throughout NUT (e.g. `myups`). |
| `driver` | Yes | string | | NUT driver to use (e.g. `usbhid-ups`, `blazer_usb`). |
| `port` | Yes | string | | Device port (e.g. `auto`, `/dev/ttyS0`). |
| `desc` | | string | | Human-readable description of the UPS. |
| `options` | | dict | `{}` | Additional driver-specific options written as `key = value` lines. |

### upsd listen addresses — `upsd.conf` (netserver only)

`nut_upsd_listen` is a list of raw `LISTEN` arguments written verbatim into `upsd.conf`. Each entry is a string with the address and optionally the port (space-separated).

```yaml
nut_upsd_listen:
  - "127.0.0.1 3493"
  - "0.0.0.0"       # NUT defaults to port 3493
```

### upsd users — `upsd.users` (standalone / netserver only)

`nut_users` is a list of users allowed to connect to `upsd`.

| Key | Required | Type | Default | Description |
| - | - | - | - | - |
| `name` | Yes | string | | Username. |
| `password` | Yes | string | | Password. Store this in a vault file. |
| `upsmon` | | string | | Grant `upsmon` access with the given role. One of `primary` (formerly `master`) or `secondary` (formerly `slave`). |
| `actions` | | list | | Allowed actions (e.g. `[SET]`). |
| `instcmds` | | list | | Allowed instant commands (e.g. `[ALL]`, `[test.battery.start]`). |

### UPS monitoring — `upsmon.conf` (all modes)

`nut_monitor_list` is a list of UPS systems for `upsmon` to monitor. Each entry maps to a `MONITOR` line.

| Key | Required | Type | Default | Description |
| - | - | - | - | - |
| `ups` | Yes | string | | UPS identifier in `name@host` format (e.g. `myups@localhost`, `myups@192.168.1.10`). |
| `powervalue` | | int | `1` | Number of power supplies this UPS feeds. |
| `username` | Yes | string | | Username from `nut_users` to authenticate with. |
| `password` | Yes | string | | Password for the user above. |
| `type` | Yes | string | | Role of this host. One of `primary` (formerly `master`) or `secondary` (formerly `slave`). |

Global `upsmon` directives:

| Name | Default | Description |
| - | - | - |
| `nut_minsupplies` | `1` | Minimum number of power supplies that must be online before `upsmon` initiates shutdown. |
| `nut_shutdowncmd` | `/sbin/shutdown -h +0` | Command executed when the UPS reaches a critical state. |
| `nut_powerdownflag` | `/etc/killpower` | Flag file that tells the init system to cut power after shutdown. |
| `nut_finaldelay` | `5` | Seconds to wait after `SHUTDOWNCMD` before cutting power. |
| `nut_hostsync` | `15` | Seconds `upsmon` waits for secondaries to disconnect before the primary shuts down. |
| `nut_pollfreq` | `5` | Seconds between normal UPS polls. |
| `nut_pollfreqalert` | `5` | Seconds between polls when the UPS is on battery. |
| `nut_deadtime` | `15` | Seconds without a response before the UPS is considered dead. |
| `nut_rbwarntime` | `43200` | Seconds between "replace battery" warnings (default 12 h). |
| `nut_nocommwarntime` | `300` | Seconds between "no communication" warnings. |
| `nut_notifycmd` | `""` | Path on the target to the script called on notify events. Ignored when `nut_upssched_enabled` is `true` (upssched is used instead). |
| `nut_notifycmd_src` | `""` | Local path (on the controller) to a script to copy as-is to `nut_notifycmd` on the target. When empty, the script is not managed by the role. Ignored when `nut_upssched_enabled` is `true`. |

#### Notifications

`nut_notifymsg` overrides the default message for a notify event:

| Key | Required | Type | Description |
| - | - | - | - |
| `event` | Yes | string | NUT event name (e.g. `ONBATT`, `ONLINE`, `LOWBATT`). |
| `msg` | Yes | string | Message string. |

`nut_notifyflags` controls how `upsmon` delivers a notification:

| Key | Required | Type | Description |
| - | - | - | - |
| `event` | Yes | string | NUT event name. |
| `flags` | Yes | list | One or more of `SYSLOG`, `WALL`, `EXEC`, `IGNORE`. |

### Event scheduling — `upssched.conf` (optional, all modes)

| Name | Default | Description |
| - | - | - |
| `nut_upssched_enabled` | `false` | Enable `upssched` support. When `true`, `upsmon` calls `upssched` as its `NOTIFYCMD`. |
| `nut_upssched_cmdscript` | `/etc/nut/upssched-cmd` | Path to the command script called by `upssched` on the target host. |
| `nut_upssched_statedir` | `/run/nut/upssched` | Directory used by the `upssched-cmd` script to store state files. Created via `tmpfiles.d` so it persists across reboots. |
| `nut_upssched_pipefn` | `/run/nut/upssched.pipe` | Named pipe used by `upssched` for IPC. |
| `nut_upssched_lockfn` | `/run/nut/upssched.lock` | Lock file path. |
| `nut_upssched_cmdscript_src` | `""` | Local path (on the controller) to a script to copy as-is to `nut_upssched_cmdscript` on the target. When empty, the script is not managed by the role. |

`nut_upssched_at` is a list of raw `AT` lines written verbatim into `upssched.conf`. Each entry is a string following the NUT syntax: `AT <event> <upsname> <condition> [<name>] [<time>]`.

```yaml
nut_upssched_at:
  - "AT ONBATT * START-TIMER shutdown 300"
  - "AT ONLINE * CANCEL-TIMER shutdown"
  - "AT LOWBATT * EXECUTE shutdown"
```

## Dependencies

None.

## Example Playbook

### Standalone (single machine, local UPS)

```yaml
# host_vars/myhost/nut.yml
nut_mode: standalone

nut_ups_list:
  - name: myups
    driver: usbhid-ups
    port: auto
    desc: "APC Back-UPS 1500"

nut_users:
  - name: monmaster
    password: "{{ vault_nut_monmaster_pass }}"
    upsmon: primary

nut_monitor_list:
  - ups: myups@localhost
    username: monmaster
    password: "{{ vault_nut_monmaster_pass }}"
    type: primary
```

### Server (shares the UPS over the network)

```yaml
# host_vars/ups-server/nut.yml
nut_mode: netserver

nut_ups_list:
  - name: myups
    driver: usbhid-ups
    port: auto
    desc: "APC Back-UPS 1500"

nut_upsd_listen:
  - "0.0.0.0 3493"

nut_users:
  - name: monmaster
    password: "{{ vault_nut_monmaster_pass }}"
    upsmon: primary
  - name: monslave
    password: "{{ vault_nut_monslave_pass }}"
    upsmon: secondary

nut_monitor_list:
  - ups: myups@localhost
    username: monmaster
    password: "{{ vault_nut_monmaster_pass }}"
    type: primary
```

### Client (monitors a remote UPS server)

```yaml
# host_vars/myhost/nut.yml
nut_mode: netclient

nut_monitor_list:
  - ups: myups@192.168.1.10
    username: monslave
    password: "{{ vault_nut_monslave_pass }}"
    type: secondary
```

### With upssched (graceful shutdown after 5 minutes on battery)

```yaml
nut_upssched_enabled: true
nut_upssched_cmdscript_src: files/nut/upssched-cmd

nut_upssched_at:
  - "AT ONBATT * START-TIMER shutdown 300"
  - "AT ONLINE * CANCEL-TIMER shutdown"

nut_notifyflags:
  - event: ONBATT
    flags: [SYSLOG, EXEC]
  - event: ONLINE
    flags: [SYSLOG, EXEC]
```

## License

MIT

## Author Information

This role was created in 2026 by Lorenzo Calisti.
