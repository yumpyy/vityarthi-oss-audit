#!/bin/bash
 # Script 3: Disk and Permission Auditor
 # Author: Anupam Roy | Course: Open Source Software
 # Description: Loops through a list of important system directories,
 #          	reports their permissions, owner, group, and disk usage.
 #          	Also checks for Firefox-specific directories.
 
 # --- Directories to audit ---
 DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")
 
 # --- Firefox-specific directories ---
 FIREFOX_DIRS=("$HOME/.mozilla" "/usr/lib/firefox" "/usr/bin/firefox")
 
 # --- Header ---
 echo "========================================"
 echo " 	Disk and Permission Auditor"
 echo "========================================"
 echo ""
 
 # --- Loop through standard directories ---
 echo "--- Standard System Directories ---"
 echo ""
 for DIR in "${DIRS[@]}"; do
 	if [ -d "$DIR" ]; then
     	# ls -ld gives directory metadata: permissions, links, owner, group, size, date
     	# awk extracts fields 1 (permissions), 3 (owner), 4 (group)
     	PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
     	# du -sh gives human-readable total size of directory
     	SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
     	# ls -ld again to get the full permission string with numeric mode
     	PERM_STR=$(ls -ld "$DIR" | awk '{print $1}')
     	# Extract the numeric permissions using stat
     	NUM_PERMS=$(stat -c "%a" "$DIR" 2>/dev/null || echo "N/A")
     	echo "  Directory : $DIR"
     	echo "  Permissions: $PERM_STR ($NUM_PERMS)"
     	echo "  Owner:Group: $PERMS"
     	echo "  Size   	: $SIZE"
     	echo ""
 	else
     	echo "  [WARNING] $DIR does not exist on this system."
     	echo ""
 	fi
 done
 
 # --- Firefox-specific audit ---
 echo "--- Firefox Installation Directories ---"
 echo ""
 for FDIR in "${FIREFOX_DIRS[@]}"; do
 	if [ -e "$FDIR" ]; then
     	FPERMS=$(ls -ld "$FDIR" | awk '{print $1, $3, $4}')
     	FSIZE=$(du -sh "$FDIR" 2>/dev/null | cut -f1 || echo "N/A")
     	F_NUM=$(stat -c "%a" "$FDIR" 2>/dev/null || echo "N/A")
     	echo "  Firefox path : $FDIR"
     	echo "  Permissions  : $(ls -ld "$FDIR" | awk '{print $1}') ($F_NUM)"
     	echo "  Owner:Group  : $FPERMS"
     	echo "  Size     	: $FSIZE"
     	echo ""
 	else
     	echo "  [INFO] $FDIR not found on this system."
     	echo ""
 	fi
 done
 
 echo "========================================"
 echo "  Audit complete."
 echo "========================================"
