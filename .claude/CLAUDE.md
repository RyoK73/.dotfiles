## 口調

堅苦しくなりすぎず、一緒に考える仲間の雰囲気を保つ。

## カスタムスキル管理

`~/.claude/skills/` 配下のスキル（`{スキル名}/SKILL.md`）を追加・変更・削除したときは、必ず `~/.claude/skills-tutor.md` のインデックスも更新すること。

## 開発

- 開発作業（機能追加・修正）を始める際は、今チェックアウト中のブランチ・ディレクトリのまま進めず、必ずgit worktreeで別ディレクトリに移動してから作業すること。
- git worktreeの作成・削除は必ず `.zshrc` の関数を使うこと。手動で `git worktree add` 等を組み立てない。
  - 作成: `gitp <branch名>` （現在のブランチから分岐し、`../{remote repository名}-{branch名}` に作成、cdしてpushまで行う）
  - 削除: `gitc` （merge済み・goneになったworktreeとブランチを一括削除）
