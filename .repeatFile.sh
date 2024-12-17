#!/bin/bash
# Function to find duplicate files
find_duplicate_files() {
  # Associative array to store file sizes and their corresponding hashes
  declare -A files

  # Find all files in the specified directory and its subdirectories
  find "$1" -type f -print0 | while IFS= read -r -d '' file; do
    # Calculate file size and hash of the first 1KB
    size=$(stat -c '%s' "$file")
    hash=$(head -c 1024 "$file" | sha256sum | awk '{print $1}')
    
    # Create a unique identifier combining size and hash
    identifier="$size-$hash"
    
    # Check if this identifier already exists in the associative array
    if [[ -n ${files[$identifier]} ]]; then
      # If it does, this is a duplicate file
      echo "Duplicate File: $file (matches ${files[$identifier]})"
    else
      # Otherwise, store the identifier for future comparison
      files[$identifier]="$file"
    fi
  done
}

# Check if a directory argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Check if the provided path is a directory
if [ ! -d "$1" ]; then
  echo "Error: '$1' is not a directory."
  exit 1
fi

# Call the function to find duplicate files
find_duplicate_files "$1"

