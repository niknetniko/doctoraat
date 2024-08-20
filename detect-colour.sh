#!/usr/bin/env bash

#set -x  # Enable tracing for debugging

# Check if a filename is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"

# Run Ghostscript with INKCOV device and use process substitution
while read -r line; do
  # Extract page number and CMYK values using regex
  if [[ $line =~ Page\ ([0-9]+) ]]; then
    page_number=${BASH_REMATCH[1]}
#    echo "DEBUG: Page number = $page_number"  # Debugging output
  elif [[ $line =~ ^([0-9.]+)[[:space:]]+([0-9.]+)[[:space:]]+([0-9.]+)[[:space:]]+([0-9.]+)[[:space:]]+CMYK\ OK$ ]]; then
    c_value=${BASH_REMATCH[1]}
    m_value=${BASH_REMATCH[2]}
    y_value=${BASH_REMATCH[3]}
#    echo "DEBUG: CMY values = $c_value $m_value $y_value"  # Debugging output

    # Check if any of CMY values are non-zero
    if (( $(echo "$c_value > 0.00001" | bc -l) )) ||  (( $(echo "$m_value > 0.00001" | bc -l) )) || (( $(echo "$y_value > 0.00001" | bc -l) )); then
      echo "Color page: $page_number"
    fi
  fi
done < <(gs -o - -sDEVICE=inkcov "$filename")
