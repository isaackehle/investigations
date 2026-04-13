# AI Tool Configuration Manager

A comprehensive script-based solution for managing AI development tool configurations with Ollama integration.

## Overview

This repository provides a complete solution for configuring and managing AI development tools with Ollama as the primary provider. It includes backup, restore, and setup capabilities for various AI tools while supporting offline AI coding assistance.

## Features

- **Configuration Backup & Restore**: Create backups of existing AI tool configurations before modifications
- **Ollama Integration**: Full support for Ollama as the primary AI provider
- **Multi-Tool Support**: Configures Continue.dev, OpenCode, Crush, and Claude Code tools
- **Offline AI Setup**: Complete setup for Ollama and Grok CLI with privacy-focused offline assistance
- **Shell Environment Management**: Automatic configuration of Grok environment variables

## Installation

### Prerequisites

1. **Ollama**: Install from [https://ollama.com/download](https://ollama.com/download)
2. **Bash**: Compatible with modern bash environments
3. **Git**: For cloning this repository

### Setup Process

```bash
# Clone the repository
git clone <repository-url>
cd scripts

# Make the scripts executable
chmod +x install_devtools.sh
chmod +x install_ollama.sh
chmod +x configure_devtools.sh

# Run the setup process
./install_ollama.sh
./install_devtools.sh setup
./configure_devtools.sh setup
```

## Configuration Files

All configuration files are stored in the `./configs` directory:

- `continue_config.yaml` - Continue.dev configuration
- `opencode.jsonc` - OpenCode configuration
- `crush.json` - Crush configuration
- `claude_code_config.json` - Claude Code configuration

## Ollama and Grok CLI Setup

### Complete Offline AI Configuration

The setup process includes:

1. **Start Ollama server**: `ollama serve`
2. **Pull model**: `ollama pull llama3`
3. **Configure Grok CLI**:
   - Sets environment variables: `GROK_BASE_URL=http://localhost:11434`
   - Sets model: `GROK_MODEL=llama3`

### Usage Instructions

After running the setup:

```bash
# Source the Grok environment setup
source grok_setup.sh

# Use Grok CLI for offline AI assistance
grok --prompt "Explain this codebase"
```

### Privacy and Cost Benefits

This setup enables fully offline AI coding assistance:
- **Privacy**: All processing happens locally without cloud transmission
- **Cost Reduction**: Eliminates API costs for AI services
- **Reliability**: Works without internet connectivity

## Backup and Restore Operations

### Backup Configuration

```bash
./configure_devtools.sh backup
```

Creates backups in `$HOME/ai_tool_backups` directory containing:
- All existing AI tool configurations
- Complete configuration directories

### Restore Configuration

```bash
./configure_devtools.sh restore
```

Restores configurations from backups, preserving all previous settings.

### Complete Setup

```bash
./configure_devtools.sh setup
```

Performs a complete backup and configuration process, including:
- Backup of existing configurations
- Copying new configuration files
- Setup of Ollama and Grok CLI

## Configuration Structure

### Ollama Provider Configuration

All configurations now use Ollama as the primary provider:

```yaml
provider: "ollama"
baseURL: "http://localhost:11434/v1"
```

### Model Examples

Tool-capable instruct models (work with all opencode agents):

- **Code agent** (`code`):
  - `hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M` — purpose-built agentic coder, MoE 30B
- **Think agent** (`think`):
  - `hf.co/bartowski/Mistral-Small-24B-Instruct-2501-GGUF:Q4_K_M` — Mistral Small 24B, strong tool calling
- **Write agent** (`write`):
  - `qwen/qwen3.5-35b-a3b` — Qwen 3.5 35B MoE via Ollama
- **Research agent** (`research`):
  - `qwen/qwen3.5-14b` — Qwen 3.5 14B via Ollama
- **Plan agent** (`plan` / `small_model`):
  - `hf.co/unsloth/Qwen3-4B-Instruct-2507-GGUF:Q4_K_M` — fast 4B for planning and routing

Reasoning/thinking distills (no tool support — chat-only, select manually):

- `hf.co/mradermacher/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-i1-GGUF:Q4_K_M`
- `yolo0perris/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-GGUF_Q3_K_M`
- `mradermacher/Qwen2.5-7B-Instruct-1M-Thinking-Claude-Gemini-GPT5.2-DISTILL-GGUF:Q4_K_M`
- `deepseek/deepseek-r1-0528-qwen3-8b`

### Ollama model installation

- Agent models (tool-capable, pulled from HuggingFace via Ollama)

```shell
# code agent
ollama pull hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M

# think agent
ollama pull hf.co/bartowski/Mistral-Small-24B-Instruct-2501-GGUF:Q4_K_M

# plan agent / small_model
ollama pull hf.co/unsloth/Qwen3-4B-Instruct-2507-GGUF:Q4_K_M
```

- Ollama registry models (write / research agents)

```shell
ollama pull qwen3.5:35b-a3b
ollama pull qwen3.5:14b
```

- Reasoning/thinking distills (no tool support — chat-only)

```shell
ollama pull hf.co/mradermacher/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-i1-GGUF:Q4_K_M
ollama pull yolo0perris/Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled-GGUF_Q3_K_M
ollama pull hf.co/mradermacher/Huihui-Qwen3-Coder-30B-A3B-Instruct-abliterated-i1-GGUF:Q4_K_M
```

## Environment Variable Setup

The Grok CLI environment is configured through:

1. **File Location**: `~/.config/grok/_grok`
2. **Shell Integration**:
   - Zsh: `~/.zshrc.d/grok_env`
   - Bash: `~/.profile.d/grok_env`

### Environment Variables

```bash
export GROK_BASE_URL=http://localhost:11434
export GROK_MODEL=llama3
```

## Usage Examples

### Basic Configuration Management

```bash
# Backup all existing configurations
./configure_devtools.sh backup

# Restore configurations from backup
./configure_devtools.sh restore

# Perform complete setup with backups
./configure_devtools.sh setup
```

### Offline AI Usage

```bash
# Setup Ollama and Grok for offline use
./configure_devtools.sh ollama

# Source the environment (after setup)
source grok_setup.sh

# Use Grok CLI
grok --prompt "Explain this codebase"
```

## Supported AI Tools

1. **Continue.dev** - Enhanced coding assistant
2. **OpenCode** - Code generation and editing tool
3. **Crush** - Development workflow automation
4. **Claude Code** - Advanced code understanding
5. **Gemini** - Google's AI model integration
6. **Grok** - High-performance reasoning AI

## Directory Structure

```
Here's the updated directory structure with the lib folder properly integrated:

```markdown
scripts/                         # Script files for various tasks/
├── configure_devtools.sh        # Main configuration script - Manages AI tool configurations with backup/restore capabilities
├── configs/                     # New configuration files - Contains all AI tool configuration files
│  ├── continue_config.yaml      # Configuration file for Continue.dev
│  ├── crush.json                # Configuration file for Crush
│  ├── grok.json                 # Configuration file for Grok
│  ├── gemini.json               # Configuration file for Gemini
│  └── opencode.jsonc            # Configuration file for OpenCode
├── lib/                         # Helper functions and utilities - Contains helper scripts for managing AI tools
│   ├── helpers.sh               # Common helper functions and logging utilities
│   ├── installers.sh            # Tool installer functions - Contains installation logic for various AI tools
│   ├── install_grok.sh          # Grok installation script - Installs and configures the Grok AI tool
│   ├── install_opencode.sh      # OpenCode installation script - Installs and configures the OpenCode AI tool
│   ├── install_crush.sh         # Crush installation script - Installs and configures the Crush AI tool
│   ├── install_codex.sh         # Codex installation script - Installs and configures the Codex AI tool
│   ├── install_claude_code.sh   # Claude Code installation script - Installs and configures the Claude Code AI tool
│   ├── install_gemini.sh        # Gemini installation script - Installs and configures the Gemini AI tool
│   └── ollama-models-lib.sh     # Ollama model management - Functions for managing Ollama models by purpose
├── install_devtools.sh          # Devtools installation script - Installs development tools required for AI tool management
├── install_ollama.sh            # Ollama CLI setup script - Configures Ollama environment variables and shell integration
├── README.md                    # This file - Documentation for the AI tool configuration manager
└── grok_setup.sh                # Grok CLI setup script - Configures Grok environment variables and shell integration
```

This updated structure shows:
1. The `lib/` directory with helper functions and utilities
2. Individual installation scripts for each AI tool in the lib folder
3. The `ollama-models-lib.sh` which contains functions for managing Ollama models by purpose
4. Proper indentation and formatting to clearly show the directory hierarchy
## Privacy and Security

The configuration system prioritizes privacy:

- **Local Processing**: All AI operations occur locally
- **No Cloud Transmission**: Configuration files are not sent to external services
- **Secure Storage**: Backup files are stored in user's home directory

## Troubleshooting

### Ollama Not Found

```bash
# Install Ollama from https://ollama.com/download
# Or if installed in a custom location, ensure it's in PATH
```

### Configuration Issues

```bash
# Check backup directory for existing configurations
ls -la $HOME/ai_tool_backups/

# Restore from backup if needed
./configure_devtools.sh restore
```

### Grok CLI Setup Issues

```bash
# Verify environment file exists
ls -la ~/.config/grok/_grok

# Check shell integration paths
ls -la ~/.zshrc.d/grok_env  # For Zsh
ls -la ~/.profile.d/grok_env  # For Bash
```

## Olol Configuration Example

Optimization and configuration:
- OLLAMA_SERVERS: Comma-separated list of gRPC server addresses (default: "localhost:50051")
- OLOL_PORT: HTTP port for the API proxy (default: 8000)
- OLOL_LOG_LEVEL: Set logging level (default: INFO)
- OLLAMA_FLASH_ATTENTION: Enable FlashAttention for faster inference
- OLLAMA_NUMA: Enable NUMA optimization if available
- OLLAMA_KEEP_ALIVE: How long to keep models loaded (e.g., "1h")
- OLLAMA_MEMORY_LOCK: Lock memory to prevent swapping
- OLLAMA_LOAD_TIMEOUT: Longer timeout for loading large models
- OLLAMA_QUANTIZE: Quantization level (e.g., "q8_0", "q5_0", "f16")
- OLLAMA_CONTEXT_WINDOW: Default context window size (e.g., "8192", "16384")
- OLLAMA_DEBUG: Enable debug mode with additional logging
- OLLAMA_LOG_LEVEL: Set Ollama log level



## License

MIT License - See LICENSE file for details.
