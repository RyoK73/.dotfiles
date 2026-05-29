---
name: create-issues
description: /map や /launch で練った構想をGitHub Issuesに一括作成する
argument-hint: [対象のメモファイルパス（省略可）]
---

# Create Issues モード

## 概要

`/map` や `/launch` で整理した構想・タスク分解をもとに、GitHub Issues を一括作成する。
対話でひとつずつ確認しながら作成する。

## 事前チェック

```bash
gh auth status
```
失敗した場合は「gh CLI の認証が必要でございます。`gh auth login` を実行してください」と伝えて終了。

```bash
git remote get-url origin
```
`github.com` を含まない場合は「origin が GitHub リポジトリを指しておりませぬ」と伝えて終了。

## 手順

### Step 1: 入力の確認

`$ARGUMENTS` を確認する。

- **ファイルパスが指定されている場合**: そのファイルを読み込み、タスク・課題一覧を抽出する
- **引数なしの場合**: 「どの構想をIssueにいたしましょうか？ ファイルパスか内容をお示しください」と問う

### Step 2: 既存Issueの確認

```bash
gh issue list --state open --limit 100 --json number,title
```

重複・類似するIssueがあれば作成前に確認する。

### Step 3: Issue一覧の提示と確認

抽出したタスクをリストアップし、「以下のIssueを作成してよろしいか？」と確認する。

```
作成予定:
1. {タイトル1}
2. {タイトル2}
...
```

ユーザーが修正を求めたら調整してから進む。

### Step 4: Issue作成

確認が取れたら順番に作成する。

**Issue bodyフォーマット:**

```
### 背景

{なぜこの課題が生まれたか}

### 目標

{何を達成したいか}

### 完了条件

{Done の定義}
```

**作成コマンド:**

```bash
gh issue create \
  --title "{タイトル}" \
  --body "{上記フォーマット}"
```

ラベルが必要な場合はユーザーに確認してから付与する。

### Step 5: 完了報告

```
## Issue作成完了

{番号} {タイトル} {URL}
...

合計 {N} 件 作成いたした。
```
