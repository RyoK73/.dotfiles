# カスタムスキル一覧

## 思考・設計

| スキル | 引数 | 説明 |
|---|---|---|
| /think | [テーマ・問題] | アイデアの壁打ち。実装はしない思考パートナー |
| /guide | [テーマ・問題] | 師匠モード。設計・実装前に体系的な知識を注入する |
| /map | [@ファイル（省略可）] | 頭の霧を晴らし課題を具体化。ドキュメント＆GitHub Issue保存 |
| /retro | [実装・設計] | 実装後の振り返り。狂言・能口調で設計と判断を共に見直す |
| /launch | [プロジェクト名] | MVPキックオフ。目標→設計→タスク分解→実行ランウェイ生成 |

## ナレッジ管理

| スキル | 引数 | 説明 |
|---|---|---|
| /research | [トピック] | 調査→Zettelkasten文献ノート作成 |
| /zettel | [テーマ] | 永続ノート（Zettelkasten）作成 |
| /devnote | [範囲・内容] | 開発メモ・デバッグ解決策を literature/ に保存 |
| /capture | [内容] | 思いつきをすぐInboxへ。対話不要 |
| /insights | — | GTD＋Zettelkastenデータを分析してパターンを可視化 |

## GTD・タスク管理

| スキル | 引数 | 説明 |
|---|---|---|
| /morning | — | 朝のプランニング。GitHub Issue同期＋今日の計画 |
| /daily-log | — | 日次振り返りを記録 |
| /weekly-review | — | GTD週次レビュー。Issue同期＋振り返り＋次週計画 |
| /gtd-inbox | — | Inbox整理。アイテムを1件ずつ対話形式で処理 |

## 転職活動

| スキル | 引数 | 説明 |
|---|---|---|
| /tennsyoku | — | 転職活動ダッシュボード。全体状況を俯瞰 |
| /job-research | [企業名] | 企業調査→ career/companies/ にプロファイル作成 |
| /job-track | [企業名・ステータス] | 応募・選考状況の記録と更新 |
| /interview-prep | [企業名・テーマ] | 面接対策・自己分析 |
| /curriculum | [目標・フェーズ] | 学習ロードマップの表示・更新 |

## 開発・コードレビュー

| スキル | 引数 | 説明 |
|---|---|---|
| /pr-review | [PRタイトルのヒント] | 変更の意図・設計を壁打ちし、5観点レビュー後にPR下書き作成 |
| /post-review | [記事ファイルパス or slug] | ブログ記事を5軸で監査。公開前の品質チェック |
| /design-md | [参考UI/サービス名やURL（省略可）] | Stitch仕様のDESIGN.md生成。コード解析＋参考UI調査＋対話でトークン抽出 |

## その他

| スキル | 引数 | 説明 |
|---|---|---|
| /create-issues | — | /map や /launch で練った構想をGitHub Issuesに一括作成 |

## スキルの追加・変更・削除

`~/.claude/skills/` 配下に `{スキル名}/SKILL.md` を追加・変更・削除したときは、このファイルのインデックスも更新すること。

各スキルのファイル:
- `~/.claude/skills/think/SKILL.md`
- `~/.claude/skills/guide/SKILL.md`
- `~/.claude/skills/map/SKILL.md`
- `~/.claude/skills/retro/SKILL.md`
- `~/.claude/skills/launch/SKILL.md`
- `~/.claude/skills/research/SKILL.md`
- `~/.claude/skills/zettel/SKILL.md`
- `~/.claude/skills/devnote/SKILL.md`
- `~/.claude/skills/capture/SKILL.md`
- `~/.claude/skills/insights/SKILL.md`
- `~/.claude/skills/morning/SKILL.md`
- `~/.claude/skills/daily-log/SKILL.md`
- `~/.claude/skills/weekly-review/SKILL.md`
- `~/.claude/skills/gtd-inbox/SKILL.md`
- `~/.claude/skills/tennsyoku/SKILL.md`
- `~/.claude/skills/job-research/SKILL.md`
- `~/.claude/skills/job-track/SKILL.md`
- `~/.claude/skills/interview-prep/SKILL.md`
- `~/.claude/skills/curriculum/SKILL.md`
- `~/.claude/skills/create-issues/SKILL.md`
- `~/.claude/skills/pr-review/SKILL.md`
- `~/.claude/skills/post-review/SKILL.md`
- `~/.claude/skills/design-md/SKILL.md`
