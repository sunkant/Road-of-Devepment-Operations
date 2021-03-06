#------------------
# Shell Variables
#------------------

# Specify VS Code as default editor for the React Native Simulator
export REACT_EDITOR=code
# Set VS Code Insiders as default code editor
export EDITOR=code
# Android SDK
export ANDROID_HOME=~/Library/Android/sdk
# NVM directory variable
export NVM_DIR="$HOME/.nvm"
# Arc 
export PATH="$HOME/Apps/arcanist/bin:$PATH"

#------------------
# PATH Manipulations
#------------------

# Add mySQL executable to Path
export PATH=$PATH:/usr/local/mysql/bin
# Add Laravel Valet to PATH
export PATH=${PATH}:$HOME/.composer/vendor/bin
# Add Android SDK to path
export PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
# Add ruby to PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.5.0/bin:$PATH"

#------------------
# Zsh hooks
#------------------

# Enable the addition of zsh hook functions
autoload -U add-zsh-hook

# Load NVM and NVM bash completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

# Automatically switch and load node versions when a directory has a `.nvmrc` file
load-nvmrc() {
  local node_version="$(nvm version)" # Current node version
  local nvmrc_path="$(nvm_find_nvmrc)" # Path to the .nvmrc file

  # Check if there exists a .nvmrc file
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    # Check if the node version in .nvmrc is installed on the computer
    if [ "$nvmrc_node_version" = "N/A" ]; then
      # Install the node version in .nvmrc on the computer and switch to that node version
      nvm install
    # Check if the current node version matches the version in .nvmrc
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      # Switch node versions
      nvm use
    fi
  # If there isn't an .nvmrc make sure to set the current node version to the default node version
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
# Run load-nvmrc on initial shell load
load-nvmrc

# Set the tab title to the current working directory before each prompt
function tabTitle () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}

# Executes load-nvmrc when the present working directory (pwd) changes
# add-zsh-hook chpwd load-nvmrc
# Executes tabTitle before each prompt
add-zsh-hook precmd tabTitle

#------------------
# Aliases (for a full list of aliases, run `alias`)
#------------------

# Note: the following aliases overwrite any aliases specified in the Oh My Zsh plugins

# Git Aliases
alias gam="git add --all && git commit -m"
alias gs="git status"
alias gp="git pull"
alias gb="git branch"
alias gcm="git commit -m"
alias gac='git commit -a -m'
alias gca="git commit --amend --no-edit"
alias gcae="git commit --amend"
alias gcaa="git add --all && git commit --amend --no-edit"
alias gcaae="git add --all && git commit --amend"
alias gap="git add -p"
alias gnope="git checkout ."
alias gco="git checkout"
alias gwait="git reset HEAD"
alias gundo="git reset --soft HEAD^"
alias greset="git clean -f && git reset --hard HEAD" # Removes all changes, even untracked files
alias gl="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glb='git log --oneline --decorate --graph --all'
alias gst='git status -s'
alias gpl="git pull --rebase"
alias gps="git push"
alias gpsf="git push --force-with-lease"
alias grb="git rebase"
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
# Remove local branches that have already been merged in the remote repository
alias gcmb="git branch --merged | grep -Ev '(^\*|master)' | xargs git branch -d"
# Sets the upstream branch to be the same branch as the locally named branch
alias gset='git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`'
# Do an interactive rebase back N number of commits (e.g. grn 3)
grn() { git rebase -i HEAD~"$1"; }
# Do an interactive rebase to a supplied commit hash (e.g. grbc 80e1625)
grbic() { git rebase -i "$1"; }

# General Aliases

# Open .zshrc to be editor in VS Code
alias change="code ~/.zshrc"
# Re-run source command on .zshrc to update current terminal session with new settings
alias update="source ~/.zshrc"
# Use the VS Code insiders build by default for the `code` CLI commands
alias co="code"
# cd into iCloud drive folder in terminal
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"
# View files/folder alias using colorsls (https://github.com/athityakumar/colorls)
alias l='colorls --group-directories-first --almost-all'
alias ll='colorls --group-directories-first --almost-all --long'
# Clear terminal
alias c='clear'

#------------------
# Miscellaneous
#------------------

# Allow the use of the z plugin to easily navigate directories
. /usr/local/etc/profile.d/z.sh

# Set Spaceship ZSH as a prompt
autoload -U promptinit
promptinit
prompt spaceship

# Add colors to terminal commands (green command means that the command is valid)
source ~/Apps/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source $(dirname $(gem which colorls))/tab_complete.sh

# input history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Python (if needed)
# PYTHONPATH="/usr/local/lib/python3.7/site-packages:$PYTHONPATH"
# export PYTHONPATH

# 添加User下面的bin目录
export PATH="$PATH:$HOME/bin"

# Go
export GOPATH=/Users/$USER/go
export PATH=$GOPATH/bin:$PATH
