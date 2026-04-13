. ./helpers.sh

# Install Grok (try npm first, fallback to manual)
install_grok() {
    print_info "Installing Grok..."

    # Try npm installation first
    if command_exists "npm"; then
        print_info "Attempting npm install..."

        # Try npm installation first
        if install_via_npm "Grok VibeKit" "@vibe-kit/grok-cli"; then
            return 0
        fi

        if install_via_npm "Grok" "@ai-sdk/grok"; then
            return 0
        fi

        # Try alternative package names
        if install_via_npm "Grok" "grok"; then
            return 0
        fi
    fi

    # Fallback - provide manual installation instructions
    print_info "Please manually install Grok from:"
    print_info "  https://github.com/grok-ai/grok"
    print_info "  Documentation: https://grok.ai/docs"
    return 1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_grok
fi