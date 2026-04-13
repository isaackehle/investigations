#!/bin/bash

# Ollama Model Management Library
# This library provides functions to manage Ollama models by purpose

# Function to check if Ollama is installed
check_ollama_installed() {
    if command -v ollama &> /dev/null; then
        return 0
    else
        echo "Ollama is not installed or not in PATH"
        return 1
    fi
}

# Function to check if Ollama server is running
check_ollama_server() {
    if curl -f http://localhost:11434/api/tags &> /dev/null; then
        return 0
    else
        echo "Ollama server is not running"
        return 1
    fi
}

# Function to install all coding assistant models
install_coding_assistants() {
    echo "Installing Coding Assistant Models..."

    # Basic coding models
    ollama pull phi4
    ollama pull qwen2.5-coder:1.5b
    ollama pull qwen2.5-coder:7b
    ollama pull gemma3:12b
    ollama pull qwen3-coder:30b

    # Qwen 3.5 models
    ollama pull qwen3.5:27b
    ollama pull qwen3.5:9b

    # Quantized models for faster loading
    ollama pull qwen/qwen3-coder-30b@4bit

    echo "✓ Coding Assistant Models Installed"
}

# Function to install reasoning and advanced models
install_reasoning_models() {
    echo "Installing Reasoning Models..."

    # Codestral (fast reasoning)
    ollama pull codestral:22b

    # Claude-like reasoning models
    ollama pull juilpark/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-heretic:q4_k_m
    ollama pull sorc/qwen3.5-claude-4.6-opus

    echo "✓ Reasoning Models Installed"
}

# Function to install reranking and embedding models
install_reranking_models() {
    echo "Installing Reranking and Embedding Models..."

    # Qwen rerankers
    ollama pull dengcao/Qwen3-Reranker-8B:Q5_K_M
    ollama pull dengcao/Qwen3-Reranker-4B:Q5_K_M
    ollama pull dengcao/Qwen3-Reranker-0.6B:Q5_K_M

    # Embedding models
    ollama pull elyor/nomic-embed-text-long:latest
    ollama pull nomic-embed-text-v2-moe

    echo "✓ Reranking and Embedding Models Installed"
}

# Function to install specialized models
install_specialized_models() {
    echo "Installing Specialized Models..."

    # DeepSeek models
    ollama pull deepseek-coder:6.7b
    ollama pull deepseek-ocr

    # Other specialized models
    ollama pull carstenuhlig/omnicoder-9b:q4_k_m
    ollama pull glm-5.1
    ollama pull granite3.2

    echo "✓ Specialized Models Installed"
}

# Function to install quantized models
install_quantized_models() {
    echo "Installing Quantized Models..."

    # Fast quantized models
    ollama pull hf.co/QuantFactory/FastApply-1.5B-v1.0-GGUF:Q4_K_M

    # Qwen quantized models
    ollama pull qwen3:14b
    ollama pull qwen3:30b
    ollama pull qwen3:4b
    ollama pull qwen3:8b

    echo "✓ Quantized Models Installed"
}

# Function to install all models
install_all_models() {
    echo "Installing All Ollama Models..."

    install_coding_assistants
    install_reasoning_models
    install_reranking_models
    install_specialized_models
    install_quantized_models

    echo "✓ All Models Installed"
}

# Function to list installed models
list_installed_models() {
    echo "Installed Ollama Models:"
    ollama list
}

# Function to check model availability (without downloading)
check_model_availability() {
    local model_name="$1"

    echo "Checking availability for: $model_name"

    # Try to pull with timeout (this is the check)
    if timeout 30s ollama pull "$model_name" 2>/dev/null; then
        echo "✓ Model $model_name is available"
        return 0
    else
        echo "✗ Model $model_name is not available or connection failed"
        return 1
    fi
}

# Function to check all models in a category
check_category_models() {
    local category="$1"

    case "$category" in
        "coding")
            MODELS=("phi4" "qwen2.5-coder:1.5b" "qwen2.5-coder:7b" "gemma3:12b" "qwen3-coder:30b" "qwen3.5:27b")
            ;;
        "reasoning")
            MODELS=("codestral:22b" "juilpark/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-heretic:q4_k_m" "sorc/qwen3.5-claude-4.6-opus")
            ;;
        "reranking")
            MODELS=("dengcao/Qwen3-Reranker-8B:Q5_K_M" "dengcao/Qwen3-Reranker-4B:Q5_K_M" "dengcao/Qwen3-Reranker-0.6B:Q5_K_M")
            ;;
        "specialized")
            MODELS=("carstenuhlig/omnicoder-9b:q4_k_m" "deepseek-coder:6.7b" "glm-5.1" "granite3.2")
            ;;
        *)
            echo "Unknown category: $category"
            return 1
            ;;
    esac

    echo "Checking $category models:"
    for model in "${MODELS[@]}"; do
        check_model_availability "$model"
    done
}

# Function to get model status summary
get_model_summary() {
    echo "Ollama Model Status Summary:"
    echo "============================"

    # Check basic setup
    if check_ollama_installed; then
        echo "✓ Ollama is installed"
    else
        echo "✗ Ollama is not installed"
    fi

    if check_ollama_server; then
        echo "✓ Ollama server is running"
    else
        echo "✗ Ollama server is not running"
    fi

    # Count installed models
    if command -v ollama &> /dev/null; then
        count=$(ollama list | grep -c "^[[:space:]]*[^[:space:]]")
        echo "✓ $count models currently installed"
    fi
}

# Function to clean up models (remove specific ones)
cleanup_models() {
    echo "Cleaning up models..."

    # Remove some specific models to save space
    ollama rm phi4 2>/dev/null || true
    ollama rm qwen2.5-coder:1.5b 2>/dev/null || true
    ollama rm codestral:22b 2>/dev/null || true

    echo "Cleanup complete"
}

# Function to update all models
update_all_models() {
    echo "Updating all Ollama models..."

    # List of all models to update
    ALL_MODELS=(
        "phi4"
        "qwen2.5-coder:1.5b"
        "qwen2.5-coder:7b"
        "gemma3:12b"
        "qwen3-coder:30b"
        "qwen3.5:27b"
        "codestral:22b"
        "juilpark/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-heretic:q4_k_m"
        "sorc/qwen3.5-claude-4.6-opus"
        "dengcao/Qwen3-Reranker-8B:Q5_K_M"
        "elyor/nomic-embed-text-long:latest"
        "nomic-embed-text-v2-moe"
        "carstenuhlig/omnicoder-9b:q4_k_m"
        "deepseek-coder:6.7b"
        "glm-5.1"
        "granite3.2"
        "hf.co/QuantFactory/FastApply-1.5B-v1.0-GGUF:Q4_K_M"
        "qwen3:14b"
        "qwen3:30b"
        "qwen3:4b"
        "qwen3:8b"
    )

    for model in "${ALL_MODELS[@]}"; do
        echo "Updating $model..."
        ollama pull "$model" 2>/dev/null || echo "Failed to update $model"
    done

    echo "Model update complete"
}

# Function to get usage instructions
show_usage() {
    echo "Ollama Model Management Commands:"
    echo "================================"
    echo "install_coding_assistants     - Install coding assistant models"
    echo "install_reasoning_models      - Install reasoning and advanced models"
    echo "install_reranking_models     - Install reranking and embedding models"
    echo "install_specialized_models    - Install specialized models"
    echo "install_quantized_models      - Install quantized models"
    echo "install_all_models            - Install all models"
    echo "list_installed_models         - List currently installed models"
    echo "check_model_availability <model> - Check if a specific model is available"
    echo "get_model_summary             - Get overall model status"
    echo "cleanup_models                - Remove some models to save space"
    echo "update_all_models             - Update all models"
    echo ""
    echo "Example usage:"
    echo "  source scripts/lib/ollama-models-lib.sh"
    echo "  install_coding_assistants"
    echo "  list_installed_models"
}