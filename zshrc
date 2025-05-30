export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DENO_INSTALL="/home/kedarmd/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Renders nerd font correctly in tmux
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="/opt/webstorm/bin:$PATH"

eval "$(zoxide init zsh)"

# Enables command history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Alias
alias lg="lazygit"
alias cd="z"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
