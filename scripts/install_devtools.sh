#!/bin/bash
# Enhanced AI Development Tools Setup Script
# Includes Claude Code, OpenCode, Crush, Codex, Gemini, and Grok with comprehensive checks

set -e  # Exit on any error

. ./lib/helpers.sh
. ./lib/installers.sh

# Check system requirements and environment
check_system_requirements() {
    print_info "Checking system requirements..."

    # Check basic tools
    if command_exists "curl"; then
        print_status "✓ curl found"
    else
        print_warning "⚠ curl not found - may affect downloads"
    fi

    if command_exists "git"; then
        print_status "✓ git found"
    else
        print_warning "⚠ git not found - some tools may require git"
    fi

    # Check Node.js and npm
    if command_exists "node"; then
        print_status "✓ Node.js found: $(node --version)"
    else
        print_warning "⚠ Node.js not found - npm-based installations will be limited"
    fi

    if command_exists "npm"; then
        print_status "✓ npm found: $(npm --version)"
    else
        print_warning "⚠ npm not found - npm-based installations will be limited"
    fi

    # Check Python (optional but useful)
    if command_exists "python3"; then
        print_status "✓ Python 3 found: $(python3 --version)"
    else
        print_warning "⚠ Python 3 not found - some tools may require Python"
    fi

    # Check Docker (optional but useful for AI tools)
    if command_exists "docker"; then
        print_status "✓ Docker found: $(docker --version 2>/dev/null || echo 'Docker found')"
    else
        print_info "ℹ Docker not found - some AI tools may benefit from Docker"
    fi
}

# Verify all tools are properly installed and working
verify_installations() {
    print_info "Verifying tool installations..."

    local verification_results=""
    local all_passed=true

    # Check Claude Code
    if check_tool_with_version "Claude Code" "claude-code"; then
        verification_results="$verification_results ✓ Claude Code - OK\n"
    else
        verification_results="$verification_results ✗ Claude Code - FAILED\n"
        all_passed=false
    fi

    # Check OpenCode
    if check_tool_with_version "OpenCode" "opencode"; then
        verification_results="$verification_results ✓ OpenCode - OK\n"
    else
        verification_results="$verification_results ✗ OpenCode - FAILED\n"
        all_passed=false
    fi

    # Check Crush
    if check_tool_with_version "Crush" "crush"; then
        verification_results="$verification_results ✓ Crush - OK\n"
    else
        verification_results="$verification_results ✗ Crush - FAILED\n"
        all_passed=false
    fi

    # Check Codex
    if check_tool_with_version "Codex" "codex"; then
        verification_results="$verification_results ✓ Codex - OK\n"
    else
        verification_results="$verification_results ✗ Codex - FAILED\n"
        all_passed=false
    fi

    # Check Gemini
    if check_tool_with_version "Gemini" "gemini"; then
        verification_results="$verification_results ✓ Gemini - OK\n"
    else
        verification_results="$verification_results ✗ Gemini - FAILED\n"
        all_passed=false
    fi

    # Check Grok
    if check_tool_with_version "Grok" "grok"; then
        verification_results="$verification_results ✓ Grok - OK\n"
    else
        verification_results="$verification_results ✗ Grok - FAILED\n"
        all_passed=false
    fi

    echo -e "$verification_results"

    if [ "$all_passed" = true ]; then
        print_success "All AI development tools are properly installed and functional"
        return 0
    else
        print_warning "Some tools may require manual configuration or additional setup"
        return 1
    fi
}

# Main installation function with comprehensive checks and installation
install_ai_tools() {
    echo "=== Comprehensive AI Development Tools Setup ==="
    echo ""

    # Create log file
    touch ai_setup.log
    log_message "=== AI Development Tools Setup Started ==="

    # Display system information
    print_info "System Information:"
    echo "  OS: $(uname -s) $(uname -r)"
    echo "  Architecture: $(uname -m)"
    echo "  Hostname: $(hostname)"

    # Check system requirements
    check_system_requirements

    echo ""
    print_info "Starting comprehensive tool installation checks..."

    # Check each tool and install if missing
    echo ""
    print_info "Checking for AI development tools..."

    # Check and install Claude Code
    if ! check_tool_with_version "Claude Code" "claude-code"; then
        print_info "Installing Claude Code..."
        install_claude_code || print_error "Failed to install Claude Code"
    fi

    # Check and install OpenCode
    if ! check_tool_with_version "OpenCode" "opencode"; then
        print_info "Installing OpenCode..."
        install_opencode || print_error "Failed to install OpenCode"
    fi

    # Check and install Crush
    if ! check_tool_with_version "Crush" "crush"; then
        print_info "Installing Crush..."
        install_crush || print_error "Failed to install Crush"
    fi

    # Check and install Codex
    if ! check_tool_with_version "Codex" "codex"; then
        print_info "Installing Codex..."
        install_codex || print_error "Failed to install Codex"
    fi

    # Check and install Gemini
    if ! check_tool_with_version "Gemini" "gemini"; then
        print_info "Installing Gemini..."
        install_gemini || print_error "Failed to install Gemini"
    fi

    # Check and install Grok
    if ! check_tool_with_version "Grok" "grok"; then
        print_info "Installing Grok..."
        install_grok || print_error "Failed to install Grok"
    fi

    # Final verification
    echo ""
    print_info "Final verification of installed tools:"

    verify_installations

    echo ""
    print_status "Setup process completed - check ai_setup.log for detailed information"

    # Provide help text for manual installations if needed
    echo ""
    print_info "If any tools are still not working, please:"
    echo "  1. Verify npm is installed: npm --version"
    echo "  2. Try installing manually from the official repositories"
    echo "  3. Check that Node.js is installed: node --version"
    echo ""
    print_info "Additional resources:"
    print_info "  - Setup logs: ai_setup.log"
    print_info "  - Official documentation for each tool is available at their respective GitHub repositories"

    # Additional system checks
    echo ""
    print_info "System Compatibility Check:"
    if command_exists "node" && command_exists "npm"; then
        print_status "✓ Node.js and npm environment ready for AI tool installations"
    else
        print_warning "⚠ Node.js or npm not fully available - some installations may require manual steps"
    fi
}

# Run the installation script with error handling
trap 'echo "Setup interrupted or failed. Check ai_setup.log for details."; exit 1' INT TERM ERR

# Main execution
install_ai_tools 2>&1 | tee setup_output.log
