#!/bin/bash

curl https://sh.rustup.rs -sSf | sh -s -- -y

source $HOME/.cargo/env
source ~/.profile

echo "Rustup installed."
