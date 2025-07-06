#!/bin/bash
# setup.sh - Install TMUX configuration and plugins

set -e

echo "🚀 Setting up TMUX configuration for multi-Claude development..."

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "❌ TMUX is not installed. Please install it first:"
    echo "   macOS: brew install tmux"
    echo "   Ubuntu: sudo apt install tmux"
    echo "   CentOS/RHEL: sudo yum install tmux"
    exit 1
fi

# Backup existing config if it exists
if [ -f ~/.tmux.conf ]; then
    echo "📦 Backing up existing .tmux.conf to .tmux.conf.backup"
    cp ~/.tmux.conf ~/.tmux.conf.backup
fi

# Copy main config
echo "📝 Installing .tmux.conf..."
cp .tmux.conf ~/.tmux.conf

# Create tmux directory structure
echo "📁 Creating TMUX directories..."
mkdir -p ~/.tmux
mkdir -p ~/.tmux/plugins

# Copy session config
echo "📝 Installing development session config..."
cp dev-session.conf ~/.tmux/dev-session.conf

# Install TPM (TMUX Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "📦 Installing TMUX Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "✅ TPM already installed"
fi

# Install quick launch script
echo "📝 Creating quick launch scripts..."
cat > ~/.tmux/wgo-dev.sh << 'EOF'
#!/bin/bash
# Quick launcher for WGO development session

SESSION_NAME="wgo-dev"

# Check if session exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "Session $SESSION_NAME already exists. Attaching..."
    tmux attach-session -t $SESSION_NAME
else
    echo "Creating new WGO development session..."
    tmux new-session -d -s $SESSION_NAME -c ~/personal/wgo
    tmux source-file ~/.tmux/dev-session.conf
    tmux attach-session -t $SESSION_NAME
fi
EOF

chmod +x ~/.tmux/wgo-dev.sh

# Create alias helper
echo "📝 Creating shell aliases..."
cat >> ~/.bash_profile << 'EOF'

# TMUX aliases for WGO development
alias wgo-dev='~/.tmux/wgo-dev.sh'
alias claude-session='tmux new-session -s claude -c ~/personal/wgo "claude-code"'
alias tmux-reload='tmux source-file ~/.tmux.conf'
EOF

echo ""
echo "✅ TMUX configuration installed successfully!"
echo ""
echo "📋 Next steps:"
echo "   1. Restart your terminal or run: source ~/.bash_profile"
echo "   2. Start TMUX: tmux"
echo "   3. Install plugins: Ctrl-a + I (capital I)"
echo "   4. Launch WGO dev session: wgo-dev"
echo ""
echo "🔧 Key bindings:"
echo "   Prefix: Ctrl-a"
echo "   Split horizontal: Ctrl-a + |"
echo "   Split vertical: Ctrl-a + -"
echo "   Switch panes: Alt + arrow keys"
echo "   Switch windows: Shift + arrow keys"
echo "   Launch Claude: Ctrl-a + C-1/C-2/C-3"
echo "   Dev session: Ctrl-a + D"
echo "   Reload config: Ctrl-a + r"
echo ""
echo "🎯 Claude Code shortcuts:"
echo "   New Claude window: Ctrl-a + C-1"
echo "   Split with Claude: Ctrl-a + C-c"
echo "   Quick dev session: wgo-dev"
echo ""
