# 🤖 Next.js AI-Native Development Template

**AIエージェントと人間が協働する「デュアルAI開発」のための[Next.js](https://nextjs.org/)テンプレートです。**

[![CI](https://github.com/matsumotory/nextjs-ai-native-template/actions/workflows/ci.yml/badge.svg)](https://github.com/matsumotory/nextjs-ai-native-template/actions/workflows/ci.yml)

---

## このテンプレートについて

一般的なNext.jsテンプレートが「コードの雛形」を提供するのに対し、このテンプレートは **「AI開発チームの文化と規約」** を丸ごとお届けします。

|  | 一般的なテンプレート | このテンプレート |
|---|---|---|
| 🧱 **提供するもの** | コードの雛形 | コード + AI憲法 + 開発プロセス |
| 🤝 **開発の主体** | 人間が開発 | AIチームと一緒に開発 |
| 📏 **品質管理** | 開発者に委ねられる | AIが規約に従い自律的に維持 |
| 🔄 **プロセスの進化** | 手動で改善 | AIが経験から学びルールを自己更新 |

実プロダクトで実戦投入・継続改善されてきた開発プロセスを、そのままご自身のプロジェクトに展開していただけます。

---

## ⚔️ デュアルAI開発とは

ローカルでは**ロールベースのAIチーム**があなたと一緒に開発し、バックグラウンドでは**大量のAIエンジニアたち**が非同期で品質を磨き続ける ── そんな開発スタイルです。

### フォアグラウンド: [Antigravity](https://antigravity.google) によるロールベースAIチーム

ローカル環境で動く**5つの専門ロールを持つ仮想AIチーム**が、あなたと一緒にプロダクトを作ります。

| ロール | 担当領域 |
|---|---|
| 🧠 **The Architect** | 司令塔。タスクを分析・分割し、各専門ロールに作業を振り分けます |
| 🎨 **The Specialist** | UI/UX担当。デザインシステムに従い、リッチなインターフェースを構築します |
| ⚙️ **The Backend Engineer** | ロジック・データ担当。APIルート、ビジネスロジック、DB連携を堅牢に実装します |
| 📝 **The Documenter** | 仕様管理担当。blueprint や README の最新化、i18n辞書の同期を担います |
| 🛡️ **The QA Agent** | 品質の番人。ブラウザ検証、テスト実行、変更漏れの横断検索で品質を保証します |

AIチームは新機能の実装だけでなく、ユニットテストの作成やブラウザ検証も行います。開発中に見つけた改善点や品質課題は、GitHub Issueとして起票し `jules` ラベルを付与することで、バックグラウンドのJulesに委譲できます。

### バックグラウンド: [Jules](https://jules.google.com/) による非同期AI軍団

Julesは**2つのモード**でプロジェクトを支えてくれます。

**🔁 Proactive モード（スケジューリングされたフィードバックループ）**

Julesはスケジューリングにより定期的にコードベース全体をチェックし、改善すべき箇所を自律的に発見してPRを作成します。人間が指示しなくても、以下のような観点で継続的にコード品質を向上させてくれます。

| 観点 | Proactive モードでのチェック内容 |
|---|---|
| 🏎️ **パフォーマンス** | N+1問題の発見、不要な再レンダリングの検出・最適化提案 |
| 🔒 **セキュリティ** | 脆弱なパッケージの検知・アップデート（高度なDependabotとして機能） |
| 🧹 **リファクタリング** | 重複コードの共通化、設計パターンの改善提案 |
| 🧪 **テスト強化** | カバレッジの低い箇所の検出、エッジケースの追加提案 |
| 📝 **ドキュメント** | 仕様書とコードの乖離検出、コメントの整備 |

**📋 Issue 対応モード**

`jules` ラベルが付いたGitHub Issueに対しては、Julesが直接反応してPRを作成します。AIチームが開発中に見つけた改善点をIssueとして起票するだけで、Julesが非同期で対応してくれます。

### 実際の開発サイクル

デュアルAI開発の最大の強みは、**AIチームとAI軍団が Issue と PR を介して非同期に連携し合う**フィードバックループにあります。

| ステップ | タイミング | 誰が | 何をするか |
|:---:|---|---|---|
| **①** | 朝 | 🚀 Antigravity | Julesから届いたPRを `gh pr list` で確認。レビューしてマージ、コンフリクトがあれば解消 |
| **②** | 日中 | 🚀 AIチーム + あなた | 5つの専門ロールが分業して新機能を実装。品質課題はGitHub Issueとして起票 |
| **③** | 夕方 | 🚀 Antigravity | 残りの改善点をIssueにまとめ、`jules` ラベルを付与してJulesに委譲 |
| **④** | 夜間 | 🛡️ Jules 軍団 | 複数インスタンスが並列起動。Issueごとにリファクタリング・テスト追加・最適化のPRを自動作成 |
| **⑤** | 翌朝 | 🚀 Antigravity | 届いたPRをレビュー・マージし、最新のmainで再び開発へ → ①に戻る |

この **Issue → PR → レビュー → マージ** のサイクルが毎日回ることで、開発速度を落とさずにコード品質が継続的に向上していきます。

---

## 💬 日本語ネイティブ開発

LLMは意味論で動いています。コードは英語でも、**開発のコミュニケーションは母語で行うのが最も正確で効率的**です。

このテンプレートでは、**すべての開発プロセスを日本語で進める**ことを前提に設計しています。

- 💬 AIとの会話は日本語で
- 📝 設計書（`blueprint.md`）も日本語で
- 🔀 PR・Issue・コミットメッセージも日本語で
- 📖 ドキュメントも日本語で（技術用語は英語のままで大丈夫です）

**あなた**: 「ログイン機能を追加したい。Firebase Authを使いたいです」

**AI**: 「`blueprint.md` に認証フローの仕様を追記しました。レビューをお願いします」 → PR: 「feat: Firebase Auth によるログイン機能を実装」

LLMが翻訳も意味理解もこなせる時代に、わざわざ英語で設計書やPRを書く必要はありません。**思考の言語で開発し、コードだけが英語** ── この方が実感として生産性が高いと感じていただけるはずです。

---

## 🎯 テンプレートに含まれるもの

### AI開発の「憲法」

このテンプレートの核心部分です。AIがどのように振る舞うかの全ルールが定義されています。ぜひ中身をご覧になってみてください。

| ファイル | 役割 |
|---|---|
| [AGENTS.md](AGENTS.md) | AIエージェントが従う基本ルール。コード標準、デュアルAI体制、品質基準を定めています |
| [GEMINI.md](GEMINI.md) | AGENTS.md へのシンボリックリンク（Gemini用のエントリポイント） |
| [DEVELOPMENT.md](DEVELOPMENT.md) | SDD開発フロー、デュアルAIワークフロー、コンフリクト回避原則をまとめています |
| [blueprint.md](blueprint.md) | 設計の青写真テンプレート（AI向けの仕様書として活用できます） |

### 専門スキル（7件）

AIが状況に応じて**自律的に読み込む**「オンデマンドの専門知識」です。常時コンテキストに載せず、必要な時だけロードすることでトークンを効率的に使います。各スキルの詳細は [.agents/skills/](.agents/skills/) ディレクトリからご覧いただけます。

| スキル | どんな時に使われるか |
|---|---|
| [core_agent_roles](.agents/skills/core_agent_roles/SKILL.md) | AI同士の役割分担を整理したい時 |
| [core_ai_delegation](.agents/skills/core_ai_delegation/SKILL.md) | AIにタスクを委譲する時、セッションの開始・終了時 |
| [core_bug_fix_protocol](.agents/skills/core_bug_fix_protocol/SKILL.md) | バグ修正時（トートロジーの防止、リグレッションテストファーストの遵守） |
| [core_coding_standards](.agents/skills/core_coding_standards/SKILL.md) | コードを書く・修正する時（ESLint 0/0、テスト用ドメイン規約など） |
| [core_commit_standard](.agents/skills/core_commit_standard/SKILL.md) | git commit する直前 |
| [core_documentation_policy](.agents/skills/core_documentation_policy/SKILL.md) | README や blueprint を更新する時 |
| [core_testing_criteria](.agents/skills/core_testing_criteria/SKILL.md) | テストを書く・修正する時（仕様駆動テスト、vi.stubEnv 規約など） |

### 技術スタック

- [Next.js](https://nextjs.org/) App Router (TypeScript + [Tailwind CSS](https://tailwindcss.com/))
- [ESLint](https://eslint.org/) 0/0 ポリシー設定済み
- [vitest](https://vitest.dev/) テスト環境
- CI/CD ([GitHub Actions](https://github.com/features/actions): lint, typecheck, test)
- i18n 骨格（日英辞書構造）

---

## 🚀 使い方

### 1. テンプレートからリポジトリを作成

GitHub で「**Use this template**」→「Create a new repository」を選択してください。

### 2. セットアップ

```bash
git clone https://github.com/your-name/your-project.git
cd your-project
npm install
cp .env.example .env.local
npm run dev
```

### 3. blueprint.md に設計を書く

プロジェクトの設計を `blueprint.md` に記述してください。AIに「blueprint.md を読んで」と伝えるだけで、プロジェクトの全体像を把握して開発を始めてくれます。

### 4. 開発スタート

**あなた**: 「blueprint.md を読んで、Step 1 から始めよう」

**AI**: blueprint.md を読み込み、AGENTS.md のルールに従って開発を開始します 🚀

---

## 📜 コマンド一覧

| コマンド | 用途 |
|---|---|
| `npm run dev` | 開発サーバーの起動 |
| `npm run build` | プロダクションビルド |
| `npm run lint` | ESLint の実行（0 errors / 0 warnings が必須です） |
| `npm run typecheck` | TypeScript の型チェック |
| `npm run test` | vitest によるテスト実行 |
| `npm run export:ai-kit` | AI開発キットをZIPとしてエクスポート |

---

## 🧩 プロジェクト固有のカスタマイズ

テンプレート展開後、ご自身のプロジェクトに合わせて以下のカスタマイズを行ってください。

### project_ スキルの追加

`core_` スキルはどのプロジェクトにも使える汎用ルールです。プロジェクト固有のルールは `.agents/skills/project_*` として追加していくことをお勧めします。

| ディレクトリ | 種別 | 説明 |
|---|---|---|
| `core_*` | 汎用 | テンプレートに含まれています |
| `project_data_flow/` | プロジェクト固有 | 例: データフロー設計 |
| `project_auth/` | プロジェクト固有 | 例: 認証フロー |
| `project_styling/` | プロジェクト固有 | 例: デザインシステム |

### AGENTS.md への追記

プロジェクト固有のルール（デザインシステム、特定のAPI規約など）は `AGENTS.md` に追記してください。スキルのトリガーテーブルに `project_` スキルの行を追加すると、AIが適切なタイミングで自動的に読み込んでくれるようになります。

---

## 📖 このテンプレートの設計思想

### SDD（仕様駆動開発）
コードを書く前に `blueprint.md` に仕様を書きます。AIはコードではなく仕様を Source of Truth として参照します。

### ESLint 0/0 ポリシー
warning も含めてゼロを維持します。AIが warning を放置する癖がつくと、品質の低下に歯止めが効かなくなるためです。

### テストの Source of Truth は仕様書
AIが「コードがこう動いているからこう期待する」テストを書くことを防ぎます。テストの期待値は `blueprint.md` の仕様から導出します。

### 継続的な自己進化
問題を修正したら「なぜ起きたか」を分析し、スキルやルールとして言語化します。AIチーム自体が経験から学び続ける仕組みです。

---

## 📚 さらに詳しく

テンプレートの思想や仕組みにご興味をお持ちいただけましたら、以下のドキュメントもぜひご覧ください。

- [AGENTS.md](AGENTS.md) ── AIエージェントの「憲法」。すべてのルールと行動原則がまとまっています
- [DEVELOPMENT.md](DEVELOPMENT.md) ── デュアルAIの開発フロー、ブランチ戦略、コンフリクト回避原則の詳細
- [.agents/skills/](.agents/skills/) ── AIが自律的に読み込む専門スキル一覧。実際にどんなルールで動いているかをご確認いただけます
- [blueprint.md](blueprint.md) ── 設計の青写真テンプレート。プロジェクト開始時にここから仕様を書き始めます

---

## 🙏 謝辞

このテンプレートは、実プロダクトでのデュアルAI開発の実践を通じて生まれました。まだまだ改善の余地があると思いますので、ぜひお試しいただき、フィードバックをいただけると嬉しいです。
