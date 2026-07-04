#!/usr/bin/env bash
# THOX Local Models Validation Script for macOS/Linux
# Exit code 0 if all checks pass, 1 if any required files are missing or JSON is invalid

set -euo pipefail

python3 /Volumes/VibeStore/thox-local-models/scripts/validate-models.py
echo "All checks passed!"
