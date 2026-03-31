#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Anupam Roy | Course: Open Source Software
# Description: Checks if specified packages are installed, displays
#              their version and licence, and prints a philosophy note.
#              Updated to support RPM (Fedora/RHEL), DPKG (Debian/Ubuntu), 
#              and PACMAN (Arch Linux).

# --- Package list to inspect ---
PACKAGES=("firefox" "httpd" "mysql" "python")

# --- Function to inspect a single package ---
inspect_package() {
    local PKG="$1"
    echo ""
    echo "========================================"
    echo "  Inspecting package: $PKG"
    echo "========================================"

    # Determine which package manager is available
    if command -v rpm &>/dev/null; then
        # RPM-based distribution (Fedora, RHEL)
        if rpm -q "$PKG" &>/dev/null; then
            echo "  [FOUND] $PKG is installed."
            echo ""
            VERSION=$(rpm -qi "$PKG" | grep "^Version" | cut -d: -f2 | xargs)
            LICENCE=$(rpm -qi "$PKG" | grep "^License" | cut -d: -f2 | xargs)
            SUMMARY=$(rpm -qi "$PKG" | grep "^Summary" | cut -d: -f2 | xargs)
            echo "  Version : $VERSION"
            echo "  License : $LICENCE"
            echo "  Summary : $SUMMARY"
        else
            echo "  [NOT FOUND] $PKG is NOT installed on this system."
        fi

    elif command -v dpkg &>/dev/null; then
        # Debian-based distribution (Ubuntu, Debian)
        if dpkg -l "$PKG" &>/dev/null; then
            echo "  [FOUND] $PKG is installed."
            echo ""
            VERSION=$(dpkg-query -Wf '${Version}' "$PKG")
            # Debian doesn't store license in dpkg metadata easily; common fallback:
            LICENCE=$(dpkg-query -Wf '${Status}' "$PKG" | grep -o "Mozilla" || echo "See /usr/share/doc/$PKG/copyright")
            echo "  Version : $VERSION"
            echo "  License : $LICENCE"
        else
            echo "  [NOT FOUND] $PKG is NOT installed on this system."
        fi

    elif command -v pacman &>/dev/null; then
        # Arch Linux-based distribution
        if pacman -Qs "^$PKG$" &>/dev/null; then
            echo "  [FOUND] $PKG is installed."
            echo ""
            # Extract info using pacman -Qi
            VERSION=$(pacman -Qi "$PKG" | grep "^Version" | cut -d: -f2- | xargs)
            LICENCE=$(pacman -Qi "$PKG" | grep "^Licenses" | cut -d: -f2- | xargs)
            SUMMARY=$(pacman -Qi "$PKG" | grep "^Description" | cut -d: -f2- | xargs)
            echo "  Version : $VERSION"
            echo "  License : $LICENCE"
            echo "  Summary : $SUMMARY"
        else
            echo "  [NOT FOUND] $PKG is NOT installed on this system."
        fi
    fi

    # --- Case statement for philosophy notes ---
    echo ""
    echo "  Philosophy note:"
    case "$PKG" in
        firefox)
            echo "  Firefox: open source at the frontline of the web, built by a non-profit"
            echo "           committed to keeping the internet open and accessible to all."
            ;;
        httpd|apache)
            echo "  Apache HTTP Server: the web server that powered the open internet's growth"
            echo "                      and remains the world's most widely deployed web server."
            ;;
        mysql|mariadb)
            echo "  MySQL/MariaDB: open source at the heart of millions of applications, proving that"
            echo "                 community-developed databases can compete with corporate alternatives."
            ;;
        python3|python)
            echo "  Python: a language shaped entirely by community, valued for readability,"
            echo "          versatility, and the philosophy that there should be one obvious way."
            ;;
        *)
            echo "  $PKG: another piece of the open source ecosystem, contributing to a"
            echo "        world where software remains free and community-driven."
            ;;
    esac
    echo "========================================"
}

# --- Run inspection for each package ---
for PACKAGE in "${PACKAGES[@]}"; do
    inspect_package "$PACKAGE"
done

echo ""
echo "  Package inspection complete."
