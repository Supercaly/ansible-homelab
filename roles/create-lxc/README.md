Ansible Role: create-lxc
=========

An Ansible Role that creates a Proxmox LXC.

Requirements
------------

None.

Role Variables
--------------

Available variables are listed below, along with default values (see 'defaults/main.yml'):

Main LXC settings.

```yaml
lxc_vmid: <id>            # (Required)
lxc_hostname: <hostname>  # (Required)
lxc_password: <pwd>       # (Required)
lxc_appname: lxc_hostname # Human-Readable app name.
```

Template image for the container and where it is stored.

> Check the [official Proxmox repository](http://download.proxmox.com/images/system/) for the available images.

```yaml
lxc_template: "debian-12-standard_12.7-1_amd64.tar.zst"
lxc_template_storage: "local"
```

LXC Hardwere specs.

```yaml
lxc_unprivileged: true
lxc_cores: 1
lxc_memory: 1024
lxc_swap: 512
lxc_features: "keyctl=1,nesting=1"
```

Main Disk specs.

```yaml
lxc_disk_storage: "local-lvm"
lxc_disk_size: 4  # in GB
```

Additional Mount points.

> Note: At the moment it is only possible to define **bind mounts** to some folder in the host device.

```yaml
lxc_mounts: []
# - id: mp0
#   bind: /mnt/binds
#   mount: /shared
```

Network specs.

```yaml
lxc_network: []
# - id: net0
#   name: eth0
#   ip4: 192.168.1.10 # Optional. Available options: valid IPv4 address (to use static) - dhcp (to use DHCP).
#   netmask4: 24      # Optional if IPv4 not indicated.
#   gw4: 192.168.1.1  # Optional.
#   ip6: 200:db8::10  # Optional. Available options: valid IPv6 address (to use static) - dhcp (to use DHCP) - auto (to use SLAAC).
#   netmask6: 64      # Optional if IPv6 not indicated.
#   gw6: 200:db8::1   # Optional.
#   bridge: vmbr0     # Default 'vmbr0'.
#   firewall: false   # Optional.
#   vlan_tag: 200     # Optional.
```

Startup options.

```yaml
lxc_onboot: false
lxc_startup: ""
```

Extra options

```yaml
lxc_nameserver: "" # DNS nameserver.
lxc_pubkey: "" # Path to an SSH key to use for secure connection.
lxc_tags:
  - "ansible"
```

This role also **requires** the following variables to be defined:

```yaml
proxmox_node: <node_name>           # (Required)
proxmox_api_host: <node_ip>         # (Required)
proxmox_api_user: <node_user@realm> # (Required)
proxmox_api_password: <pwd>         # (Required)
proxmox_api_token_id: <id>          # (Required)
proxmox_api_token_secret: <secret>  # (Required)
```

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- name: Create lxc
  hosts: all
  roles:
    - role: create-lxc
```

License
-------

MIT

Author Information
------------------

This role was created in 2025 by Lorenzo Calsti.
