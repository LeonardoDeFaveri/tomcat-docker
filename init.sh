#!/bin/env bash

echo "PS1=\"\[\033[38;5;11m\]\u@\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;172m\][\w]\[$(tput sgr0)\]\[\033[38;5;9m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]\"" >> /root/.bashrc
## Run a shell so we don't exit
/bin/bash
