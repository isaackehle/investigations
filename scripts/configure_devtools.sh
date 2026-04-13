#!/bin/bash
# AI Tool Configuration Backup and Restore Script with Ollama Provider

echo "=== AI TOOL CONFIGURATION BACKUP AND RESTORE SCRIPT ==="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Configuration directory
NEW_CFG_DIR='./configs'
BACKUP_DIR="$HOME/ai_tool_backups"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup existing configurations
backup_existing_configs() {
    print_status "Backing up existing AI tool configurations..."

    # Backup Continue.dev config
    if [ -f "$HOME/.continue/config.yaml" ]; then
        cp "$HOME/.continue/config.yaml" "$BACKUP_DIR/continue_config_backup.yaml"
        print_status "Backed up Continue.dev config to $BACKUP_DIR/continue_config_backup.yaml"
    elif [ -f "continue_config.yaml" ]; then
        cp "continue_config.yaml" "$BACKUP_DIR/continue_config_backup.yaml"
        print_status "Backed up Continue.dev config to $BACKUP_DIR/continue_config_backup.yaml"
    fi

    # Backup OpenCode config
    if [ -f "$HOME/.opencode/config.jsonc" ]; then
        cp "$HOME/.opencode/config.jsonc" "$BACKUP_DIR/opencode_config_backup.jsonc"
        print_status "Backed up OpenCode config to $BACKUP_DIR/opencode_config_backup.jsonc"
    elif [ -f "opencode.jsonc" ]; then
        cp "opencode.jsonc" "$BACKUP_DIR/opencode_config_backup.jsonc"
        print_status "Backed up OpenCode config to $BACKUP_DIR/opencode_config_backup.jsonc"
    fi

    # Backup Crush config
    if [ -f "$HOME/.crush/config.json" ]; then
        cp "$HOME/.crush/config.json" "$BACKUP_DIR/crush_config_backup.json"
        print_status "Backed up Crush config to $BACKUP_DIR/crush_config_backup.json"
    elif [ -f "crush.json" ]; then
        cp "crush.json" "$BACKUP_DIR/crush_config_backup.json"
        print_status "Backed up Crush config to $BACKUP_DIR/crush_config_backup.json"
    fi

    # Backup Claude Code config
    if [ -f "$HOME/.claude-code/config.json" ]; then
        cp "$HOME/.claude-code/config.json" "$BACKUP_DIR/claude_code_config_backup.json"
        print_status "Backed up Claude Code config to $BACKUP_DIR/claude_code_config_backup.json"
    fi

    # Backup any other existing configurations
    if [ -d "$HOME/.continue" ]; then
        cp -r "$HOME/.continue" "$BACKUP_DIR/continue_backup"
        print_status "Backed up Continue.dev directory to $BACKUP_DIR/continue_backup"
    fi

    if [ -d "$HOME/.opencode" ]; then
        cp -r "$HOME/.opencode" "$BACKUP_DIR/opencode_backup"
        print_status "Backed up OpenCode directory to $BACKUP_DIR/opencode_backup"
    fi

    if [ -d "$HOME/.crush" ]; then
        cp -r "$HOME/.crush" "$BACKUP_DIR/crush_backup"
        print_status "Backed up Crush directory to $BACKUP_DIR/crush_backup"
    fi

    if [ -d "$HOME/.claude-code" ]; then
        cp -r "$HOME/.claude-code" "$BACKUP_DIR/claude_code_backup"
        print_status "Backed up Claude Code directory to $BACKUP_DIR/claude_code_backup"
    fi

    print_status "All existing configurations backed up successfully"
}

# Function to restore configurations from backup
restore_configs() {
    print_status "Restoring AI tool configurations from backup..."

    # Restore Continue.dev config
    if [ -f "$BACKUP_DIR/continue_config_backup.yaml" ]; then
        cp "$BACKUP_DIR/continue_config_backup.yaml" "$HOME/.continue/config.yaml"
        print_status "Restored Continue.dev config from backup"
    fi

    # Restore OpenCode config
    if [ -f "$BACKUP_DIR/opencode_config_backup.jsonc" ]; then
        cp "$BACKUP_DIR/opencode_config_backup.jsonc" "$HOME/.opencode/config.jsonc"
        print_status "Restored OpenCode config from backup"
    fi

    # Restore Crush config
    if [ -f "$BACKUP_DIR/crush_config_backup.json" ]; then
        cp "$BACKUP_DIR/crush_config_backup.json" "$HOME/.crush/config.json"
        print_status "Restored Crush config from backup"
    fi

    # Restore Claude Code config
    if [ -f "$BACKUP_DIR/claude_code_config_backup.json" ]; then
        cp "$BACKUP_DIR/claude_code_config_backup.json" "$HOME/.claude-code/config.json"
        print_status "Restored Claude Code config from backup"
    fi

    # Restore entire directories if they exist
    if [ -d "$BACKUP_DIR/continue_backup" ]; then
        cp -r "$BACKUP_DIR/continue_backup"/* "$HOME/.continue/" 2>/dev/null || true
        print_status "Restored Continue.dev directory from backup"
    fi

    if [ -d "$BACKUP_DIR/opencode_backup" ]; then
        cp -r "$BACKUP_DIR/opencode_backup"/* "$HOME/.opencode/" 2>/dev/null || true
        print_status "Restored OpenCode directory from backup"
    fi

    if [ -d "$BACKUP_DIR/crush_backup" ]; then
        cp -r "$BACKUP_DIR/crush_backup"/* "$HOME/.crush/" 2>/dev/null || true
        print_status "Restored Crush directory from backup"
    fi

    if [ -d "$BACKUP_DIR/claude_code_backup" ]; then
        cp -r "$BACKUP_DIR/claude_code_backup"/* "$HOME/.claude-code/" 2>/dev/null || true
        print_status "Restored Claude Code directory from backup"
    fi

    print_status "All configurations restored successfully"
}

# Function to copy new configurations
copy_new_configs() {
    print_status "Copying new AI tool configurations..."

    # Create necessary directories if they don't exist
    mkdir -p "$HOME/.continue"
    mkdir -p "$HOME/.opencode"
    mkdir -p "$HOME/.crush"
    mkdir -p "$HOME/.claude-code"

    # Copy new configurations from NEW_CFG_DIR
    if [ -d "$NEW_CFG_DIR" ]; then
        # Copy Continue.dev config
        if [ -f "$NEW_CFG_DIR/continue_config.yaml" ]; then
            cp "$NEW_CFG_DIR/continue_config.yaml" "$HOME/.continue/config.yaml"
            print_status "Copied new Continue.dev config"
        fi

        # Copy OpenCode config
        if [ -f "$NEW_CFG_DIR/opencode.jsonc" ]; then
            cp "$NEW_CFG_DIR/opencode.jsonc" "$HOME/.opencode/config.jsonc"
            print_status "Copied new OpenCode config"
        fi

        # Copy Crush config
        if [ -f "$NEW_CFG_DIR/crush.json" ]; then
            cp "$NEW_CFG_DIR/crush.json" "$HOME/.crush/config.json"
            print_status "Copied new Crush config"
        fi

        # Copy Claude Code config
        if [ -f "$NEW_CFG_DIR/claude_code_config.json" ]; then
            cp "$NEW_CFG_DIR/claude_code_config.json" "$HOME/.claude-code/config.json"
            print_status "Copied new Claude Code config"
        fi

        # Copy any other configuration files from the directory
        for config_file in "$NEW_CFG_DIR"/*; do
            if [ -f "$config_file" ]; then
                filename=$(basename "$config_file")
                case "$filename" in
                    "continue_config.yaml"|"opencode.jsonc"|"crush.json"|"claude_code_config.json")
                        # These are handled above, skip them
                        ;;
                    *)
                        # Copy any other files to appropriate directories or root
                        if [[ "$filename" == *"continue"* ]]; then
                            cp "$config_file" "$HOME/.continue/"
                        elif [[ "$filename" == *"opencode"* ]]; then
                            cp "$config_file" "$HOME/.opencode/"
                        elif [[ "$filename" == *"crush"* ]]; then
                            cp "$config_file" "$HOME/.crush/"
                        elif [[ "$filename" == *"claude"* ]]; then
                            cp "$config_file" "$HOME/.claude-code/"
                        else
                            # Copy to root or handle as needed
                            cp "$config_file" "$HOME/"
                        fi
                        print_status "Copied $filename"
                        ;;
                esac
            fi
        done

        print_status "All new configurations copied successfully"
    else
        print_error "Configuration directory $NEW_CFG_DIR not found!"
        exit 1
    fi
}

# Function to setup Ollama and Grok CLI
setup_ollama_and_grok() {
    print_info "Setting up Ollama and Grok CLI..."

    # Check if ollama is installed
    if ! command -v ollama &> /dev/null; then
        print_warning "Ollama not installed. Please install from: https://ollama.com/download"
        return 1
    fi

    # Start Ollama server
    print_info "Starting Ollama server..."
    ollama serve &

    # Pull a model
    print_info "Pulling llama3 model..."
    ollama pull llama3

    # Create Grok environment file
    print_info "Creating Grok environment configuration..."

    # Create _grok file with environment variables
    mkdir -p "$HOME/.config/grok"

    cat > "$HOME/.config/grok/_grok" << 'EOF'
# Grok CLI Configuration
export GROK_BASE_URL=http://localhost:11434
export GROK_MODEL=llama3
EOF

    # Determine shell and copy to appropriate directory
    if [ -n "$ZSH_VERSION" ]; then
        # Zsh shell
        mkdir -p "$HOME/.zshrc.d"
        cp "$HOME/.config/grok/_grok" "$HOME/.zshrc.d/grok_env"
        print_status "Grok environment file copied to $HOME/.zshrc.d/grok_env"
    elif [ -n "$BASH_VERSION" ]; then
        # Bash shell
        mkdir -p "$HOME/.profile.d"
        cp "$HOME/.config/grok/_grok" "$HOME/.profile.d/grok_env"
        print_status "Grok environment file copied to $HOME/.profile.d/grok_env"
    else
        # Fallback - copy to ~/.profile.d for bash or create .env file
        mkdir -p "$HOME/.profile.d"
        cp "$HOME/.config/grok/_grok" "$HOME/.profile.d/grok_env"
        print_status "Grok environment file copied to $HOME/.profile.d/grok_env"
    fi

    # Create a simple sourcing script
    cat > grok_setup.sh << 'EOF'
#!/bin/bash
# Grok CLI Setup Script

echo "Sourcing Grok environment variables..."
if [ -f "$HOME/.profile.d/grok_env" ]; then
    source "$HOME/.profile.d/grok_env"
    echo "Grok environment variables sourced from ~/.profile.d/grok_env"
elif [ -f "$HOME/.zshrc.d/grok_env" ]; then
    source "$HOME/.zshrc.d/grok_env"
    echo "Grok environment variables sourced from ~/.zshrc.d/grok_env"
else
    echo "Warning: Grok environment file not found in standard locations"
fi

echo ""
echo "To use Grok CLI:"
echo "1. Source this script: source grok_setup.sh"
echo "2. Use: grok --prompt \"Explain this codebase\""
echo ""
echo "This enables fully offline AI coding assistance when combined with Ollama, preserving privacy and reducing costs."
EOF

    chmod +x grok_setup.sh

    print_status "Ollama and Grok CLI setup completed successfully"
    print_info "Run 'source grok_setup.sh' to set up Grok CLI environment variables"
    print_info "Use: grok --prompt \"Explain this codebase\" for offline AI assistance"
}

# Main execution function
main() {
    case "$1" in
        backup)
            backup_existing_configs
            ;;
        restore)
            restore_configs
            ;;
        setup)
            backup_existing_configs
            copy_new_configs
            setup_ollama_and_grok
            ;;
        ollama)
            setup_ollama_and_grok
            ;;
        *)
            echo "Usage: $0 {backup|restore|setup|ollama}"
            echo "  backup - Backup existing configurations"
            echo "  restore - Restore configurations from backup"
            echo "  setup - Perform complete setup with backups and new configs"
            echo "  ollama - Setup Ollama and Grok CLI (offline AI)"
            exit 1
            ;;
    esac

    echo ""
    echo "=== AI TOOL CONFIGURATION PROCESS COMPLETED ==="
    echo "Backup directory: $BACKUP_DIR"
    echo ""
    echo "Available operations:"
    echo "1. backup - Creates backups of existing configurations"
    echo "2. restore - Restores configurations from backups"
    echo "3. setup - Performs complete backup and configuration setup"
    echo "4. ollama - Sets up Ollama and Grok CLI for offline AI"
}

# Run the script with provided argument
main "$1"

echo ""
echo "=== BACKUP AND SETUP COMPLETED ==="
echo "Files processed in: $BACKUP_DIR"
