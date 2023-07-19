#!/bin/bash

# Ask user for the directory to clone the repository to
read -p "Enter the directory to clone the repository to: " CLONE_DIR

# Create the directory if it doesn't exist
mkdir -p "$CLONE_DIR"

# Change to the clone directory
cd "$CLONE_DIR"

# Ask user for the SSH address of the repository
read -p "Enter the SSH address of the repository: " REPO_SSH

# Ask user for the SSH key file location and name
read -p "Enter the SSH key file location and name: " SSH_KEY_FILE

# Clone the repository with SSH
GIT_SSH_COMMAND="ssh -i $SSH_KEY_FILE" git clone "$REPO_SSH" .

echo "Repository cloned successfully to $CLONE_DIR"
