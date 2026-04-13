. ./helpers.sh

# Install OpenCode (try npm and Homebrew first, fallback to manual)
install_opencode() {
    print_info "Installing OpenCode..."

    # Try npm installation first
    if command_exists "npm"; then
        print_info "Attempting npm install..."

        # Try official OpenCode package (different naming)
        if install_via_npm "OpenCode" "opencode-ai"; then
            return 0
        fi

        # Try ai-sdk package name
        if install_via_npm "OpenCode" "@ai-sdk/opencode"; then
            return 0
        fi

    fi

    if command_exists "brew"; then
        print_info "Attempting Homebrew install..."
        if brew install anomalyco/tap/opencode; then
            print_status "OpenCode installed successfully via Homebrew"
            return 0
        fi
    fi

    # Fallback - provide manual installation instructions
    print_info "Please manually install OpenCode from:"
    print_info "  https://github.com/opencode-ai/opencode"
    return 1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_opencode
fi