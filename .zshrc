# Enable vi mode
bindkey -v

# Enable reverse-i-search
bindkey '^R' history-incremental-search-backward

# Add boost to default C++ include/library paths
export CPLUS_INCLUDE_PATH=/usr/local/include:/opt/homebrew/Cellar/boost/1.76.0/include:$CPLUS_INCLUDE_PATH
export CPLUS_LIBRARY_PATH=/usr/local/lib:/opt/homebrew/Cellar/boost/1.76.0/lib:$CPLUS_LIBRARY_PATH

# Enable ~/.zsh_history
export HISTFILE=~/.zsh_history

# Increase ~/.zsh_history size
export HISTFILESIZE=1000
export HISTSIZE=1000

# Update .bash_history in realtime and share across terminals
setopt SHARE_HISTORY

# Ignore duplicates
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
