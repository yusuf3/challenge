#!/bin/bash

# Input folder containing log files
input_folder="access-log-edited/"

# Regular expression to match the date format
regex='([0-9]{2})/([a-zA-Z]{3})/([0-9]{4}):([0-9]{2}):([0-9]{2}):([0-9]{2})'

# Loop through each file in the input folder
for input_file in $input_folder*; do

  # Output file name based on input file name
  output_file="$input_file.loop"

  # Loop through each line in the input file
  while read line; do

    # Extract the date string from the line using regular expression matching
    if [[ $line =~ $regex ]]; then
      day=${BASH_REMATCH[1]}
      month=$(date -d "${BASH_REMATCH[2]} 1" +"%m")
      year=${BASH_REMATCH[3]}
      hour=${BASH_REMATCH[4]}
      minute=${BASH_REMATCH[5]}
      second=${BASH_REMATCH[6]}

      # Convert the date string to epoch time
      epoch_time=$(date -d "${year}-${month}-${day}T${hour}:${minute}:${second}" +"%s")

      # Replace the original date string with the epoch time
      line=${line/$BASH_REMATCH/$epoch_time}
    fi
    
    # Write the updated line to the output file
    echo "$line" >> $output_file
    
  done < $input_file

done