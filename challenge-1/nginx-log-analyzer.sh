#!/bin/bash

# Set the directory containing the log files
log_dir="access-log-edited1"

# Set the current time and the time 10 minutes ago in epoch format
current_time=$(date +%s)
ten_minutes_ago=$(date -d "10 minutes ago" +%s)

# Loop through each log file in the directory
for log_file in "$log_dir"/*; do

  # Initialize the error count to zero
  error_count=0

  # Loop through each line in the log file
  while read line; do

    # Extract the date and status code from the line
    date=$(echo "$line" | awk '{print $4}' | sed 's/\[//')
    status_code=$(echo "$line" | awk '{print $9}')

    # Check if the line is within the last 10 minutes and has a status code of 500
    if [[ $date -gt $ten_minutes_ago && $status_code -eq 500 ]]; then
      error_count=$((error_count+1))
    fi

  done < "$log_file"

  # Print the error count for the current log file
  echo "There were $error_count HTTP 500 errors in $log_file in the last 10 minutes."

done
