#!/bin/bash
DIR=$(dirname "$0")
mv ${DIR}/zsh.d ${HOME}/.zsh.d
mv ${DIR}/zshrc ${HOME}/.zshrc
chmod -R 755 ${HOME}/.zsh.d
touch /etc/profile.d/null.sh