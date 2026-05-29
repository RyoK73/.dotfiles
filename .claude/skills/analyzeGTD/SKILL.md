---
name: analyzeGTD
description: インサイト分析
context: fork
---

# インサイト分析

GTDとZettelkastenのデータを分析してパターンとインサイトを可視化する。

## 手順

### 1. データ収集（並列実行）

以下を同時に読み込む：
- `~/dev/LIFE/gtd/daily-logs/` の全日報ファイル
- `~/dev/LIFE/gtd/next-actions/done/` の全完了タスク（created と completed 日付を確認）
- `~/dev/LIFE/gtd/next-actions/items/` の現在のタスク数

### 2. 分析

以下の観点で分析する：

**タスク完了分析**
- 週別完了数のトレンド
- 平均リードタイム（created → completed 日数）
- 長期滞留タスク（7日以上 items に残っているもの）

**エネルギーパターン**
- daily-logsの `energy:` フィールドを集計
- エネルギーが高い曜日・低い曜日のパターン

**気づきの傾向**
- daily-logsの気づきセクションから頻出キーワードを抽出
- Zettelkastenのタグ使用頻度

**知識ネットワーク**
- `zettelkasten/permanent/` のノート数
- `zettelkasten/literature/` のノート数
- 孤立ノート（links が空のもの）の検出

### 3. レポート出力

```markdown
## 📊 インサイトレポート（YYYY-MM-DD）

### タスク
- 累計完了: X件
- 今週完了: X件
- 平均リードタイム: X日
- 長期滞留: X件（要対応）

### エネルギー傾向
- 平均: X.X / 5
- 高い曜日: <曜日>
- 低い曜日: <曜日>

### 気づきの頻出テーマ
1. <テーマ>（X回）
2. <テーマ>（X回）
3. <テーマ>（X回）

### 知識ネットワーク
- Permanentノート: X件
- Literatureノート: X件
- 孤立ノート: X件（リンク付けを推奨）

### 提案
<データから読み取れる改善提案>
```
