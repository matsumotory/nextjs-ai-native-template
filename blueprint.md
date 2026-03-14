# プロジェクト設計図 (Blueprint)

## 1. プロジェクト概要

<!-- プロジェクトの概要を記述してください -->

## 2. デザイン・機能仕様

<!-- 主要な機能とデザイン仕様を記述してください -->

## 3. 技術スタック

- **Frontend:** Next.js (App Router), TypeScript, Tailwind CSS
- **Infrastructure:** <!-- Firebase App Hosting / Cloud Run / Vercel 等 -->

## 4. 開発チームとワークフロー (AI Team Roles)

本プロジェクトは、複数の AI エージェントが役割を分担して推進します。

- **Lead Architect (統括)**: 全体の設計、タスクの進捗管理と他エージェントへの指示を担当。
- **UI/UX Specialist (装飾)**: UIの美学、アニメーションの磨き上げを担当。
- **Backend Engineer (論理)**: ビジネスロジック、API 実装を担当。
- **Documenter (記録)**: `blueprint.md` 等の開発ドキュメントの最新化を担当。
- **QA/DevOps (検証)**: テスト実行、CI/CD管理を担当。

## 5. アーキテクチャと主要データモデル

### 主要データモデル

<!-- types/index.ts 等のデータモデルを記述してください -->

### ディレクトリ構造と役割

- **`/app/`**: App Router によるファイルベースルーティング
- **`/lib/`**: ビジネスロジックとユーティリティ
- **`/components/`**: 再利用可能なUIコンポーネント

## 6. 実装計画

### Step 1: 環境構築 [ ]

- [ ] 初期セットアップ
- [ ] 基本設定

## スキル一覧

`core_`（汎用）/ `project_`（プロジェクト固有）のプレフィクスで管理。

| スキル名 | 説明 | 参照先 |
|---|---|---|
| `core_agent_roles` | マルチエージェントロール定義 | `.agents/skills/core_agent_roles/SKILL.md` |
| `core_ai_delegation` | AI間のタスク委譲プロトコル | `.agents/skills/core_ai_delegation/SKILL.md` |
| `core_bug_fix_protocol` | バグ修正プロトコル・トートロジー防止 | `.agents/skills/core_bug_fix_protocol/SKILL.md` |
| `core_coding_standards` | ESLint/TypeScript/React/Next.jsのコーディング規約 | `.agents/skills/core_coding_standards/SKILL.md` |
| `core_commit_standard` | コミットメッセージ標準 | `.agents/skills/core_commit_standard/SKILL.md` |
| `core_documentation_policy` | README/blueprint の更新義務 | `.agents/skills/core_documentation_policy/SKILL.md` |
| `core_testing_criteria` | テスト戦略とコミット前チェック | `.agents/skills/core_testing_criteria/SKILL.md` |
