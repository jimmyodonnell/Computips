#!/usr/bin/env bash

# a command line interface to google drive is available here:
# https://github.com/prasmussen/gdrive

# Just download the binary for your system, and put it in a directory
# I recommend making a directory for programs like this called /Users/your.username/bin
# and make sure that directory is in your PATH variable
# tips: http://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path


# ---   check if you installed drive correctly ---
if hash "drive" 2>/dev/null; then
  echo 'Found Google Drive command line script in' "drive" 'in' $( which "drive" )
else
  echo 'Google Drive executable not found'
  echo 'Google Drive command line executable available here:'
  echo 'https://github.com/prasmussen/gdrive'
  echo 'Must be called "drive" and be stored in a directory in PATH'
fi

# ---   upload a file to google drive ---
# pipe directly from terminal to a new file on drive:
echo "GoodBye World" | drive upload --stdin --title goodbye.txt

# ---   get the ID of a file or directory in your drive   ---
drive list --title "goodbye.txt"
# copy that ID number, something like 0B_rFWkh8Szupc1Vfanp6OVQ3N2s

# ---   delete a file   ---
drive delete --id "0B_rFWkh8Szupc1Vfanp6OVQ3N2s"

# ---   create a directory in your drive   ---
drive folder --title "Haiku"
# copy that ID number, something like 0B_rFWkh8SzupVTV1bHdqYkk1d1E
gdrive_dir="0B_rFWkh8SzupVTV1bHdqYkk1d1E"

# ---   upload files to google drive   ---
# If you want the file to go into a  the ID (long string) of the Google Drive folder to which you'd like to upload files.
# EG: 0B_rFWkh8Szupd1J6US16aW1SMDQ
# EG: 0B_rFWkh8SzupWFNrNDVKVHZNRE0 (temp)

echo \
'The wren
Earns his living
Noiselessly.
- Kobayahsi Issa' > "haiku.txt"

drive upload --file "haiku.txt" --parent "${gdrive_dir}"
drive list --title "haiku.txt"

# ---   another log file example   ---
echo 'This confirms the this file was uploaded on '"$(date)"'.
Results will be uploaded to this directory as they are produced.' | \
drive upload --stdin --title 'upload_confirmation.txt' --parent "${gdrive_dir}"


# Search for folders using the folder-specific MIME type
drive list --max 3 --query "mimeType = 'application/vnd.google-apps.folder'"
