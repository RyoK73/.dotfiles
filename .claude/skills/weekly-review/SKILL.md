---
name: weekly-review
description: 週次レビュー
context: fork
---

# 週次レビュー

今週（$CURRENT_DATE 時点）のGTD週次レビューを実施する。

## Step 0: GitHub Issue → Inbox同期

最初に以下を実行し、リモートのIssueをローカルInboxに取り込む。

```bash
gh issue list --repo RyoK73/LIFE --state open --json number,title,body,labels,createdAt --limit 100
```

取得したIssueそれぞれについて：

1. `~/dev/LIFE/gtd/inbox/YYYYMMDD-HHMMSS-issue-<number>.md` を作成する：

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

取り込んだ件数を記録しておく（レポートで報告する）。

---

## Step 1: データ収集（並列実行）

以下を同時に確認する：
- `~/dev/LIFE/gtd/inbox/` の件数とファイル一覧
- `~/dev/LIFE/gtd/next-actions/items/` の全タスク（プロジェクト別に整理）
- `~/dev/LIFE/gtd/waiting/` の全ファイル（created日からの経過日数を計算）
- `~/dev/LIFE/gtd/someday/` の全ファイル一覧
- `~/dev/LIFE/gtd/projects/` の全プロジェクトファイル
- 過去7日分の `~/dev/LIFE/gtd/daily-logs/` の振り返り

### 2. レビューレポート出力

```
## 📊 週次レビュー（YYYY-MM-DD）

### 📥 Inbox
- 残件: X件（処理が必要）

### ⚡ Next Actions
- 合計: X件
- プロジェクト別:
  - <プロジェクト名>: X件
- 期限超過: X件（要対応）

### ⏳ Waiting
- <アイテム> — X日経過（<誰を待っているか>）

### 🗓️ Someday/Maybe
- 合計: X件（直近で実行可能なものがあれば提案）

### 📁 プロジェクト状況
- <プロジェクト名>: <状態・次のアクション>

### 📓 今週の振り返りサマリー
（daily-logsから気づきを要約）
```

### 3. 対話形式でレビュー

以下を1つずつ確認する：

**Inbox**: 「Inboxに${N}件あります。/gtd-inbox で整理しますか？」

**Waiting**: 「7日以上経過しているWaiting: <件名> はフォローアップしますか？ (yes/skip)」

**Someday**: 「Someday: <件名> をNext Actionに昇格させますか？ (yes/skip)」

**プロジェクト**: 「<プロジェクト名> の次のアクションは設定されていますか？」

### 4. 変更の保存

対話での決定に基づいてファイルを移動・更新する。
