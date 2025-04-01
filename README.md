# AdGuard Runner

A command-line utility with KRunner integration for controlling AdGuard Home on Linux systems.

## Description

AdGuard Runner provides a convenient way to start, stop, and check the status of AdGuard Home from both the command line and KDE's KRunner interface. It features an interactive menu, colorized output, progress indicators, and terminal detection to ensure optimal user experience in any environment.

## Requirements

- Python 3.6+
- AdGuard Home CLI installed (typically at `/opt/adguard-cli/adguard-cli`)
- KDE Plasma (for KRunner integration)
- Terminal emulator (konsole, gnome-terminal, etc.)

## Installation

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/adguard-runner.git
   cd adguard-runner
   ```

2. Copy the script to your local bin directory:
   ```bash
   mkdir -p ~/.local/bin
   cp bin/adguard-runner ~/.local/bin/
   chmod +x ~/.local/bin/adguard-runner
   ```

3. Install the KRunner integration:
   ```bash
   mkdir -p ~/.local/share/applications
   cp krunner/adguard-runner.desktop ~/.local/share/applications/
   ```

4. Make sure `~/.local/bin` is in your PATH:
   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

### Using the Install Script

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/adguard-runner.git
   cd adguard-runner
   ```

2. Run the installation script:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

## Usage

### Command Line

Run without arguments for an interactive menu:
```bash
adguard-runner
```

Direct commands:
```bash
adguard-runner start   # Start AdGuard Home
adguard-runner stop    # Stop AdGuard Home
adguard-runner status  # Check AdGuard Home status
```

### KRunner

1. Press Alt+Space (or your configured KRunner shortcut)
2. Type "adguard" to see available actions
3. Select one of the following:
   - AdGuard Start - Start AdGuard Home
   - AdGuard Stop - Stop AdGuard Home
   - AdGuard Status - Check current status

## Features

- **Interactive Menu**: Easy-to-use interface when run without arguments
- **Color-Coded Output**: Clear visual feedback with color-coded status messages
- **Terminal Detection**: Automatically detects if running in a terminal
- **Progress Indicators**: Visual feedback during operations
- **Sudo Handling**: Properly manages elevated privileges when needed
- **KRunner Integration**: Full desktop environment integration
- **User-Friendly Prompts**: Clear instructions and wait prompts
- **Robust Error Handling**: Proper error messages and fallback mechanisms

## KRunner Integration Details

The KRunner integration is implemented through a desktop entry file that defines multiple actions:
- The main entry makes the script searchable in KRunner
- Three actions provide direct access to start, stop, and status commands
- All actions launch in a terminal window for visibility
- The script detects when launched from KRunner and adjusts its behavior accordingly

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome) for the underlying DNS filtering capability
- KDE Plasma for the KRunner integration capabilities

