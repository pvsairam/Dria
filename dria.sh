#!/bin/bash

# Welcome message
echo "==========================================="
echo "    Welcome to 1-Click Node Dria"
echo "==========================================="
echo "Before proceeding, please join our Telegram channel at https://t.me/Airdrop_OG/"
echo "Have you joined? (Y/N)"
read -p "Your answer: " JOINED_CHANNEL

# Check if the user has joined the channel
if [[ $JOINED_CHANNEL =~ ^[Yy]$ ]]; then
    echo "Thank you for joining! Continuing setup..."
else
    echo "Please join the channel at https://t.me/Airdrop_OG/ first."
    echo "Setup halted."
    exit 1
fi

# Install Docker
echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y docker.io

# Check if Docker was installed successfully
if ! command -v docker &> /dev/null; then
    echo "Failed to install Docker. Please check again or install it manually."
    exit 1
else
    echo "Docker successfully installed."
fi

# Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Check if Docker Compose was installed successfully
if ! command -v docker-compose &> /dev/null; then
    echo "Failed to install Docker Compose. Please check again or install it manually."
    echo "Visit https://docs.docker.com/compose/install/ for installation guidance."
    exit 1
else
    echo "Docker Compose successfully installed."
fi

# Clone the repository
git clone https://github.com/firstbatchxyz/dkn-compute-node
cd dkn-compute-node

# Copy the environment file
cp .env.example .env

# Prompt for private key and OpenAI API key
read -p "Enter YOUR_PRIVATE_KEY: " PRIVATE_KEY
read -p "Enter YOUR_OPENAI_API_KEY: " OPENAI_API_KEY

# Add the keys to the .env file
echo "DKN_WALLET_SECRET_KEY=$PRIVATE_KEY" >> .env
echo "OPENAI_API_KEY=$OPENAI_API_KEY" >> .env

# Make the start script executable
chmod +x start.sh

# Run the start script with options
./start.sh --help

# Start the compute node with the specified mode
./start.sh -m=gpt-4o-mini

# Credits
echo "==========================================="
echo "  This script was created by https://t.me/Airdrop_OG"
echo "==========================================="
