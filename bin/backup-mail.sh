#!/usr/bin/env bash

SOURCE_PATH="mail:/home/user-data/backup/encrypted/"
BACKUP_PATH="/home/maximbaz/decrypted/backup/mail/"

if [ -d "$BACKUP_PATH" ]; then
  echo "Making backup"
  rsync -arv "$SOURCE_PATH" "$BACKUP_PATH"
  exit 0
fi

echo "No backup dir"
exit 1
