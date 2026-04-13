. ./helpers.sh

# Runtime setup: start Ollama server and pull base model
setup_ollama() {
    print_info "Setting up Ollama..."

    if ! command -v ollama &> /dev/null; then
        print_warning "Ollama not installed. Please install from: https://ollama.com/download"
        return 1
    fi

    print_info "Starting Ollama server..."
    ollama serve &

    print_info "Pulling llama3 model..."
    ollama pull llama3

    print_status "Ollama setup completed successfully"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_ollama
fi
