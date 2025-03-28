#!/bin/bash

logfile="/home/tun31934/dicom_backup.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$logfile"
}

mount_drive() {
    if ! mountpoint -q /media/tun31934/dicom-backups; then
        mount /dev/sdf2 /media/tun31934/dicom-backups

        if [ $? -eq 0 ]; then
            log_message "Drive mount: Successful"
        else
            log_message "Drive mount: Failed"
            exit 1
        fi
    else
        log_message "Drive previously mounted"
    fi
}

perform_backup() {
    local backup_start_time=$(date +%s)

    backup_base="/media/tun31934/dicom-backups"
    source_dir="/ZPOOL/data/sourcedata/sourcedata"

    backup_timestamp=$(date '+%Y-%m-%d_%A_backup')
    backup_dest="${backup_base}/${backup_timestamp}"

    latest_backup=$(ls -dt "${backup_base}"/*_backup 2>/dev/null | head -1)

    if [ -n "$latest_backup" ]; then
        log_message "Performing incremental backup using $latest_backup"
        rsync -av --delete --link-dest="$latest_backup" "$source_dir/" "$backup_dest/"
    else
        log_message "Performing initial backup"
        rsync -av --delete "$source_dir/" "$backup_dest/"
    fi

    if [ $? -eq 0 ]; then
        log_message "Backup completed successfully"
        generate_backup_summary "$backup_start_time" "$backup_dest"
    else
        log_message "ERROR: Backup Failed"
    fi
}

generate_backup_summary() {
    local backup_start_time="$1"
    local backup_dest="$2"

    local backup_end_time=$(date +%s)
    local duration=$((backup_end_time - backup_start_time))
    local duration_formatted=$(printf "%d minutes, %d seconds" $((duration/60)) $((duration%60)))

    if [ ! -d "$backup_dest" ]; then
        log_message "Backup destination does not exist. Skipping summary."
        return
    fi

    local total_files=$(find "$backup_dest" -type f | wc -l)
    local total_size=$(du -sh "$backup_dest" | cut -f1)

    {
        echo ""
        echo "BACKUP SUMMARY"
        echo "=============="
        echo "Backup destination: $backup_dest"
        echo "Time elapsed: $duration_formatted"
        echo "Backup Statistics"
        echo "- Total files in backup: $total_files"
        echo "- Backup size: $total_size"
    } >> "$logfile"
}

main() {
    log_message "Backup process started"
    mount_drive
    perform_backup
    log_message "Backup process completed"
}

main
