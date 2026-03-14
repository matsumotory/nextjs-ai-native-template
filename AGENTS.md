# AI-Native 開発ガイドライン

このドキュメントは、AIエージェントが当プロジェクトを開発する際に遵守すべきすべてのルール・標準・制約を定義する、プロジェクトの「絶対的な憲法（常時読み込まれる基本ルール）」です。詳細な開発体制とフローについては、**[DEVELOPMENT.md](DEVELOPMENT.md)** を参照してください。

エージェントは、このファイルに記載された基本ルールを常に遵守しつつ、必要に応じて`.agents/skills/`ディレクトリから「専門知識（オンデマンドでロードする仕様書）」を自律的に検索・取得して開発を進めます。

---

## 1. 環境とコンテキスト

### 開発環境

- **フレームワーク**: Next.js App Router
- **ローカルサーバー**: dev server が動いていなければ `npm run dev`（または `npm run dev:mock`）を起動する
- **プレビュー確認**: `http://localhost:3000` でブラウザ検証
- **環境変数**: `.env.example` をコピーして `.env.local` を作成し、環境に応じた値を設定する

### プロジェクト構成

```
/app          — App Router によるファイルベースルーティング
/components   — 再利用可能なUIコンポーネント
/lib          — ユーティリティ関数とライブラリ
/dictionaries — i18n 辞書（ja/ , en/）
/__tests__    — vitest テストファイル
/.agents      — Skills（専門知識）と Workflows（手順書）
```

### 3環境の定義

| 環境 | 切り替え | 概要 |
|---|---|---|
| **Mock**（ローカル） | `NEXT_PUBLIC_USE_MOCKS=true` | 外部依存なし。インメモリDB + ローカルJSONで動作 |
| **Staging** | `NEXT_PUBLIC_USE_MOCKS=false` + Staging環境 | 本番同等の外部サービスをテスト接続 |
| **Production** | `NEXT_PUBLIC_USE_MOCKS=false` + Production環境 | 実際のユーザーとデータを扱う本番環境 |

**環境ルール:**
- 環境判定は `lib/utils.ts` の `isMockEnvironment()` ヘルパーを経由する（`process.env` を直接参照しない）
- APIルートは Mock/Production 両方で動作を保証する

---

## 2. コード標準

### App Router / Server Components

- デフォルトで React Server Components (`app/`) を使用する
- 状態管理やブラウザ専用APIが必要な末端のUIコンポーネントにのみ `"use client"` を付与
- Client Components は可能な限り小さく、コンポーネントツリーの葉に配置する

### データフェッチとミューテーション

- **読み取り**: Server Components 内で `async/await` を使用
- **書き込み**: `"use server"` を付与した Server Actions を使用

### ESLint 0/0 ポリシー（絶対ルール）

**コミット前に `npm run lint` を実行し、0 errors / 0 warnings であることを必ず確認する。** warning の放置は禁止。

- 意図的に未使用のパラメータ/変数は `_` プレフィクスを付与する
- `eslint-disable` の追加は原則コード変更で対処。必要な場合はユーザーに承認を得る
- 詳細は `.agents/skills/core_coding_standards/SKILL.md` を参照

### ファイルベースルーティング規約

| ファイル | 用途 |
|---|---|
| `layout.tsx` | セグメントとその子の共有UI |
| `page.tsx` | ルートのユニークなUI |
| `loading.tsx` | ローディングUI |
| `error.tsx` | エラーの分離 |

---

## 3. デュアルAI開発体制

### 究極の役割分担：「攻めのAntigravity」と「守りのJules」

プロジェクトは、ローカル環境で機動的に動く **[Antigravity](https://antigravity.google)** と、クラウド環境で非同期に保守を行う **[Jules](https://jules.google.com/)** を組み合わせた、デュアルAI体制で進行します。

#### ⚔️ フォアグラウンド（攻め）：Antigravity
- **責務**: ゼロイチの新機能実装、UI/UXの構築、複雑なビジネスロジックの組み立て
- **マインドセット**: 「スピード重視・動けば正義」。プレビュー画面を見ながら最速で価値を形にする。パフォーマンス懸念やリファクタリングの余地があっても立ち止まらず、`// TODO: Jules: [要件]` とコメントを残して実装を優先する（TODO駆動開発）

#### 🛡️ バックグラウンド（守り）：Jules
- **責務**: 本番環境に耐えうる高品質なコードへの裏側での自動研磨
- **マインドセット**: 「静的解析・品質担保」。Antigravityが残した `TODO` や `FIXME` コメントを拾い、N+1問題の解消、不要な再レンダリングの最適化、重複コードの共通化、テストの自動生成などをPull Requestとして非同期に提案する

この分業により、AI同士のコンフリクトを防ぎつつ、開発速度とコード品質の双方を最大化します。

### Architect 主導のチーム開発

- 必ず「Architect（統括）」を軸とした仮想チーム開発を行い、責務を分離してシステムの整合性を保つ
- 各ロールの定義は `.agents/skills/core_agent_roles/SKILL.md` を参照

### 計画と Blueprint・README 管理

- 大幅な変更や新機能追加の際は、コーディング前に必ず `PLANNING` モードに入る
- `blueprint.md` を「設計・実装の青写真 (AI向け)」として管理する
- `README.md` を「プロダクトの公式仕様書 (ユーザー向け)」として管理する
- **`blueprint.md` と `README.md` はあらゆる機能追加・変更時に必ず両方を更新する。片方だけの更新は禁止。**
- 新しいセッション開始時、または大幅な変更前には、必ず `blueprint.md` を読み込んで全体コンテキストを把握する

### ブランチ戦略（Feature Branch Flow）

- **コード変更は必ず feature ブランチで作業し、CI パス後に PR マージすること。`main` への直接 push は禁止。**
- ドキュメントのみの変更（`blueprint.md`, `AGENTS.md`, `.agents/skills/` 等）は `main` 直接 push を許容する

### スキルの活用

- 実装中に判断に迷った場合や特定の機能ドメインを触る場合、必ず `.agents/skills/` 配下の該当スキルを読み込んでから作業する

---

## 4. 言語・i18n ルール

### 日本語コミュニケーション（最重要）

**AIエージェントは、すべてのコミュニケーション・ドキュメントを日本語で記述しなければならない。**

- ユーザーとの会話、計画書、PR、Issue、コミットメッセージ
- Technical terms やコードスニペットは英語で構わない

### i18n 辞書同期

- UIテキストのハードコード禁止。`/dictionaries/ja/` および `en/` 配下のJSON辞書を利用する
- テキストの追加・変更時は、必ず日英両辞書を同時に更新する

---

## 5. QA・検証プロセス

### 自動エラー修復フロー

コード変更後は必ず以下を実行する：

1. `npm run lint -- --fix` でリンティング問題を修正
2. `npm run typecheck` で型エラーがないか確認
3. `npm run test` を実行し、既存テストをパスすることを確認
4. プレビュー環境の出力でコンパイル・ランタイムエラーを確認

### QA エージェントの視点（タスク完了前に必須）

各タスクの完了前には「The QA Agent」の視点で以下を徹底検証する：

- ブラウザでの見た目の確認
- コンソールのエラーチェック
- 名称変更・リファクタリング後は `grep_search` 等で全ディレクトリ横断検索し、残存語彙がないことを確認

### テスト戦略

- **ロジック変更** → `vitest` でユニットテスト必須
- **UI変更** → `browser_subagent` で目視検証・スクリーンショット
- 詳細は `.agents/skills/core_testing_criteria/SKILL.md` を参照

---

## 6. スキル一覧と発動条件（トリガーテーブル）

エージェントは「単一の万能エージェント」ではなく、「専門家のチーム」として機能します。以下の条件に合致した場合、自律的に該当するスキルをファイルシステムから読み込み、その専門領域のルールを適用してください。

| 発動条件（トリガー） | 読み込むべきスキル | 参照先 |
|---|---|---|
| AI同士の連携や役割分担に迷った時 | マルチエージェントロール定義 | `.agents/skills/core_agent_roles/SKILL.md` |
| AI間でタスクを委譲したり、PRをマージする時 | タスク委譲プロトコル | `.agents/skills/core_ai_delegation/SKILL.md` |
| React/Next.js/TypeScriptのコードを書く・修正する時 | コーディング規約 | `.agents/skills/core_coding_standards/SKILL.md` |
| `git commit` を実行する直前 | コミットメッセージ標準 | `.agents/skills/core_commit_standard/SKILL.md` |
| `README.md`, `blueprint.md` を変更する時 | ドキュメントポリシー | `.agents/skills/core_documentation_policy/SKILL.md` |
| 新機能追加後やテストコードを作成・修正する時 | テスト戦略 | `.agents/skills/core_testing_criteria/SKILL.md` |
| バグ修正時、テストの期待値を決める時 | バグ修正プロトコル | `.agents/skills/core_bug_fix_protocol/SKILL.md` |

---

## 7. 継続的改善とフィードバックループ

発生した問題を単に修正するだけでなく、**「なぜ起こったか」「どうすればAI自身が同じミスを繰り返さないか」を分析し、自律的に規約やドキュメントへフィードバック・昇華させること**を義務とします。

1. **問題解決後の振り返り**: 複雑な異常解決や大規模修正の完了後は、必ず得られた知見を抽出する
2. **ルールの言語化**: 新たなアンチパターンやベストプラクティスを発見した場合、`.agents/skills/` 内のドキュメントを更新するか新しいスキルを作成する
3. **知識の代謝**: ルールの「追加」だけでなく、定期的に個別ルールの抽象化・圧縮を行う。スキルファイルは1ファイル80行以内を目安
4. **人間の承認ゲート**: Blueprint/仕様確定時、`main`へのマージ時、`eslint-disable`追加時は必ず人間のApproveを求める
5. **継続的な自己進化**: Architect は各タスクフェーズの終わりに、現在の開発プロセスに非効率やルールの穴がないか自己評価し、プロセス改善案をユーザーに提示・反映するループを回す
