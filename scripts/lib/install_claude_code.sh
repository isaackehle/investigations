
. ./helpers.sh

# Install Claude Code (try npm first, fallback to manual)
install_claude_code() {
    print_info "Installing Claude Code..."

    # Try npm installation first
    if command_exists "npm"; then
        print_info "Attempting npm install..."

        # Try official Claude Code package
        if install_via_npm "Anthropic Claude Code" "@anthropic-ai/claude-code"; then
            return 0
        fi

        # Try npm installation first
        if install_via_npm "Claude Code" "@ai-sdk/claude-code"; then
            return 0
        fi

        # Try official Claude Code package (different naming)
        if install_via_npm "Claude Code" "claude-code"; then
            return 0
        fi
    fi

    if command_exists "brew"; then
        print_info "Attempting Homebrew install..."
        if brew install --cask claude-code; then
            print_status "Claude Code installed successfully via Homebrew"
            return 0
        fi
    fi

    # Fallback - provide manual installation instructions
    print_info "Please manually install Claude Code from:"
    print_info "  https://github.com/claude-code/claude-code"
    print_info "  Documentation: https://docs.claudecode.com/"
    return 1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_claude_code
fi

