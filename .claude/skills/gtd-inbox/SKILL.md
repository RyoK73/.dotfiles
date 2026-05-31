---
name: gtd-inbox
description: GTD Inbox整理
context: fork
---

# GTD Inbox整理

`~/dev/LIFE/tasks/inbox/` のアイテムを1件ずつ対話形式で整理する。

## Step 0: GitHub Issue → Inbox同期

最初に以下を実行し、リモートのIssueをローカルInboxに取り込む。

```bash
gh issue list --repo RyoK73/LIFE --state open --json number,title,body,labels,createdAt --limit 100
```

取得したIssueそれぞれについて：

1. `~/dev/LIFE/tasks/inbox/YYYYMMDD-HHMMSS-issue-<number>.md` を作成する：

```markdown
---
captured: YYYY-MM-DD HH:MM:SS
source: github-issue
issue-number: <number>
labels: [<label1>, <label2>]
---

<title>

<body（空なら省略）>
```

2. 作成後、GitHubのIssueをクローズする：

```bash
gh issue close <number> --repo RyoK73/LIFE --comment "GTD inboxに取り込みました"
```

Issueが0件なら同期をスキップして次のステップへ進む。
取り込んだ件数を「GitHubから X件取り込みました」と報告すること。

---

## Step 1: Inbox整理

1. inbox ディレクトリのファイル一覧を取得する
2. ファイルが0件なら「Inboxは空でございます」と報告して終了
3. 各ファイルを順番に処理する：

### 各アイテムの処理フロー

ファイルの内容を読み込み、以下を対話で確認する：

**Q1: このアイテムはアクション可能ですか？**
- `yes` → Q2へ
- `no` → 参照資料か削除か確認。参照なら `notes/` へ移動、削除なら削除
- `waiting` → `tasks/waiting/` へ移動、誰を待っているか追記
- `someday` → `tasks/someday/` へ移動

**Q2: 2分以内にできますか？**
- `yes` → 「今すぐやりましょう」と伝え、完了後 `tasks/next/done/` へ
- `no` → Q3へ

**Q3: コンテキストは？**
- `@computer` / `@home` / `@phone` / `@errands` から選択

**Q4: 締め切りはありますか？**
- 日付入力または `none`

**Q5: プロジェクトに属しますか？**
- プロジェクト名を入力、または `none`

### Next-Actionファイルの作成

`tasks/next/YYYYMMDD-HHMMSS-<slug>.md` を以下の形式で作成：

```markdown
---
title: <タイトル>
created: YYYY-MM-DD
due: <due または空>
project: <project または空>
context: <@context>
priority: medium
---

<元のinboxの内容>
```

作成後、inboxの元ファイルを削除する。

## 完了時

全アイテム処理後、整理結果のサマリーを出力する：
- next-actions化: X件
- waiting: X件
- someday: X件
- 削除: X件
- notes移動: X件
