#! /bin/bash

LOGS=$1
DATE=$(date + %Y_%m_%d)
ARCHIVE_DIR="path/to/new/archive"
ARCHIVE_NAME="logs_archive_$DATE.tar.gz"

mkdir -p "$ARCHIVE_DIR"
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" "$LOGS"