#!/bin/sh

set -eu

# Environment variables automatically passed by upsmon/upssched:
# $UPSNAME, $NOTIFYTYPE, $NOTIFYMSG
EVENT="${1:-unknown}"
UPS="${UPSNAME:-unknown-ups}"
HOST="$(hostname -f 2>/dev/null || hostname)"
STATE_DIR="/run/nut/upssched"

log() {
    logger -t upssched-cmd -p daemon.notice "$1"
}

send_mail() {
    SUBJECT="$1"
    BODY="$2"
    # Background external notification calls so upssched never blocks
    (
        printf "Subject: %s\n\n%s\n" "$SUBJECT" "$BODY" | /usr/sbin/sendmail -t root
    ) >/dev/null 2>&1 &
}

case "$EVENT" in
    onbatt_alert)
        # Create a state flag so we only send a "restored" alert if an outage alert was actually sent
        touch "${STATE_DIR}/${UPS}.onbatt"
        CHARGE="$(upsc "$UPS" battery.charge 2>/dev/null || echo 'N/A')"
        RUNTIME="$(upsc "$UPS" battery.runtime 2>/dev/null || echo 'N/A')"
        MSG="UPS ${UPS} on ${HOST} is ON BATTERY (Charge: ${CHARGE}%, Est. Runtime: ${RUNTIME}s)."
        log "$MSG"
        send_mail "[WARNING] UPS On Battery: ${HOST}" "$MSG"
        ;;

    online_restored)
        # Only notify if the 15-second onbatt_alert timer had previously fired
        if [ -f "${STATE_DIR}/${UPS}.onbatt" ]; then
            rm -f "${STATE_DIR}/${UPS}.onbatt"
            CHARGE="$(upsc "$UPS" battery.charge 2>/dev/null || echo 'N/A')"
            MSG="Utility power restored to ${UPS} on ${HOST} (Battery Charge: ${CHARGE}%)."
            log "$MSG"
            send_mail "[OK] Power Restored: ${HOST}" "$MSG"
        else
            log "Brief power flicker on ${UPS} resolved on time; alert suppressed."
        fi
        ;;

    early_shutdown)
        MSG="UPS ${UPS} on ${HOST} has been on battery for some time. Initiating clean system shutdown."
        log "$MSG"
        send_mail "[CRITICAL] UPS Timed Shutdown: ${HOST}" "$MSG"
        /usr/sbin/upsmon -c fsd
        ;;

    critical_shutdown)
        CHARGE="$(upsc "$UPS" battery.charge 2>/dev/null || echo 'N/A')"
        RUNTIME="$(upsc "$UPS" battery.runtime 2>/dev/null || echo 'N/A')"
        MSG="UPS ${UPS} on ${HOST} reached LOW BATTERY (Charge: ${CHARGE}%, Est. Runtime: ${RUNTIME}s). Initiating immediate forced shutdown."
        log "$MSG"
        send_mail "[EMERGENCY] UPS Low Battery Shutdown: ${HOST}" "$MSG"
        /usr/sbin/upsmon -c fsd
        ;;

    comm_lost)
        touch "${STATE_DIR}/${UPS}.commbad"
        MSG="Lost communication with UPS ${UPS} on ${HOST}."
        log "$MSG"
        send_mail "[WARNING] UPS Communication Lost: ${HOST}" "$MSG"
        ;;

    comm_restored)
        if [ -f "${STATE_DIR}/${UPS}.commbad" ]; then
            rm -f "${STATE_DIR}/${UPS}.commbad"
            MSG="Communication restored with UPS ${UPS} on ${HOST}."
            log "$MSG"
            send_mail "[OK] UPS Communication Restored: ${HOST}" "$MSG"
        fi
        ;;

    replace_battery)
        echo "$NOW" > "$FLAG_FILE"
        BATT_DATE="$(upsc "$UPS" battery.date 2>/dev/null || echo 'Unknown')"
        CHARGE="$(upsc "$UPS" battery.charge 2>/dev/null || echo 'N/A')"
        MSG="UPS ${UPS} on ${HOST} signals REPLACE BATTERY (Charge: ${CHARGE}%, Battery date: ${BATT_DATE})."
        log "$MSG"
        send_mail "[MAINTENANCE] Replace UPS Battery: ${HOST}" "$MSG"
        ;;

    *)
        log "Unrecognized upssched command received: '${EVENT}' for ${UPS}"
        ;;
esac

exit 0
