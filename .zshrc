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
export ZPWR_EXPAND_TO_HISTORY=true
# export ZPWR_EXPAND_PRE_EXEC_NATIVE=true
zinit light MenkeTechnologies/zsh-expand 
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

PROMPT='$(_venv_info)%K{green}%F{black} %n@%m %f%k%K{blue}%F{black} 🧭 %~ %f%k$(_git_prompt)
%B%F{green}╰> $ %f%b'

ZSH_HIGHLIGHT_STYLES[argument]=`fg=#ffffff`
ZSH_HIGHLIGHT_STYLES[string]=`fg=#ffffff`
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#ffffff:waybar'


# ===
# pnpm
# ===

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias killport="fuser -k 3000/tcp 2>/dev/null"

function pnpm-dev(){
  fuser -k 3000/tcp 2>/dev/null
  pnpm dev
}

# ===
# Zsh
# ===
alias -s {md,ts,tsx,js,jsx,json,jsonc,conf,toml,yaml,yml,toml,html,css,zshrc}=$EDITOR

alias ls="ls -a1"
alias cat="bat"
alias trc="tree . | cat"
alias xopen="xdg-open"

# catしたファイルの内容をコピーする
function catc() {
  cat "$1" | wl-copy
}

# ===
# helix
# ===

alias hx="helix"

# ===
# claude code
# ===

alias cc="claude"
alias cct="claude /think"
alias ccr="claude -r"
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
alias gsw="git switch"
alias gswc="git switch -c"

alias ga="git add --verbose"
alias gap="git add --verbose -p"

alias gc="git commit --verbose"
alias gcm="git commit -m"
alias gcp="git commit -p"
alias gcam="git commit --amend"
alias gcamn="git commit --amend --no-edit"

alias gst="git status"

alias gp="git push"
alias gpr="git pull --rebase"

alias gd="git diff"

alias gss="git stash push -m"
alias gsp="git stash pop"
alias gsl="git stash list"

# Git remoteでマージ済みのローカルブランチを削除する
function git-cleanup() {
  git fetch --prune
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d
  echo
  echo 💫残りのローカルブランチ💫
  echo
  git branch
}

# merge済みのgit worktreeを削除する
# ディレクトリの削除・ブランチの削除
function git-cut() {
  git fetch
  git branch -vv | grep ': gone' | awk '{
    if ($1 == "+") {
      gsub(/[()]/,"",$4); print $2,$4
    } else { print $1,"" }
  }' | while read branch wt_path; do
    [[ -n "$wt_path" ]] && git worktree remove "$wt_path"
    git branch -d "$branch"
  done
  echo
  echo 💫残りのローカルブランチ💫
  echo
  git branch
}

# どこでもgit issue
# dev/confにあるテンプレートはconfigで管理
function git-idea() {
  local dir=$(find ~/dev -maxdepth 1 -type d | fzf --prompt "cd: " --preview 'ls {}')
  [ -n "$dir" ] && cd "$dir"
  gh issue create -F ~/dev/conf/1-idea.md -e -t"idea: "
}

# git worktree

function git-plant() {
  if ! git rev-parse --git-dir &>/dev/null; then
    echo "not a git directory"
    return
  elif ! git rev-parse HEAD --git-dir &>/dev/null; then
    echo "commitがありません"
    return
  elif [[ -z "$1" ]]; then
    echo "ブランチ名を指定してください"
    return
  fi
  local branchdir="../$(basename $(git rev-parse --show-toplevel))-$1"
  git worktree add -b "$1" "$branchdir" "${2:-main}"
  cd "$branchdir"
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
alias coap="config add -p"
alias coc="config commit" # dotfiles commit -m
alias coca="config commit -a"
alias cocp="config commit -p"
alias crh="config reset HEAD"
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
# ショートカットalias
# ===
alias waybar-reload="pkill waybar && waybar & disown"
alias hypr-reload="hyprctl reload"
alias mozc-setup="fcitx5-config-qt"
