#!/bin/bash

# Activate script for MetaGPT development environment
# This script activates the uv-managed virtual environment

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if .venv exists
if [ ! -d "$SCRIPT_DIR/.venv" ]; then
    echo "❌ Virtual environment not found."
    echo "Please run ./setup_dev.sh first to set up the development environment."
    exit 1
fi

# Activate the virtual environment
echo "🚀 Activating MetaGPT development environment..."
source "$SCRIPT_DIR/.venv/bin/activate"

# Check if activation was successful
if [ "$VIRTUAL_ENV" != "" ]; then
    echo "✅ Virtual environment activated successfully!"
    echo "📍 Virtual environment location: $VIRTUAL_ENV"
    echo "🐍 Python version: $(python --version)"
    echo ""
    echo "💡 Useful commands:"
    echo "   uv add <package>     - Add a new dependency"
    echo "   uv run <command>     - Run command in the virtual environment"
    echo "   uv sync              - Sync dependencies"
    echo "   deactivate           - Deactivate the virtual environment"
    echo ""
    echo "🎯 Ready to develop with MetaGPT!"
else
    echo "❌ Failed to activate virtual environment"
    exit 1
fi 