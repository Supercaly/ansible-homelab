#! /bin/bash

echo "GUEST HOOK: $0 $1 $2"

# First argument is the vmid
vmid="$1"

# Second argument is the phase
phase="$2"

case "$phase" in
    pre-start)
        # First phase 'pre-start' will be executed before the guest
        # is started. Exiting with a code != 0 will abort the start
        echo "$vmid is starting, doing preparations."

        # echo "preparations failed, aborting."
        # exit 1
        ;;
    post-start)
        # Second phase 'post-start' will be executed after the guest
        # successfully started.
        echo "$vmid started successfully."
        ;;
    pre-stop)
        # Third phase 'pre-stop' will be executed before stopping the guest
        # via the API. Will not be executed if the guest is stopped from
        # within e.g., with a 'poweroff'
        echo "$vmid will be stopped."
        ;;
    post-stop)
        # Last phase 'post-stop' will be executed after the guest stopped.
        # This should even be executed in case the guest crashes or stopped
        # unexpectedly.
        echo "$vmid stopped. Doing cleanup."
        ;;
    *)
        echo "got unknown phase '$phase'"
        exit 1
esac
