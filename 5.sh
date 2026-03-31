#!/bin/bash
# Script 5: The Open Source Manifesto Generator
# Author: Tanisha Tarak | Course: Open Source Software
# Description: Generates a personalized open source philosophy statement.

# --- Clear screen and display header ---
clear
echo "========================================"
echo "  Open Source Manifesto Generator"
echo "========================================"
echo ""
echo "  Answer three questions to generate"
echo "  your personal open source philosophy"
echo "  statement."
echo ""

# --- Interactive user input ---
read -p "  1. Name one open-source tool you use every day: " TOOL
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
read -p "  3. Name one thing you would build and share freely: " BUILD

# --- Generate variables ---
DATE=$(date '+%d %B %Y at %H:%M:%S')
USERNAME=$(whoami | tr ' ' '_')
OUTPUT="manifesto_${USERNAME}_$(date '+%Y%m%d').txt"

# --- Compose the manifesto paragraph ---
# Ensure EOF is at the very beginning of the line!
MANIFESTO=$(cat <<EOF
================================================================================
                OPEN SOURCE PHILOSOPHY STATEMENT
================================================================================

Student Name: Anupam Roy
Registration: 24BEY10070
Generated on: $DATE

--------------------------------------------------------------------------------

Every day, I rely on $TOOL as part of my open source practice. This tool
reminds me that software does not have to be locked away to be powerful.
In fact, it is precisely because $TOOL is open that it has grown into something
relied upon by millions.

When I think about what 'freedom' means in the context of software, I think of
$FREEDOM. Not the freedom to do anything without consequence, but the freedom
to learn, to modify, to share, and to build on the work of those who came before.
This is the freedom that open source guarantees.

If I were to build something and share it freely, it would be $BUILD. I believe
that knowledge, when shared, multiplies rather than diminishes. The tools we use
every day were built by people who chose to share rather than to hoard. I want
to be part of that tradition.

Open source is not just a licence. It is a commitment to collaboration,
transparency, and the belief that the best solutions emerge from diverse
communities of contributors working in the open.

================================================================================
EOF
)

# --- Write to output file ---
echo "$MANIFESTO" > "$OUTPUT"

# --- Confirmation message ---
echo ""
echo "========================================"
echo "  Manifesto saved to: $OUTPUT"
echo "========================================"
echo ""

# --- Display the generated manifesto ---
echo "  Your Manifesto:"
echo ""
cat "$OUTPUT"
