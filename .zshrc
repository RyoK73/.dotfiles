# ===
# env
# ===

export EDITOR="nvim"
# ===
# Lines configured by zsh-newuser-install
# ===

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install

# ===
# setopt
# ===

setopt auto_cd
setopt PROMPT_SUBST

# ===
# zinit
# ===

ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit
zinit light zsh-users/zsh-completions

zinit light Aloxaf/fzf-tab # tabでファイル検索

# aliasをexpand
zinit light MenkeTechnologies/zsh-expand 
export ZPWR_EXPAND_TO_HISTORY=true
export ZPWR_EXPAND_PREVIEW=true
export ZPWR_EXPAND_PRE_EXEC_NATIVE=true
# ===
# キーバインディング
# ===
#
## fzf
#
## CTRL+Tの上下移動をTab/Shift+Tabで
export FZF_CTRL_T_OPTS="
  --bind='tab:down'
  --bind='shift-tab:up'
"
## CTRL+Rの上下移動をTab/Shift+Tabで
export FZF_CTRL_R_OPTS="
  --bind='tab:down'
  --bind='shift-tab:up'
"

# zsh

bindkey "^A" autosuggest-accept
bindkey "^P" forward-word


source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# zinit snippet OMZ::plugins/git/git.plugin.zsh # OMZのgitプラグインを追加する

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

export PATH="$HOME/.local/bin:$PATH"

# ===
# プロンプトをグラフィカルにスタイリング
# ===
# --- prompt helpers ---

parse_git_count() {
    git status --porcelain 2>/dev/null | grep -cE "^ M|^\?\?|^ D"
}

_git_prompt() {
    local branch
    branch=$(git branch 2>/dev/null | grep '^*' | sed 's/^\* //')
    [[ -z "$branch" ]] && return
    if [[ $(git status -s 2>/dev/null) ]]; then
        echo -n "%K{237}%F{yellow}%B  ${branch} 🔀 $(parse_git_count) %b%f%k"
    else
        echo -n "%K{237}%F{green}%B  ${branch} ✅ 0 %b%f%k"
    fi
}

_venv_info() {
    [[ -n "$VIRTUAL_ENV" ]] && echo -n "%K{green}%F{black} ${VIRTUAL_ENV##*/} %f%k"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT='$(_venv_info)%K{magenta}%F{black} %n@%m %f%k%K{red}%F{white} 🧭 %~ %f%k$(_git_prompt)
%B%F{green}╰> $ %f%b'


# ===
# pnpm
# ===

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

function pnpm-dev(){
  fuser -k 3000/tcp
  pnpm dev
}

# ===
# Zsh
# ===
alias -s {md,ts,tsx,js,jsx,json,jsonc,conf,toml,yaml,yml,toml,html,css,zshrc}=$EDITOR

alias ls="ls -a1"
alias cat="bat"
function trc () {
  if [[ "$1" == "" ]]; then
    tree $PWD | cat
  else
    tree "$1" | cat
  fi
}

# ===
# helix
# ===

alias hx="helix"

# ===
# claude code
# ===

alias ccp="claude --permission-mode plan"
alias cc="claude"
alias cct="claude /think"
function skills-tutor () {
  if [[ -f "$HOME/.claude/skills-tutor.md" ]]; then
    cat "$HOME/.claude/skills-tutor.md"
  else
    echo "$HOME/.claude/skills-tutor.mdがありません"
  fi
}


# ===
# Git
# ===

alias gcm="git commit -m"
alias gam="git commit --amend --no-edit"
alias gst="git status"
alias gd="git diff"
# Git remoteでマージ済みのローカルブランチを削除する
function git-cleanup() {
  git fetch --prune
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d
  echo ""
  echo 💫残りのローカルブランチ💫
  echo ""
  git branch
}

# ===
# dotfiles用/Config
# ===

function config() {
  if [[ "$1" == "add" && ( "$2" == "." || "$2" == "-A" ) ]]; then
    echo "HOME すべてを追跡することになるため、config add . / -A は無効化されています。"
    return 1
  fi
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}

alias coa="config add" # dotfiles commit -m
alias coc="config commit" # dotfiles commit -m
function coac() {
    config add "$1" && config commit
    
}
function coacu() {
    if [[ -d "$1" ]]; then
        config add -u "$1" && config commit
    else
        echo "$1はディレクトリではありません"
    fi
}
function coacup() {
    if [[ -d "$1" ]]; then
        config add -up "$1" && config commit
    else
        echo "$1はディレクトリではありません"
    fi
}
alias cocm="config commit -m" # dotfiles commit -m
alias cocma="config commit -am" # dotfiles commit -am : 追跡しているファイルの変更をaddしてcommitする
alias cost="config status" # dotfiles status : ステータス確認
alias cop="config push origin main"

# ===
# LIFE用
# ===

function life-tutor() {
  if [[ -d "$HOME/dev/LIFE" ]]; then
    cat "$HOME/dev/LIFE/README.md"
  else
    echo "${HOME}/dev/LIFEがありません"
  fi
}

# ===
# waybar
# ===
alias waybar-reload="pkill waybar && waybar & disown"


# ===
# hyprland
# ===
alias hypr-reload="hyprctl reload"
