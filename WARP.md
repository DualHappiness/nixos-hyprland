# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a personal NixOS configuration repository using Nix flakes with home-manager integration. It provides a complete system configuration for a ThinkPad laptop with Hyprland (Wayland compositor), comprehensive development tools, and custom styling via Stylix.

## Core Commands

### System Management
```bash
# Build and switch to new configuration (requires sudo)
sudo nixos-rebuild switch --flake .#panda-knight

# Test configuration without switching (safer for testing)
sudo nixos-rebuild test --flake .#panda-knight

# Build configuration without switching
sudo nixos-rebuild build --flake .#panda-knight

# Update flake inputs
nix flake update

# Check system differences after rebuild
nvd diff /run/current-system result
```

### Development Workflow
```bash
# Format Nix files
nixfmt-rfc-style **/*.nix

# Check flake configuration
nix flake check

# Show flake metadata
nix flake show

# Build specific outputs
nix build .#nixosConfigurations.panda-knight.config.system.build.toplevel
```

### System Utilities (via nh helper)
The system uses the `nh` (NixOS Helper) tool configured in `configuration.nix`:
```bash
# Clean old generations (configured to keep 5 and 3 days)
nh clean

# Show system status
nh home switch
```

## Architecture Overview

### Flake Structure
- **Main flake**: `flake.nix` - Defines inputs (nixpkgs, home-manager, hyprland, stylix, etc.) and outputs
- **System config**: `configuration.nix` - Core NixOS system configuration
- **Home config**: `home.nix` - Entry point for home-manager configurations
- **Hardware**: `hardware-configuration.nix` - Hardware-specific settings (auto-generated)

### Input Sources
- **nixpkgs**: Stable NixOS 25.05 channel
- **nixpkgs-unstable**: Bleeding-edge packages for editors and development tools
- **home-manager**: User environment management
- **hyprland**: Wayland compositor with custom configuration
- **stylix**: Unified theming system
- **zen-browser**: Alternative browser via flake
- **nur**: Nix User Repository for additional packages

### Configuration Modules

#### System Level (`configuration.nix`)
- Boot configuration (systemd-boot)
- Network setup (NetworkManager with iwd backend)
- Hardware optimization (TLP, thermald, thinkfan)
- Virtualization (Docker)
- Shell (Nushell as default)
- Security and services

#### Home Level (`home/` directory)
Each `.nix` file in `home/` is automatically imported:
- **shell.nix**: Nushell configuration with completions and aliases
- **editor.nix**: Development tools (Helix, VS Code, language servers)
- **git.nix**: Git configuration with delta diff viewer
- **stylix.nix**: Theme and font configuration
- **packages.nix**: User-specific packages
- **hyprland.nix**: Window manager configuration

### Key Design Patterns

#### Modular Configuration
The system uses automatic imports in `home.nix` to load all `.nix` files from the `home/` directory, making it easy to add new configuration modules.

#### Mixed Package Sources
Development tools come from unstable channel (`pkgs-unstable`) while system packages use stable channel, balancing stability with latest features for development.

#### Unified Theming
Stylix provides consistent theming across all applications with the "tomorrow" color scheme and Maple Mono NF font.

## Development Environment

### Default Tools
- **Editor**: Helix (configured as `$EDITOR`)
- **Shell**: Nushell with vi mode and extensive completions
- **Version Control**: Git with delta diff viewer and gh CLI
- **Terminal**: Supports multiple terminals with unified styling
- **File Management**: lsd (ls replacement), bat (cat replacement), zoxide (cd replacement)

### Language Support
Configured language servers and tools for:
- Nix (nixd language server, nixfmt formatter)
- Rust (rustup toolchain)
- Node.js/JavaScript/TypeScript
- Python (python-lsp-server)
- C/C++ (clang-tools)
- Bash, YAML, Terraform, Lua, Markdown

### Shell Aliases
Key aliases defined in shell configuration:
- `hx` → default editor
- `rg` → grep replacement
- `bat` → cat replacement  
- `lsd` → ls replacement
- `btop` → top replacement
- `ze` → zellij terminal multiplexer

## Special Configurations

### Proxy Management
Built-in proxy functions for development:
```bash
proxy    # Enable HTTP/HTTPS proxy
unproxy  # Disable proxy
```

### Hardware Optimization
- Intel GPU acceleration with latest drivers
- ThinkPad-specific fan control and thermal management
- TrackPoint configuration for optimal sensitivity
- Fingerprint reader support

### Container Development
Docker configured with:
- Manual startup (not on boot)
- Journald logging
- Overlay2 storage driver
- User in docker group

This configuration provides a complete, reproducible development environment optimized for modern software development workflows.
