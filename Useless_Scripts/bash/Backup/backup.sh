#!/bin/bash
# backup_files.sh - Backup files from a source to a destination directory.
# Usage: ./backup_files.sh /path/to/source /path/to/backup

# Check if correct number of arguments are provided.
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"

# Create backup directory if it doesn't exist.
mkdir -p "$BACKUP_DIR"

# Copy files (using -r for directories, -v for verbose output).
echo "Backing up files from $SOURCE_DIR to $BACKUP_DIR..."
cp -r -v "$SOURCE_DIR"/* "$BACKUP_DIR"

echo "Backup complete!"
