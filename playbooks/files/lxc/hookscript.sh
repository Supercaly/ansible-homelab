#!/usr/bin/env bash
set -euo pipefail

USER_NAME="ansible"

log() {
  echo "[hookscript] $*"
}

user_exists() {
  "${EXEC_CMD[@]}" id "$USER_NAME" &>/dev/null
}

install_deps() {
  log "Installing dependencies."
  "${EXEC_CMD[@]}" \
    env DEBIAN_FRONTEND=noninteractive \
    apt-get update -yqq \
    > /dev/null
  "${EXEC_CMD[@]}" \
    env DEBIAN_FRONTEND=noninteractive \
    apt-get install -yqq \
    sudo \
    openssh-server \
    > /dev/null

  log "Enabling SSH service."
  "${EXEC_CMD[@]}" systemctl enable --now ssh
}

create_user() {
  log "Creating user '$USER_NAME'."
  "${EXEC_CMD[@]}" useradd \
    --create-home \
    --shell /bin/bash \
    "$USER_NAME"
  # Disable password login
  "${EXEC_CMD[@]}" passwd -l "$USER_NAME"
}

configure_ssh() {
  if "${EXEC_CMD[@]}" test -s /root/.ssh/authorized_keys; then
    log "Copying root SSH authorized_keys to '$USER_NAME'."
    "${EXEC_CMD[@]}" bash -c "
      mkdir -p /home/${USER_NAME}/.ssh
      cp /root/.ssh/authorized_keys /home/${USER_NAME}/.ssh/authorized_keys
      chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/.ssh
      chmod 700 /home/${USER_NAME}/.ssh
      chmod 600 /home/${USER_NAME}/.ssh/authorized_keys
    "
  else
    log "WARNING: No root SSH key found, skipping SSH setup."
    log "WARNING: You will NOT be able to SSH as user '$USER_NAME'!"
  fi
}

configure_sudo() {
  log "Configuring passwordless sudo for '$USER_NAME'."
  local sudoers_file="/etc/sudoers.d/management"
  "${EXEC_CMD[@]}" bash -c "
    echo '${USER_NAME} ALL=(ALL) NOPASSWD: ALL' > ${sudoers_file}
    chmod 440 ${sudoers_file}
    visudo -cf ${sudoers_file}
  "
}

main() {
  # Argument validation
  if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <vmid> <phase>" >&2
    exit 1
  fi

  # Global variables
  VMID="$1"
  PHASE="$2"
  EXEC_CMD=(pct exec "$VMID" --)

  case "$PHASE" in
    post-start)
      if user_exists; then
        log "Management user '$USER_NAME' already configured, skipping bootstrap."
      else
        log "Starting bootstrap for user '$USER_NAME' on CT $VMID."
        install_deps
        create_user
        configure_sudo
        configure_ssh
        log "Bootstrap completed successfully."
      fi
      ;;
    pre-start | post-stop | pre-stop)
      log "Phase '$PHASE': nothing to do."
      ;;
    *)
      log "ERROR: Unknown phase '$PHASE'." >&2
      exit 1
      ;;
  esac
}

main "$@"
