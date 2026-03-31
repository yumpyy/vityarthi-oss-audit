#!/bin/bash
 # Script 4: Log File Analyzer
 # Author: Anupam Roy | Course: Open Source Software
 # Description: Reads a log file line by line, counts occurrences of a
 #          	keyword, and prints a summary with matching lines.
 
 # --- Input validation ---
 # $1 is the log file path; exit with error if not provided or file not found
 if [ -z "$1" ]; then
 	echo "Error: Please provide a log file path."
 	echo "Usage: $0 <logfile> [keyword]"
 	echo "Default keyword is 'error' if not specified."
 	exit 1
 fi
 
 LOGFILE="$1"
 # $2 is the keyword; default to "error" if not provided
 KEYWORD="${2:-error}"
 
 if [ ! -f "$LOGFILE" ]; then
 	echo "Error: File '$LOGFILE' not found."
 	exit 1
 fi
 
 # Check if the file is empty; if so, warn and exit
 FILE_LINES=$(wc -l < "$LOGFILE")
 if [ "$FILE_LINES" -eq 0 ]; then
 	echo "Warning: Log file '$LOGFILE' is empty."
 	echo "No analysis possible."
 	exit 1
 fi
 
 # --- Initialise counters ---
 COUNT=0
 MATCHING_LINES=""
 
 # --- Read log file line by line using while loop ---
 echo ""
 echo "========================================"
 echo " 	Log File Analyzer"
 echo "========================================"
 echo ""
 echo "  Log file  : $LOGFILE"
 echo "  Keyword   : $KEYWORD"
 echo "  Total lines: $FILE_LINES"
 echo ""
 echo "  Scanning..."
 echo ""
 
 while IFS= read -r LINE; do
 	# grep -iq performs case-insensitive match
 	if echo "$LINE" | grep -iq "$KEYWORD"; then
     	COUNT=$((COUNT + 1))
     	# Store the last 5 matching lines for summary
     	# Shift approach: keep only last 5 lines in the accumulator
     	if [ -z "$MATCHING_LINES" ]; then
         	MATCHING_LINES="$LINE"
     	else
         	# Append with newline separator
         	MATCHING_LINES="$MATCHING_LINES"$'\n'"$LINE"
     	fi
 	fi
 done < "$LOGFILE"
 
 # --- Output summary ---
 echo "========================================"
 echo "  RESULTS"
 echo "========================================"
 echo ""
 echo "  Keyword '$KEYWORD' found $COUNT times in $LOGFILE"
 echo ""
 
 # --- Print last 5 matching lines ---
 if [ $COUNT -gt 0 ]; then
 	echo "  Last 5 matching lines:"
 	echo "  ----------------------------------------"
 	echo "$MATCHING_LINES" | tail -5 | while read -r ML; do
     	echo "  | $ML"
 	done
 	echo "  ----------------------------------------"
 else
 	echo "  No occurrences of '$KEYWORD' were found."
 fi
 
 echo ""
 echo "========================================"
 echo "  Analysis complete."
 echo "========================================"
