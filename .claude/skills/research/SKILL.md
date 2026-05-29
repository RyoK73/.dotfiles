---
name: research
description: リサーチ → 文献ノート作成
context: fork
---

# リサーチ → 文献ノート作成

`$ARGUMENTS` のトピックを調査し、Zettelkastenの文献ノートとして保存する。

## 手順

### 1. トピック確認
引数が空なら「調査するトピックを引数として渡してください」と伝えて終了。

### 2. 調査
WebSearchを使って `$ARGUMENTS` に関する情報を収集する。
複数のソースを参照し、以下の観点で情報を整理する：
- 定義・概要
- 主要な概念・コンセプト
- 実用的な示唆・応用

### 3. 既存ノートとの関連検索
`~/dev/LIFE/zettelkasten/` 全体をgrepで横断検索し、関連するノートを特定する：
```
grep -rl "<キーワード>" ~/dev/LIFE/zettelkasten/
```

### 4. 文献ノートの作成
`~/dev/LIFE/zettelkasten/literature/YYYY-MM-DD-<slug>.md` を作成する：

```markdown
---
id: YYYYMMDDNNN
title: <タイトル>
date: YYYY-MM-DD
type: literature
tags: [<関連タグ>]
links: [<関連ノートのid>]
sources: [<調査したURL>]
---

## 概要

<調査した内容の要約>

## 主要なポイント

- ...
- ...

## 関連する洞察

<既存ノートとの接続・考察>
```

### 5. 双方向リンクの設定
関連ノートが見つかった場合、そのノートの `links:` フィールドにも今回作成したノートのidを追記する。

### 6. 報告
「📚 文献ノートを作成いたした: `<ファイルパス>`」と報告する。
