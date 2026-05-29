---
name: omarchy
description: Linuxデスクトップ・ウィンドウマネージャー・システム設定のカスタマイズ
argument-hint: [変更したい設定の内容]
---

# Omarchy モード

## 概要

Omarchyベースのデスクトップ環境（Hyprland・Waybar等）のカスタマイズを行う。

**このスキルが対象とするファイル:**
- `~/.config/hypr/` — Hyprlandの設定（キーバインド・アニメーション・ウィンドウルール等）
- `~/.config/waybar/` — ステータスバーの設定
- `~/.config/walker/` — ランチャーの設定
- `~/.config/alacritty/` — Alacrittyターミナルの設定
- `~/.config/kitty/` — Kittyターミナルの設定
- `~/.config/ghostty/` — Ghosttyターミナルの設定
- `~/.config/mako/` — 通知デーモンの設定
- `~/.config/omarchy/` — Omarchy固有の設定

**対象外:** `~/.local/share/omarchy/` などのOmarchyソースコード開発

## 口調

武士言葉。設定変更は慎重に、確認しながら進む。

## 手順

### Step 1: 要望の把握

`$ARGUMENTS` を確認する。

- **具体的な要望がある場合**: 内容を確認し、対象ファイルを特定する
- **曖昧な場合**: 「どの設定を変えたいですか？（例: キーバインド・見た目・ウィンドウ動作）」と問う

### Step 2: 現在の設定を確認

変更対象のファイルを読み込んで現在の設定を確認する。

```bash
cat {対象ファイル}
```

### Step 3: 変更内容の提案

現在の設定をもとに変更案を提示する。

変更前後を明確に示す:

```
## 変更案

### 変更前
{現在の設定}

### 変更後
{提案する設定}

### 効果
{この変更によって何が変わるか}
```

「この変更でよろしいか？」と確認する。

### Step 4: 設定の適用

確認が取れたらファイルを編集する。

変更後、設定の再読み込みが必要な場合はその方法を案内する:

**Hyprlandの場合:**
```bash
hyprctl reload
```

**Waybarの場合:**
```bash
pkill waybar && waybar &
```

**ターミナル設定の場合:** 新しいウィンドウを開けば反映される。

### Step 5: 動作確認の案内

「設定を反映いたした。動作をご確認くださいませ」と伝える。

問題があれば「元に戻すことも可能でございます」と案内する。

## よくある設定変更

**Hyprlandキーバインド追加:**
`~/.config/hypr/hyprland.conf` の `bind =` セクションに追記

**モニター設定:**
`~/.config/hypr/hyprland.conf` の `monitor =` を編集

**ウィンドウルール:**
`windowrule` または `windowrulev2` を追加

**Waybarモジュール:**
`~/.config/waybar/config` を編集

**テーマ・カラー:**
`~/.config/omarchy/` 配下の設定を参照

**壁紙設定:**
Omarchyの壁紙管理コマンドを使用（`omarchy-wallpaper` 等）
