# File Renaming Script

This script automatically renames files in a directory with sequential dates and posting times. It's particularly useful for organizing content that needs to be posted at specific times over multiple days.

## Features

- Automatically renames files with dates and posting times
- Supports three posting times per day: 10AM, 01PM, and 03PM
- Skips files that already match the naming pattern
- Handles file extensions automatically
- Prevents overwriting existing files by adding a "unique-" prefix if needed

## Naming Pattern

Files are renamed following this pattern:
```YYYY-MM-DD-TIME-post.extension
```

Example:
```
2024-04-16-10AM-post.jpg
2024-04-16-01PM-post.png
2024-04-16-03PM-post.pdf
```

## Requirements

- Git Bash (for Windows users)
- Bash shell (for Linux/macOS users)

## Usage

1. Place the script (`renames_files.sh`) in the directory containing the files you want to rename
2. Make the script executable:
   ```bash
   chmod +x renames_files.sh
   ```
3. Run the script:
   ```bash
   ./renames_files.sh
   ```

## How It Works

1. The script scans the current directory for files
2. It excludes:
   - The script itself
   - Files that already match the naming pattern
3. Files are processed in order and assigned to:
   - Today's date (first 3 files)
   - Tomorrow's date (next 3 files)
   - The day after tomorrow (next 3 files)
   And so on...

## Notes

- The script uses the system's current date as the starting point
- Each group of 3 files gets the same date
- Times are assigned in sequence: 10AM, 01PM, 03PM
- If a target filename already exists, the script adds a "unique-" prefix

## Example

If you have 6 files in your directory:
```
file1.jpg
file2.png
file3.pdf
file4.jpg
file5.png
file6.pdf
```

Running the script will rename them to:
```
2024-04-16-10AM-post.jpg
2024-04-16-01PM-post.png
2024-04-16-03PM-post.pdf
2024-04-17-10AM-post.jpg
2024-04-17-01PM-post.png
2024-04-17-03PM-post.pdf
```

## Troubleshooting

If you encounter any issues:
1. Make sure the script has execute permissions
2. Ensure you're running it in the correct directory
3. Check that you have files to rename that don't already match the pattern 