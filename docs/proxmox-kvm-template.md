# Creating a Proxmox KVM Template

This document describes how to create a Proxmox KVM template from a Linux cloud image.
This operation is done manually and rarely — only when a new template is needed or a major version is released.

The template is used by the `create_kvm` role to clone new virtual machines.

## Prerequisites

- Proxmox VE installed and running
- Internet access from the Proxmox node

## Steps

### 1. Download the cloud image

Download the desired cloud image on the Proxmox node:

```bash
cd /var/lib/vz/template/iso/
wget <image-url>
tar -xf <image-name>.tar.xz
rm <image-name>.tar.xz
```

> Cloud images are typically available on the official website of each distribution.

### 2. Create the VM

```bash
qm create <vmid> \
  --name <template-name> \
  --memory 2048 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0
```

### 3. Import and attach the disk

```bash
qm importdisk <vmid> <image-name>.img local-lvm
qm set <vmid> --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-<vmid>-disk-0
qm set <vmid> --boot c --bootdisk scsi0
qm set <vmid> --ide2 local-lvm:cloudinit
qm set <vmid> --serial0 socket --vga serial0
qm set <vmid> --agent 1
```

### 4. Start the VM

```bash
qm start <vmid>
```

### 5. Install required packages of the VM

```bash
apt update && apt upgrade -y
apt install -y qemu-guest-agent python3
apt clean
apt autoremove -y
```

### 6. Clean up before converting to template

```bash
cloud-init clean --logs
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id
shutdown -h now
```

### 7. Convert to template

```bash
qm template <vmid>
```

The VM is now a template and can be cloned by the `create_kvm` role.

## Notes

- The storage `local-lvm` may differ depending on your Proxmox configuration.
- Do not start the VM again after clean up — cloud-init is designed to run on first boot of each clone.
- The template does not need to be updated frequently; Ansible handles package updates and configuration on each clone via the `linux` playbook.
