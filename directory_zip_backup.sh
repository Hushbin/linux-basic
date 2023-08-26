#!/bin/bash

# Create a zip archive named [archive_name].zip of [source_directory] and save the archive in [destination_directory] on [Server_name].

zip -r /[destination_directory]/[archive_name].zip [source_directory]

# Copy the created archive to [Your_backup_server] server in /backup/ location.

scp /[destination_directory]/[archive_name].zip [user_name]@[Your_backup_server]:/backup

