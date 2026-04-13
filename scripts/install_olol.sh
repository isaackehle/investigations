#!/bin/bash
# Olol Installation Script for macOS (Apple Silicon)
# Installs Olol AI tool from https://github.com/K2/olol

set -e  # Exit on any error

# Source the library for helper functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_PATH="$SCRIPT_DIR/lib/helpers.sh"

if [ -f "$LIB_PATH" ]; then
    . "$LIB_PATH"
else
    echo "Error: Helper library not found at $LIB_PATH"
    exit 1
fi

# Check system requirements
check_system_requirements() {
    print_info "Checking system requirements..."

    # Check architecture
    if [[ "$(uname -m)" == "arm64" ]]; then
        print_status "✓ Apple Silicon (ARM64) architecture detected"
    else
        print_warning "⚠ Non-Apple Silicon architecture detected - Olol may not work optimally"
    fi

    # Check if curl is available
    if command_exists "curl"; then
        print_status "✓ curl found"
    else
        print_error "✗ curl not found - cannot proceed with installation"
        exit 1
    fi

    # Check if bash is available (required for this script)
    if command_exists "bash"; then
        print_status "✓ Bash found"
    else
        print_error "✗ Bash not found - cannot proceed with installation"
        exit 1
    fi

    # Check if Node.js is available (required for Olol)
    if command_exists "node"; then
        print_status "✓ Node.js found: $(node --version)"
    else
        print_warning "⚠ Node.js not found - Olol requires Node.js"
    fi

    # Check if npm is available (required for Olol)
    if command_exists "npm"; then
        print_status "✓ npm found: $(npm --version)"
    else
        print_warning "⚠ npm not found - Olol requires npm"
    fi
}

# Install Olol using npm (from GitHub repository)
install_olol() {
    print_info "Installing Olol..."

    # Check if Olol is already installed
    if check_tool_with_version "Olol" "olol"; then
        return 0
    fi

    # Install Olol via npm from GitHub repository
    print_info "Installing Olol via npm from GitHub..."
    
    if install_via_npm "Olol" "https://github.com/K2/olol.git"; then
        print_success "Olol installed successfully via npm"
    else
        print_error "Failed to install Olol via npm"
        return 1
    fi
}

# Configure Olol system settings (macOS specific)
configure_olol() {
    print_info "Configuring Olol for macOS..."

    # Set up shell completion (if shell is supported)
    if [[ -n "$SHELL" && "$SHELL" == *"zsh"* ]]; then
        # For zsh users, set up completion if available
        if command_exists "olol"; then
            olol completion zsh > ~/.zsh/completions/_olol 2>/dev/null || true
        fi
    elif [[ -n "$SHELL" && "$SHELL" == *"bash"* ]]; then
        # For bash users, set up completion if available
        if command_exists "olol"; then
            olol completion bash > ~/.bash/completions/olol 2>/dev/null || true
        fi
    fi

    print_status "Olol configuration completed"
}

# Verify Olol installation and setup
verify_olol() {
    print_info "Verifying Olol installation..."

    # Check if Olol is installed and working
    if command_exists "olol"; then
        print_status "✓ Olol is installed and accessible"
    else
        print_error "✗ Olol installation failed"
        return 1
    fi

    # Check version
    local olol_version
    olol_version=$(olol --version 2>&1)
    print_info "Olol version: $olol_version"

    # Test basic functionality
    if olol --help >/dev/null 2>&1; then
        print_status "✓ Olol is functioning correctly"
    else
        print_warning "⚠ Olol may not be fully functional - check system requirements"
    fi

    return 0
}

# Display post-installation instructions
post_install_instructions() {
    echo ""
    print_info "=== Olol Installation Complete ==="
    echo ""
    
    print_info "To get started with Olol:"
    echo "  1. Run 'olol --help' to see available commands"
    echo "  2. Configure Olol with your settings"
    echo ""
    
    print_info "For more information:"
    echo "  - GitHub Repository: https://github.com/K2/olol"
    echo "  - Documentation: https://github.com/K2/olol#readme"
    echo ""
    
    print_info "Olol is now installed and ready to use!"
}

# Main installation function
main() {
    echo "=== Olol Installation Script ==="
    echo ""
    
    # Create log file
    touch olol_install.log
    log_message "=== Olol Installation Started ==="

    # Display system information
    print_info "System Information:"
    echo "  OS: $(uname -s) $(uname -r)"
    echo "  Architecture: $(uname -m)"
    echo "  Hostname: $(hostname)"
    
    # Check system requirements
    check_system_requirements

    echo ""
    print_info "Starting Olol installation process..."

    # Install Olol
    install_olol

    # Configure Olol for macOS
    configure_olol

    # Verify installation
    verify_olol

    # Show post-installation instructions
    post_install_instructions

    echo ""
    print_status "Olol installation completed successfully!"
    print_info "Check olol_install.log for detailed installation information"
}

# Run the installation script with error handling
trap 'echo "Installation interrupted or failed. Check olol_install.log for details."; exit 1' INT TERM ERR

# Main execution
main "$@" 2>&1 | tee olol_install_output.log
