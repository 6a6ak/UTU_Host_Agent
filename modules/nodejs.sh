#!/bin/bash
sudo apt update
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
nvm install node

echo "Checking Node.js and npm installation..."

if command -v node > /dev/null 2>&1; then
    echo "Node.js is installed."
    echo "Node.js version:"
    node -v
else
    echo "Node.js is not installed."
fi

if command -v npm > /dev/null 2>&1; then
    echo "npm is installed."
    echo "npm version:"
    npm -v
else
    echo "npm is not installed."
fi
