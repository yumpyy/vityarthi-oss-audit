#!/bin/bash
# Script 1: System Identity Report
# Author: Anupam Roy | Course: Open Source Software
# Description: Displays Linux system identity information including
#              kernel version, user details, uptime, and OS license.

# --- Variables ---
STUDENT_NAME="Anupam Roy"
SOFTWARE_CHOICE="Mozilla Firefox"

# --- System information extraction ---
# uname -r gives the kernel version
KERNEL=$(uname -r)
# whoami returns the current logged-in username
USER_NAME=$(whoami)
# uptime -p gives a human-readable uptime summary
UPTIME=$(uptime -p)
# date + renders the current date and time in a readable format
CURRENT_DATE=$(date '+%d %B %Y at %H:%M:%S')
# hostnamectl provides the operating system name; grep filters to the relevant line
DISTRO=$(hostnamectl | grep "Operating System" | cut -d: -f2 | xargs)
# /etc/os-release contains the license information; grep extracts it
OS_LICENSE=$(grep "^LICENSE=" /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')

# --- Display ---
echo "======================================"
echo "  Open Source Audit — $STUDENT_NAME"
echo "======================================"
echo ""
echo "  Chosen Software : $SOFTWARE_CHOICE"
echo "  Distribution    : $DISTRO"
echo "  Kernel          : $KERNEL"
echo "  User            : $USER_NAME"
echo "  Home Directory  : $HOME"
echo "  Uptime          : $UPTIME"
echo "  Date & Time     : $CURRENT_DATE"
echo "  OS License      : $OS_LICENSE"
echo ""
echo "======================================"
echo "  Open source powers this system."
echo "======================================"
