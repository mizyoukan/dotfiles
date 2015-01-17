bindkey -e

setopt auto_cd
setopt auto_pushd

autoload -Uz colors
colors

PROMPT='%F{blue}[%n@%m]$ %f'
RPROMPT='%1(v|%F{green}%1v%f|)%f[%~]'

setopt prompt_subst

# VCS {{{
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable hg git svn
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b:%a]'
zstyle ':vcs_info:svn:*' branchformat '%b:r%r'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '[%c%u%b]'
  zstyle ':vcs_info:git:*' actionformats '[%c%u%b|%a]'
fi

function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_vcs_info_msg
# }}}

# Completion {{{
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
setopt globdots
# }}}

# cdr {{{
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

if [ ! -d $HOME/.cache/shell ]; then
  mkdir -p $HOME/.cache/shell
fi
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true
# }}}

# History {{{
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt share_history
setopt hist_ignore_dups
# }}}

# Aliases {{{
case "${OSTYPE}" in
  linux*)
    alias ls='ls -F --color=auto'
    alias ll='ls -Fhl --color=auto --group-directories-first'
    alias la='ls -Fhal --color=auto --group-directories-first'
    ;;
esac

alias rm='rm -i'
alias cp='cp -i'
alias cp='mv -i'

alias vi='vim'
alias emacs='emacs -nw'
alias em='emacs -nw'
# }}}

# Commands {{{
if [[ -x `which peco 2>/dev/null` ]]; then
  peco-edit-dotfiles() {
    local selected_file=$(find ~/dotfiles -type f | grep -v '.git/' | peco)
    if [ -n "$selected_file" ]; then
      BUFFER="vim ${selected_file}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-edit-dotfiles
  bindkey '^u' peco-edit-dotfiles

  peco-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-cdr
  bindkey '^@' peco-cdr
fi
# }}}
