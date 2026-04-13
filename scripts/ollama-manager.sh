#!/bin/bash

# Ollama Manager Script
# Simple interface to manage Ollama models

# Source the library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_PATH="$SCRIPT_DIR/lib/ollama-models-lib.sh"

if [ -f "$LIB_PATH" ]; then
    source "$LIB_PATH"
else
    echo "Error: Ollama models library not found at $LIB_PATH"
    exit 1
fi

# Main command dispatcher
case "${1:-help}" in
    "install-coding")
        install_coding_assistants
        ;;
    "install-reasoning")
        install_reasoning_models
        ;;
    "install-reranking")
        install_reranking_models
        ;;
    "install-specialized")
        install_specialized_models
        ;;
    "install-quantized")
        install_quantized_models
        ;;
    "install-all")
        install_all_models
        ;;
    "list")
        list_installed_models
        ;;
    "check")
        if [ -n "$2" ]; then
            check_model_availability "$2"
        else
            echo "Usage: $0 check <model-name>"
        fi
        ;;
    "summary")
        get_model_summary
        ;;
    "help"|*)
        show_usage
        ;;
esac