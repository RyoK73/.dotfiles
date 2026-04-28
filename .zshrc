# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# setopt
setopt auto_cd
setopt PROMPT_SUBST

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit
zinit light zsh-users/zsh-completions

zinit light Aloxaf/fzf-tab # tabでファイル検索
# fzfキーバインディング
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh # OMZのgitプラグインを追加する

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

export PATH="$HOME/.local/bin:$PATH"

# プロンプトをグラフィカルにスタイリング
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

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# env
export EDITOR="code --wait"

# alias
# zsh
alias ls="ls -a1"

# claude code
alias ccp="claude --permission-mode plan"
alias cc="claude"
alias cct="claude /think"

# Git操作
alias gcm="git commit -m"
alias gam="git commit --amend --no-edit"
# Git remoteでマージ済みのローカルブランチを削除する
function git-cleanup() {
  git fetch --prune
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d
  echo ""
  echo 💫残りのローカルブランチ💫
  echo ""
  git branch
}

# dotfiles用
function config() {
  if [[ "$1" == "add" && ( "$2" == "." || "$2" == "-A" ) ]]; then
    echo "HOME すべてを追跡することになるため、config add . / -A は無効化されています。"
    return 1
  fi
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}
## alias
alias dcm="config commit -m" # dotfiles commit -m
alias dca="config commit -am" # dotfiles commit -am : 追跡しているファイルの変更をaddしてcommitする
alias ds="config status" # dotfiles status : ステータス確認
alias dp="config push origin main"
