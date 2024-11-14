setopt HIST_IGNORE_DUPS   # Ignore duplicate entries in history
setopt HIST_IGNORE_ALL_DUPS   # Ignore duplicate entries in history
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS  # Prevent duplicates in history search
setopt INC_APPEND_HISTORY # Write to history file immediately
setopt SHARE_HISTORY      # Share command history across all sessions
setopt AUTO_CD            # Change directory without 'cd' command
setopt HIST_IGNORE_SPACE

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Alias definitions
alias lt="eza --icons --color=always -a -s=type -l -T -L2"
alias ls="eza --icons --color=always -a -s=type"
alias ll="eza --icons --color=always -a -s=type -l"
alias gs="git status"
alias gc="git commit -am "
alias gco="git checkout"
alias gpa="git pull --all"
alias grep='grep --color=auto'
alias weather='curl  wttr.in/ssa'
alias fzfprev='fzf -m --preview="bat --color=always {}"'
alias fzf_nvim='nvim < $(fzf -m --preview="bat --color=always {}")'
alias fzf_kill='kill -9 **'
alias ollama_run="docker compose exec ollama ollama run llama3.2"


# Ruby stuffs
alias be='bundle exec'
alias bi='bundle install'
alias be_server='bundle exec rails s --binding=0.0.0.0'
alias be_rake='bundle exec rake'
alias be_rspec='bundle exec rspec'

# Some fixes
alias zoom="QT_QPA_PLATFORM=wayland zoom"

# flutter stuffs
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

# Path settings
export PATH=$PATH:$HOME/.config/emacs/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH

. "$HOME/.asdf/asdf.sh"

eww() {
  emacsclient -a '' -t -e '(eww-browse-url "'"$1"'")'
}

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light Tarrasch/zsh-autoenv

# unalias zi
#### ENF ZINIT



# FZF tab config
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Emacs keybinding
bindkey -e
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

source <(fzf --zsh)
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

