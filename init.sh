#!/bin/bash

# Install required packages
sudo apt install screen nano -y

# Install Node Version Manager (NVM)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
chmod +x ~/.nvm/nvm.sh
source ~/.bashrc
nvm install 17

# Clone the repository and navigate to the directory
git clone https://github.com/TrueCarry/JettonGramGpuMiner
cd JettonGramGpuMiner

# Prompt the user for SEED and TONAPI_TOKEN
read -p "Enter SEED: " seed
read -p "Enter TONAPI_TOKEN: " tonapi_token

# Create the config.txt file with user input
cat > config.txt << EOL
SEED=$seed
TONAPI_TOKEN=$tonapi_token
EOL

# Create mine.sh script
cat > mine.sh << EOL
while true; do
  node send_multigpu.js --api tonapi --bin ./pow-miner-cuda --givers 1000 --gpu-count \$(nvidia-smi --list-gpus | wc -l)
  sleep 1;
done;
EOL

# Install dependencies, make mine.sh executable, and run in a detached screen session
npm install
chmod +x mine.sh

echo "Setup complete. Start mining with ./mine.sh command"
