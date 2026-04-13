. ./helpers.sh

# Install Crush (try npm first, fallback to manual)
install_crush() {
    print_info "Installing Crush..."

    # Try npm installation first
    if command_exists "npm"; then
        print_info "Attempting npm install..."

        # Try the official Charmland Crush package
        if install_via_npm "Charmland Crush" "@charmland/crush"; then
            return 0
        fi

        # Try npm installation first
        if install_via_npm "AI SDK Crush" "@ai-sdk/crush"; then
            return 0
        fi

        # Try alternative package names
        if install_via_npm "Crush" "crush"; then
            return 0
        fi
    fi

    if command_exists "brew"; then
        print_info "Attempting Homebrew install..."
        if brew install charmland/tap/crush; then
            print_status "Crush installed successfully via Homebrew"
            return 0
        fi
    fi

    # Try alternative methods or provide instructions
    print_info "Please manually install Crush from:"
    print_info "  https://github.com/charmverse/crush"
    print_info "  Documentation: https://docs.charmverse.io/crush"
    return 1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_crush
fi