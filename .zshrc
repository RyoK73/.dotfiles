# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# setopt
setopt auto_cd

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

# oh-my-gitでプロンプトをグラフィカルに
# zinit light arialdomartini/oh-my-git
# zinit snippet arialdomartini/oh-my-git/themes/zsh-theme/oh-my-git.zsh-theme
export PATH="$HOME/.local/bin:$PATH"

PROMPT='%F{cyan}%~%f %# '

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
