#!/bin/bash
# Ollama Installation Script for macOS (Apple Silicon)
# Installs Ollama with comprehensive checks and setup

set -e  # Exit on any error

. ./lib/helpers.sh  # Load helper functions for logging and checks



# Install Homebrew if not present
install_homebrew() {
    print_info "Installing Homebrew..."

    if ! command_exists "brew"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        print_status "Homebrew installed successfully"
    else
        print_status "Homebrew already installed"
    fi
}

# Install Ollama using Homebrew (Apple Silicon optimized)
install_ollama() {
    print_info "Installing Ollama..."

    # Check if Ollama is already installed
    if command_exists "ollama"; then
        print_status "Ollama is already installed"
        local existing_version
        existing_version=$(ollama --version 2>&1)
        print_info "Version: $existing_version"
        return 0
    fi

    # Check if Homebrew is available, install if needed
    if ! command_exists "brew"; then
        install_homebrew
    fi

    # Install Ollama via Homebrew
    print_info "Installing Ollama via Homebrew..."

    if brew install ollama; then
        print_status "Ollama installed successfully via Homebrew"
    else
        print_error "Failed to install Ollama via Homebrew"

        # Fallback: Try direct download for Apple Silicon
        print_info "Attempting direct download as fallback..."
        install_ollama_direct
        return $?
    fi
}

# Fallback installation method - direct download
install_ollama_direct() {
    print_info "Installing Ollama via direct download..."

    # Download and install the latest Ollama for macOS ARM64
    if curl -fsSL https://ollama.com/install.sh | sh; then
        print_status "Ollama installed successfully via direct download"
    else
        print_error "Failed to install Ollama via direct download"
        return 1
    fi
}

# Configure Ollama system settings (macOS specific)
configure_ollama() {
    print_info "Configuring Ollama for macOS..."

    # Set up the Ollama service to start automatically on login (macOS)
    if command_exists "brew"; then
        # Link the service for automatic startup (macOS)
        if brew services list | grep -q ollama; then
            print_status "Ollama service already configured"
        else
            brew services start ollama 2>/dev/null || print_warning "Could not set up automatic startup"
        fi
    else
        print_info "Homebrew not available - skipping service configuration"
    fi

    # Set up shell completion (if shell is supported)
    if [[ -n "$SHELL" && "$SHELL" == *"zsh"* ]]; then
        # For zsh users, set up completion if available
        if command_exists "ollama"; then
            ollama completion zsh > ~/.zsh/completions/_ollama 2>/dev/null || true
        fi
    elif [[ -n "$SHELL" && "$SHELL" == *"bash"* ]]; then
        # For bash users, set up completion if available
        if command_exists "ollama"; then
            ollama completion bash > ~/.bash/completions/ollama 2>/dev/null || true
        fi
    fi

    print_status "Ollama configuration completed"
}

# Verify Ollama installation and setup
verify_ollama() {
    print_info "Verifying Ollama installation..."

    # Check if Ollama is installed and working
    if command_exists "ollama"; then
        print_status "✓ Ollama is installed and accessible"
    else
        print_error "✗ Ollama installation failed"
        return 1
    fi

    # Check version
    local ollama_version
    ollama_version=$(ollama --version 2>&1)
    print_info "Ollama version: $ollama_version"

    # Test basic functionality
    if ollama list >/dev/null 2>&1; then
        print_status "✓ Ollama is functioning correctly"
    else
        print_warning "⚠ Ollama may not be fully functional - check system requirements"
    fi

    return 0
}

# Display post-installation instructions
post_install_instructions() {
    echo ""
    print_info "=== Ollama Installation Complete ==="
    echo ""

    print_info "To get started with Ollama:"
    echo "  1. Run 'ollama run llama3.2' to start a chat session"
    echo "  2. Use 'ollama list' to see all downloaded models"
    echo "  3. Use 'ollama pull <model-name>' to download additional models"
    echo ""

    print_info "For more information:"
    echo "  - Documentation: https://ollama.com/docs"
    echo "  - Community: https://github.com/ollama/ollama"
    echo ""

    print_info "Ollama is now installed and ready to use!"
    print_info "For model management, run: 'scripts/ollama-manager.sh'"
}

# Main installation function
main() {
    echo "=== Ollama Installation Script ==="
    echo ""

    # Create log file
    touch ollama_install.log
    log_message "=== Ollama Installation Started ==="

    # Display system information
    print_info "System Information:"
    echo "  OS: $(uname -s) $(uname -r)"
    echo "  Architecture: $(uname -m)"
    echo "  Hostname: $(hostname)"

    # Check system requirements
    check_system_requirements

    echo ""
    print_info "Starting Ollama installation process..."

    # Install Ollama
    install_ollama

    # Configure Ollama for macOS
    configure_ollama

    # Verify installation
    verify_ollama

    # Show post-installation instructions
    post_install_instructions

    echo ""
    print_status "Ollama installation completed successfully!"
    print_info "Check ollama_install.log for detailed installation information"
}

# Run the installation script with error handling
trap 'echo "Installation interrupted or failed. Check ollama_install.log for details."; exit 1' INT TERM ERR

# Main execution
main "$@" 2>&1 | tee ollama_install_output.log