#!/bin/bash

# Script to rename files in the current directory through three posting times:
# 10AM today, 01PM tomorrow, and 03PM the day after tomorrow

# Function to get date in YYYY-MM-DD format with offset
get_date() {
    local days_offset=$1
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS date command
        date -v +"$days_offset"d +"%Y-%m-%d"
    else
        # Linux date command
        date -d "+$days_offset days" +"%Y-%m-%d"
    fi
}

# Get all files in current directory excluding the script itself
files=()
for f in *; do
    # Check if it's a regular file and not this script
    if [ -f "$f" ] && [ "$f" != "$(basename "$0")" ]; then
        # Skip files that already match our naming pattern
        if [[ ! "$f" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-(10AM|01PM|03PM)-post\. ]]; then
            files+=("$f")
        fi
    fi
done

# Check if we found any files to process
if [ ${#files[@]} -eq 0 ]; then
    echo "No valid files found to process."
    echo "Make sure there are files in the current directory that don't already match the naming pattern."
    exit 1
fi

echo "Found ${#files[@]} files to process:"
for f in "${files[@]}"; do
    echo "- $f"
done
echo ""

# Process each file with the appropriate time format
for ((i=0; i<${#files[@]}; i++)); do
    file="${files[$i]}"
    echo "Processing file $((i+1))/${#files[@]}: $file"
    
    # Make sure the file exists (double check)
    if [ ! -f "$file" ]; then
        echo "  → Error: File no longer exists, skipping"
        continue
    fi
    
    # Extract file extension
    extension="${file##*.}"
    
    # Calculate the day offset and time format based on file index
    day_offset=$((i / 3))  # Each group of 3 files gets the same date
    time_index=$((i % 3))  # Cycle through 0,1,2 for 10AM, 01PM, 03PM
    
    # Get the date for this file
    date=$(get_date $day_offset)
    
    # Define the posting times
    POSTING_TIMES=("10AM" "01PM" "03PM")
    time="${POSTING_TIMES[$time_index]}"
    
    # Create the new filename
    new_filename="${date}-${time}-post.${extension}"
    
    echo "  → Renaming '$file' to '$new_filename'"
    
    # Check if target filename already exists
    if [ -f "$new_filename" ]; then
        echo "    Warning: Target file '$new_filename' already exists, using unique name"
        new_filename="unique-${new_filename}"
    fi
    
    # Rename file
    if mv -- "$file" "$new_filename"; then
        echo "    Success: Renamed to '$new_filename'"
    else
        echo "    Error: Failed to rename file"
    fi
    
    echo "------------------------------------------------------"
done

echo "Process completed. All files have been renamed with sequential dates and times."