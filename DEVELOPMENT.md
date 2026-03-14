# 開発フロー (Development Guide)

## SDD（仕様駆動開発）

本プロジェクトは **SDD（Specification-Driven Development）** を採用しています。

| フェーズ | 内容 |
|---|---|
| **PLANNING** | `blueprint.md` に仕様を記述し、ユーザーレビューを経て承認 |
| **EXECUTION** | 仕様に基づきコード実装。feature ブランチで作業 |
| **VERIFICATION** | テスト実行、リント確認、ブラウザ検証 |

SDDを採用する理由は、AIが「コードがこう動いているから正しい」と判断してしまう問題を防ぐためです。仕様を先に定義することで、テストの期待値に根拠が生まれ、トートロジー（循環論法）を防止できます。

---

## デュアルAIワークフロー

### セッション開始時（チェックイン）

新しい開発セッションを始める際は、まずバックグラウンドのJulesから届いたPRを確認します。

1. **未マージPRの確認**: `gh pr list` で Jules からのPR一覧を取得
2. **PRのレビューとマージ**: 変更内容を確認し、テストが通ることを確かめてからマージ
3. **ローカルの同期**: `git pull origin main` で最新状態を取得

### 開発中

Antigravity上で5つの専門ロール（Architect, Specialist, Backend Engineer, Documenter, QA Agent）が分業してプロダクトを開発します。開発中に気づいた品質課題や改善点は、GitHub Issueとして起票していきます。

### セッション終了時（チェックアウト）

1. **改善点の整理**: 開発中に気づいた課題や残タスクを、テーマごとにGitHub Issueとして起票
2. **`jules` ラベルの付与**: Issueに `jules` ラベルを付けると、Julesが自動的に対応を開始します
3. **完了報告**: ユーザーに作業完了とJulesへの委譲完了をセットで報告

翌朝までにJulesが並列で改善PRを作成してくれるので、次のセッション開始時にレビュー・マージするところからスタートします。

---

## ブランチ戦略（Feature Branch Flow）

コード変更は必ず feature ブランチで作業し、CIパス後にPRマージします。`main` への直接 push はドキュメントのみの変更に限り許容されます。

### ブランチ命名

| prefix | 用途 | 例 |
|---|---|---|
| `feat/` | 新機能 | `feat/user-auth` |
| `fix/` | バグ修正 | `fix/login-error` |
| `docs/` | ドキュメント | `docs/update-readme` |
| `refactor/` | リファクタリング | `refactor/db-layer` |

---

## コンフリクト回避原則（Julesタスク設計）

[Antigravity](https://antigravity.google) が開発を続けながら [Jules](https://jules.google.com/) にIssueを投げる場合、以下のルールに従います。

### ルール

1. **レイヤー分離**: Julesに渡すタスクは「Antigravityが触っていないレイヤー」に限定します
   - ✅ テスト追加（`__tests__/` 新規ファイル）
   - ✅ ドキュメント更新（`blueprint.md`, `.agents/skills/`）
   - ✅ CI/CD設定（`.github/workflows/`）
   - ❌ コア実装（`lib/`, `app/api/`, `components/`）

2. **ファイル指定**: Issue本文にJulesが触ってよいファイルを明示します
3. **新規ファイル優先**: 既存ファイルの修正より新規ファイル作成のタスクを優先します
4. **一口サイズ**: 1 Issue = 1 PR。大きなタスクは分割してコンフリクトの影響範囲を最小化します
5. **コンフリクトのエスカレーション**: AIがコンフリクト解消を3回以上試みて失敗した場合、自力解決を中止し、内容を整理して人間にエスカレーションします

---

## コミット前チェック（必須）

コード変更後は、以下の3つがすべてパスすることを確認してからコミットしてください。

| コマンド | 基準 |
|---|---|
| `npm run lint` | 0 errors / 0 warnings（絶対ルール） |
| `npm run typecheck` | 型エラーなし |
| `npm run test` | 全テストパス |

---

## 環境セットアップ

```bash
cp .env.example .env.local
npm install
npm run dev
```
