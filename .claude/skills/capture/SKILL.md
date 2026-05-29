---
name: capture
description: キャプチャ
argument-hint: <キャプチャする内容>
---

# キャプチャ

思いつきや気になったことを即座にInboxに保存する。対話は不要。

## 手順

1. 現在の日時を取得して、ファイル名を `YYYYMMDD-HHMMSS.md` 形式で決める
2. `~/dev/LIFE/gtd/inbox/` に以下の形式でファイルを作成する：

```markdown
---
captured: YYYY-MM-DD HH:MM:SS
---

$ARGUMENTS
```

3. 「📥 Inboxに保存いたした: `<ファイル名>`」と報告して終了

引数が空の場合は「キャプチャする内容を引数として渡してください」と伝えて終了する。
