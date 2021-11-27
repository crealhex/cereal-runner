#!/bin/bash

# Setup Colors
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')

cat << EOF

Welcome to Packager 0.4
Running from ${YELLOW}`pwd`${RESET}

${GREEN}Starting package installations...${RESET}

EOF

sudo apt-get update
# && apt-get upgrade -y

cat << EOF

Updates Finished
${GREEN}Running terminal configurations...${RESET}

EOF

# Configuring zsh installer vars
# RUNZSH=${RUNZSH:-no}
# CHSH=${CHSH:-no}
# KEEP_ZSHRC=${KEEP_ZSHRC:-no}

# Installing zsh package
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install powerlevel10k zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# [REPLACE] ZSH_THEME="robbyrussell"
sed -ri 's/(ZSH_THEME=")([a-zA-Z]+)(")/\1powerlevel10k\/powerlevel10k\3/g' ~/.zshrc

# Change default shell to zsh
chsh -s $(which zsh)
# exec zsh

# Ubuntu-Runner settings
RUNNER=${RUNNER:-~/.linux-runner}
REPO=${REPO:-crealhex/linux-runner}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}

git clone -c core.eol=lf -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    -c linux-runner.remote=origin \
    -c linux-runner.branch="$BRANCH" \
    --depth=1 --branch "$BRANCH" "$REMOTE" "$RUNNER"

cp ~/.linux-runner/.p10k.zsh ~/
cp ~/.linux-runner/.zshrc ~/

# Run Powerlevel10k configuration wizard

# p10k configure

# cp /mnt/c/Users/warender/Desktop/ubuntu-runner/runner.sh .