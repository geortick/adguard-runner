#!/bin/bash
#
# AdGuard Runner Installation Script
# This script installs the AdGuard Runner script for AdGuard for Linux and its KRunner integration
#

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Directories
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"

# Print with color
print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    local missing_deps=0
    
    # Check for python3
    if ! command_exists python3; then
        print_error "Python 3 is required but not installed."
        missing_deps=1
    else
        print_success "Python 3 is installed."
    fi
    
    # Check for AdGuard for Linux
56|    if [ ! -f "/opt/AdGuard/AdGuard" ] && [ ! -f "/opt/AdGuardHome/AdGuardHome" ]; then
57|        print_warning "AdGuard for Linux binary not found"
58|        print_warning "Make sure AdGuard for Linux is properly installed."
59|        missing_deps=1
60|    else
61|        print_success "AdGuard for Linux binary found."
    fi
    
    if [ $missing_deps -eq 1 ]; then
        print_warning "Some dependencies are missing. The script may not work properly."
        read -p "Do you want to continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Installation aborted."
            exit 1
        fi
    else
        print_success "All dependencies are satisfied."
    fi
}

# Create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    
    if [ ! -d "$BIN_DIR" ]; then
        mkdir -p "$BIN_DIR"
        print_success "Created $BIN_DIR"
    else
        print_success "$BIN_DIR already exists."
    fi
    
    if [ ! -d "$DESKTOP_DIR" ]; then
        mkdir -p "$DESKTOP_DIR"
        print_success "Created $DESKTOP_DIR"
    else
        print_success "$DESKTOP_DIR already exists."
    fi
}

# Copy files to their locations
copy_files() {
    print_status "Copying files to their locations..."
    
    # Check if files exist in the source
    if [ ! -f "bin/adguard-runner" ]; then
        print_error "Source file bin/adguard-runner not found."
        exit 1
    fi
    
    if [ ! -f "krunner/adguard-runner.desktop" ]; then
        print_error "Source file krunner/adguard-runner.desktop not found."
        exit 1
    fi
    
    # Backup existing files if they exist
    if [ -f "$BIN_DIR/adguard-runner" ]; then
        backup_file="$BIN_DIR/adguard-runner.bak.$(date +%Y%m%d_%H%M%S)"
        cp "$BIN_DIR/adguard-runner" "$backup_file"
        print_success "Backed up existing script to $backup_file"
    fi
    
    if [ -f "$DESKTOP_DIR/adguard-runner.desktop" ]; then
        backup_file="$DESKTOP_DIR/adguard-runner.desktop.bak.$(date +%Y%m%d_%H%M%S)"
        cp "$DESKTOP_DIR/adguard-runner.desktop" "$backup_file"
        print_success "Backed up existing desktop file to $backup_file"
    fi
    
    # Copy files
    cp "bin/adguard-runner" "$BIN_DIR/"
    cp "krunner/adguard-runner.desktop" "$DESKTOP_DIR/"
    
    print_success "Files copied successfully."
}

# Set correct permissions
set_permissions() {
    print_status "Setting correct permissions..."
    
    chmod +x "$BIN_DIR/adguard-runner"
    print_success "Set executable permission on $BIN_DIR/adguard-runner"
}

# Verify the installation
verify_installation() {
    print_status "Verifying installation..."
    
    local verification_passed=1
    
    # Check if files exist in the destination
    if [ ! -f "$BIN_DIR/adguard-runner" ]; then
        print_error "Script file not found at $BIN_DIR/adguard-runner"
        verification_passed=0
    else
        print_success "Script file installed at $BIN_DIR/adguard-runner"
    fi
    
    if [ ! -f "$DESKTOP_DIR/adguard-runner.desktop" ]; then
        print_error "Desktop file not found at $DESKTOP_DIR/adguard-runner.desktop"
        verification_passed=0
    else
        print_success "Desktop file installed at $DESKTOP_DIR/adguard-runner.desktop"
    fi
    
    # Check if the script is executable
    if [ ! -x "$BIN_DIR/adguard-runner" ]; then
        print_error "Script is not executable"
        verification_passed=0
    else
        print_success "Script has executable permission"
    fi
    
    # Check if the path is in the user's PATH
    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        print_warning "$BIN_DIR is not in your PATH"
        print_warning "You may need to add it to your PATH manually:"
        print_warning "echo 'export PATH=\"\$PATH:$BIN_DIR\"' >> ~/.bashrc"
        verification_passed=0
    else
        print_success "$BIN_DIR is in your PATH"
    fi
    
    if [ $verification_passed -eq 1 ]; then
        print_success "Installation verification passed."
        return 0
    else
        print_warning "Installation verification detected issues."
        return 1
    fi
}

# Main installation function
main() {
    echo -e "${CYAN}===== AdGuard for Linux Runner Installation =====${NC}"
    echo
    
    check_dependencies
    create_directories
    copy_files
    set_permissions
    
    if verify_installation; then
        echo
        echo -e "${GREEN}Installation completed successfully!${NC}"
        echo
        echo -e "You can now use AdGuard for Linux Runner with the following commands:"
202|        echo -e "  ${CYAN}adguard-runner${NC} - Interactive menu"
203|        echo -e "  ${CYAN}adguard-runner start${NC} - Start AdGuard for Linux"
204|        echo -e "  ${CYAN}adguard-runner stop${NC} - Stop AdGuard for Linux"
205|        echo -e "  ${CYAN}adguard-runner status${NC} - Check AdGuard for Linux status"
        echo
        echo -e "You can also use it through KRunner by pressing Alt+Space and typing 'adguard'."
        echo
        echo -e "Thank you for installing AdGuard for Linux Runner!"
    else
        echo
        echo -e "${YELLOW}Installation completed with warnings.${NC}"
        echo -e "Please check the messages above and fix any issues."
        echo
        echo -e "If you need help, please visit the GitHub repository."
    fi
}

# Run the main function
main

