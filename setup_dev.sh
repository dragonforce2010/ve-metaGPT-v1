#!/bin/bash

# Setup script for MetaGPT development environment using uv
# This script sets up the project with all necessary dependencies

set -e

echo "🚀 Setting up MetaGPT development environment with uv..."

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "❌ uv is not installed. Please install uv first:"
    echo "   curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

echo "✅ uv is installed"

# Check if Python 3.13 is available
echo "🔍 Checking Python version..."
uv python pin 3.13.3

# Sync dependencies from pyproject.toml
echo "📦 Installing dependencies..."
uv sync

# Install the project in development mode
echo "🔧 Installing project in development mode..."
uv pip install -e .

# Install pre-commit hooks if available
if [ -f ".pre-commit-config.yaml" ]; then
    echo "🪝 Installing pre-commit hooks..."
    uv run pre-commit install
fi

# Create a virtual environment activation script
echo "📝 Creating environment activation script..."
cat > activate_env.sh << 'EOF'
#!/bin/bash
# Activate the uv virtual environment
source .venv/bin/activate
echo "✅ MetaGPT development environment activated"
echo "📚 Available commands:"
echo "  - uv run python examples/di/crawl_webpage.py   # Run the crawl webpage example"
echo "  - uv run pytest                                # Run tests"
echo "  - uv run metagpt                               # Run MetaGPT CLI"
EOF
chmod +x activate_env.sh

echo "🎉 Development environment setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Run: source activate_env.sh"
echo "2. Test the setup: uv run python examples/di/crawl_webpage.py"
echo "3. Start developing! 🚀"
echo ""
echo "💡 Useful commands:"
echo "  - uv add <package>          # Add a new dependency"
echo "  - uv run <command>          # Run a command in the environment"
echo "  - uv sync                   # Sync dependencies"
echo "  - uv lock                   # Update lock file" 