# dotfiles

bare git方式でdotfilesを管理するリポジトリです。

## 仕組み

`~/.dotfiles/` にbare リポジトリ（gitの管理データのみ）を置き、`$HOME` をワーキングツリーとして外から指定します。ファイルを移動したりシンボリックリンクを張ったりせず、元の場所のまま管理できます。

```
~/.dotfiles/    ← gitの管理データ（bare リポジトリ）
$HOME/          ← ワーキングツリー（ファイルはここに存在したまま）
```

## 初回セットアップ

```bash
# bare リポジトリを作成
git init --bare $HOME/.dotfiles

# config エイリアスを登録（毎回長いオプションを打たなくて済むように）
echo "alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> ~/.zshrc
source ~/.zshrc

# 追跡していないファイルを status に表示しないように
config config --local status.showUntrackedFiles no
```

## ファイルを追加・プッシュ

```bash
config add ~/.zshrc
config add ~/.config/hypr/hyprland.conf
config add ~/.config/waybar/config
# ...管理したいファイルを追加

config commit -m "initial dotfiles"
config remote add origin git@github.com:yourname/dotfiles.git
config push -u origin main
```

通常の `git` が `config` になっているだけで、操作感は同じです。

## 新しいマシンに復元する

```bash
# .zshrc がまだ展開されていないためエイリアスを手動で定義
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ~/.dotfiles/ が既にあると clone が失敗するので除外
echo ".dotfiles" >> .gitignore

# bare 形式でクローン（この時点ではまだファイルは展開されない）
git clone --bare git@github.com:yourname/dotfiles.git $HOME/.dotfiles

# $HOME の正しいパスにファイルを展開
config checkout
config config --local status.showUntrackedFiles no
```

既存ファイルと競合する場合はエラーになります。その場合はバックアップしてから再実行してください。

```bash
mkdir -p ~/.dotfiles-backup
config checkout 2>&1 | grep "\t" | awk '{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/{}
config checkout
```

## コマンド一覧
### 日常の使い方
| コマンド | ジャンル | 意味 |
|---|---|---|
| `config status` | 日常使い | 変更されたファイルを確認する |
| `config add ~/.zshrc` | 日常使い | ファイルをステージングに追加する |
| `config commit -m "message"` | 日常使い | 変更をコミットする |
| `config push` | 日常使い | リモートに反映する |
| `config diff` | 日常使い | 変更内容の差分を確認する |

### 初期設定
| コマンド | ジャンル | 意味 |
|---|---|---|
| `git init --bare $HOME/.dotfiles` | 初期設定 | bare リポジトリを作成する |
| `config config --local status.showUntrackedFiles no` | 初期設定 | 未追跡ファイルを status に表示しないようにする |
| `config remote add origin <url>` | 初期設定 | リモートリポジトリを登録する |
| `git clone --bare <url> $HOME/.dotfiles` | 復元 | bare 形式でリポジトリをクローンする |
| `config checkout` | 復元 | ファイルを `$HOME` の正しいパスに展開する |
