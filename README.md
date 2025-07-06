# TMUX Configuration for Multi-Claude Development

A TMUX configuration optimized for running multiple Claude Code instances while developing the WGO infrastructure tool.

## ✨ Features

- **Multi-Claude Support**: Easy shortcuts to launch multiple Claude Code instances
- **Development Layouts**: Predefined session layouts for coding workflows
- **Smart Key Bindings**: Intuitive navigation without constant prefix usage
- **Session Management**: Save and restore development sessions
- **Plugin Integration**: Essential plugins for enhanced productivity

## 🚀 Quick Start

```bash
# Clone this repository
git clone git@github-yairfalse:yairfalse/tmux-config.git
cd tmux-config

# Run the setup script
chmod +x setup.sh
./setup.sh

# Start a new terminal session or reload your shell
source ~/.bash_profile

# Launch WGO development session
wgo-dev
```

## 🎯 Key Bindings

### Basic Navigation
- **Prefix**: `Ctrl-a` (instead of default Ctrl-b)
- **Split Horizontal**: `Ctrl-a + |`
- **Split Vertical**: `Ctrl-a + -`
- **Switch Panes**: `Alt + Arrow Keys` (no prefix needed)
- **Switch Windows**: `Shift + Arrow Keys` (no prefix needed)
- **Resize Panes**: `Ctrl + Arrow Keys`

### Claude Code Shortcuts
- **New Claude Window**: `Ctrl-a + C-1/C-2/C-3`
- **Split with Claude**: `Ctrl-a + C-c` (horizontal) / `Ctrl-a + C-v` (vertical)
- **Development Session**: `Ctrl-a + D`

### Utility
- **Reload Config**: `Ctrl-a + r`
- **Copy Mode**: `Ctrl-a + [`
- **New Window**: `Ctrl-a + c`

## 📱 Development Layout

The `wgo-dev` command creates a 4-pane layout:

```
┌─────────────────┬─────────────────┐
│                 │                 │
│   Main Editor   │   Claude Code 1 │
│                 │                 │
├─────────────────┼─────────────────┤
│                 │                 │
│ Terminal/Tests  │   Claude Code 2 │
│                 │                 │
└─────────────────┴─────────────────┘
```

Additional windows:
- **claude-3**: Dedicated Claude Code instance
- **docs**: Documentation and notes
- **testing**: Test running and debugging

## 🔧 Customization

### Adding More Claude Instances

Edit `~/.tmux/dev-session.conf` to add more Claude Code panes:

```bash
# Add another Claude window
new-window -n "claude-4" -c "~/personal/wgo"
send-keys "claude-code" Enter
```

### Custom Key Bindings

Add to `~/.tmux.conf`:

```bash
# Custom binding example
bind C-g new-window -n "git" -c "#{pane_current_path}" "lazygit"
```

### Session Templates

Create new session configs in `~/.tmux/`:

```bash
# ~/.tmux/testing-session.conf
new-window -n "test-runner" -c "~/personal/wgo"
send-keys "go test -v ./..." Enter
```

## 🔌 Plugins

This configuration uses [TPM (TMUX Plugin Manager)](https://github.com/tmux-plugins/tpm) with these plugins:

- **tmux-sensible**: Sensible defaults
- **tmux-resurrect**: Save/restore sessions
- **tmux-continuum**: Automatic session saving
- **tmux-yank**: Better copy/paste

### Plugin Management

- **Install plugins**: `Ctrl-a + I`
- **Update plugins**: `Ctrl-a + U`
- **Remove plugins**: `Ctrl-a + Alt-u`

## 🎪 Quick Commands

```bash
# Start WGO development session
wgo-dev

# Start standalone Claude session
claude-session

# Reload TMUX config
tmux-reload

# List active sessions
tmux list-sessions

# Attach to existing session
tmux attach-session -t wgo-dev
```

## 🛠️ Troubleshooting

### Claude Code Not Found
Make sure Claude Code is installed and in your PATH:
```bash
# Check if claude-code is available
which claude-code

# Install if needed (example)
npm install -g @anthropic/claude-code
```

### Plugin Installation Issues
```bash
# Manually install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload TMUX config
tmux source-file ~/.tmux.conf

# Install plugins
~/.tmux/plugins/tpm/bin/install_plugins
```

### Session Not Saving
Check continuum plugin status:
```bash
# In TMUX, show continuum status
tmux show-option -g @continuum-save-interval
```

## 📝 Configuration Files

- `~/.tmux.conf`: Main TMUX configuration
- `~/.tmux/dev-session.conf`: WGO development session layout
- `~/.tmux/wgo-dev.sh`: Quick launcher script

## 🤝 Contributing

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This configuration is open source and available under the [MIT License](LICENSE).
