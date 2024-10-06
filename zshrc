if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ~/dotfiles/oh-my-posh.yml)"
fi


# Plugins
plugins=(git)
# fpath=(~/.zsh $fpath) # Add completion functions to fpath
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
setopt interactive_comments # Fix for zsh-autocomplete
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

## User configuration
export CLICOLOR=1
export COLORTERM=1
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=5000

# Bind CTRL + arrows
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source <(fzf --zsh)

eval $(thefuck --alias)

## Toolchains & languages

# Java
# ___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

## Aliases
alias sshserver="ssh root@$SERVER_IP"
alias v="nvim"
alias zshupd="exec zsh"
alias vedit="nvim ~/.config/nvim"
alias zedit="nvim ~/.zshrc"
alias wedit="nvim ~/.config/wezterm/wezterm.lua"

alias st="swift test 2>&1 | xcbeautify"
alias sb="swift build"
alias sr="swift run"

# export PATH=$PATH:~/.platformio/packages/toolchain-xtensa-esp32s3/bin
# export PATH=$PATH:/Applications/Docker.app/Contents/Resources/bin
# export PATH=$PATH:~/Qt/6.7.2/macos/bin
