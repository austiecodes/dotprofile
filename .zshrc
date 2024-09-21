# git alias  
source ~/.zsh/gitalias 
# >> ssh shorts
source ~/.zsh/sshshorts

# >>> bob nvim manager
export PATH=$PATH:/Users/austie/.local/share/bob/nvim-bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/users/austie/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/austie/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/austie/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/austie/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#>>> nvm initialization
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> Oh Yes, I use starship
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> some customize commands
mcd() {
  # check param
  if [ -z "$1" ]; then
    echo "Usage: mcd <directory>"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}
