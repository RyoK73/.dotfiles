---
name: morning
description: 朝のプランニング
context: fork
---

# 朝のプランニング

今日（$CURRENT_DATE）の朝のプランニングを行う。

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

Issueが0件なら同期をスキップして次のステップへ進む。
取り込んだIssue数を記録しておくこと（ブリーフィングで報告する）。

---

## Step 1: データ収集

以下を並列で確認すること：

1. `~/dev/LIFE/gtd/inbox/` 内のファイル数と内容をざっくり確認
2. `~/dev/LIFE/gtd/next-actions/items/` を全スキャンし、`due` フィールドが今日以前のタスクを抽出
3. `~/dev/LIFE/gtd/daily-logs/` から昨日の日報ファイルを探し、繰り越しタスクを確認
4. Google Calendar MCPが利用可能なら本日の予定を取得する

収集した情報をもとに、以下の形式で朝のブリーフィングを出力すること：

```
## 📋 朝のブリーフィング（YYYY-MM-DD）

### 📥 Inbox
- GitHubから取り込み: X件（Step 0で同期したIssue数）
- 未処理合計: X件
  （3件以上あれば /gtd-inbox での整理を提案）

### ⚡ 今日の期限タスク
- （タスク名・プロジェクト・due）

### 📅 本日の予定
- （カレンダーから取得、またはN/A）

### 🔁 昨日の繰り越し
- （昨日の日報から抽出）

---

## 🎯 今日やること TOP3（提案）
1. ...
2. ...
3. ...
```

出力後、「この優先順位でよろしいですか？変更があればお申し付けください」と確認する。
