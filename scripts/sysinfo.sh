#!/usr/bin/env bash

# Exit immediately on error, unset variable, or pipe failure
set -euo pipefail

# Purpose:
# Collect basic system information useful for diagnostics
# or CI/CD runner inspection.

echo "===== SYSTEM INFORMATION ====="
echo "User        : $(whoami)"
echo "Hostname    : $(hostname)"
echo "Date (UTC)  : $(date -u)"
echo

echo "===== DISK USAGE ====="
df -h
echo

echo "===== MEMORY USAGE ====="
free -h
echo

echo "===== DONE ====="
