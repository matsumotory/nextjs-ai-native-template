---
name: coding_standards
description: コーディング規約。ESLint/TypeScript/React/Next.jsの品質基準と、AIエージェントがコミット前に守るべきルールを定義する。
---

# コーディング規約

ESLint 0 errors / 0 warnings をプロジェクトの **絶対的なコードクオリティゲート** とする。

## 1. コミット前チェック（必須・順序厳守）

### 原則: アプリケーションコードの変更時はテスト実行が必須

**テストコードを変更せずにアプリケーションコードを変更した場合、既存テストの実行・通過を確認するまで `git commit` してはならない。**

```bash
npm run lint        # 0 errors / 0 warnings
npm run typecheck   # 型チェック
npm run test        # Unit testsの全パス確認
npm run test:e2e    # E2Eテストの全パス確認（特にUI文言変更時は必須）
npm run build       # 大規模変更時
```

### TDD・バグ再現テストの例外

以下のケースでは、テストが **意図的に落ちている状態** でのコミットは許容される：

- **TDD**: 先に失敗するテストを書いてコミット → 機能実装してテスト通過 → コミット
- **バグ再現テスト**: バグを再現する失敗テストを書いてコミット → バグ修正してテスト通過 → コミット

これらのケースでは「テストコード自体を新規追加・変更している」ため、意図的な失敗であることが明確である。

> [!CAUTION]
> **アンチパターン**: アプリケーションコード（コンポーネント、ユーティリティ、DB層など）を変更し、テストを実行せずにコミットすること。既存テストが壊れていることに気づかないまま不正なコミットが残る原因になる。

## 2. JSXテキストのエスケープ

英語JSXテキスト内の `"` と `'` は必ずHTMLエンティティを使用する。

```tsx
// ✅ 正しい
<p>This is a &quot;quoted&quot; text with an apostrophe&apos;s usage.</p>

// ❌ 禁止
<p>This is a "quoted" text with an apostrophe's usage.</p>
```

- 日本語テキストでは `「」` を使うため通常この問題は起きない
- **特に faq, guide, terms, privacy の英語版** はエスケープ漏れが起きやすいので注意

## 3. Import管理

- **使用しないimportは即削除する**。「あとで使うかも」で残さない
- 新しいimportを追加した際、使用していたimportが不要になっていないか確認する
- コミット前に `npm run lint` で検出可能

## 4. 未使用変数の命名規約

意図的に未使用のパラメータ・変数には `_` プレフィクスを付与する：

```typescript
// ✅ 正しい
export async function POST(_req: Request) { ... }
} catch (_e) { ... }
interface DBClient {
    getCreatorData(_creatorId: string, _locale?: string): Promise<CreatorData>;
}

// ❌ 禁止
export async function POST(req: Request) { ... }  // reqを使わないのに_なし
} catch (e) { }                                    // eを使わないのに_なし
```

## 5. `<img>` vs `next/image`

- 通常の画像には `next/image` の `<Image>` を使用する
- **動的APIルートのSVG**（`/api/widget/...`）や**外部プロバイダの動的URL** など `next/image` が不適切な場合は、`eslint-disable-next-line` + 理由コメントを付与：

```tsx
{/* eslint-disable-next-line @next/next/no-img-element -- 動的APIルート画像のため */}
<img src={`/api/user-avatar/${userId}`} alt={userId} />
```

## 6. React Hooks

- `useEffect` の依存配列に含まれる値が **コンポーネント内で定義された安定定数** の場合、`eslint-disable-next-line` で抑制可能：

```tsx
// eslint-disable-next-line react-hooks/exhaustive-deps -- APP_CONFIGは安定定数
}, [users]);
```

- `useState` の初期値が `localStorage` 等のブラウザAPIに依存する場合、**lazy initializer パターン** を使用する（`useEffect` + `setState` ではなく）

## 7. 型安全性と eslint-disable の取り扱い

> [!CAUTION]
> **`eslint-disable` / `@ts-ignore` の追加は、原則コード変更で対処する。どうしても必要な場合はユーザーに相談し承認を得てから追加する。**

- `any` 型は新規コードでは可能な限り具体的な型を定義する。既存の `any` は将来的に排除対象
- **エスケープハッチ**: 複雑な型エラー等で無限ループに陥った場合に限り、`// TODO: Jules: Lint解消` とコメントを残して実装を優先し、後処理をJulesに一任してよい。ただし `eslint-disable` で黙らせることは禁止
- セクション5（`<img>` vs `next/image`）とセクション6（React Hooks）で記載の例外パターンのみ、理由コメント付きで `eslint-disable-next-line` を許容する

## 8. ファイルサイズの目安

- **300行以上** のファイルはリファクタリング候補とし、分割を検討する
- 特にコンポーネントファイルは **1ファイル = 1責務** を原則とする

## 9. 修正影響の全域自己検証とハードコードの禁止（重要）

AIエージェントによる部分的な修正モレを防ぐため、以下のルールを徹底する：

1. **全体横断検索の義務**: 文言変更やUIコンポーネントの仕様変更を行う際は、指示された特定ファイルだけを直して完了とせず、必ず `grep_search` 等を用いてプロジェクト全域（別ページやウィジェット表示、APIルートなど）に同じ古い表現や依存箇所が残っていないかを自律的に調査し、一括で修正すること。
2. **ハードコードの禁止**: UIに表示されるテキスト（プレースホルダー的な単語や「HP」「CREATOR」などの仮テキスト含む）のハードコードは禁止。必ず `dictionaries` (i18n辞書) を利用して一元管理すること。
3. **データ同期の検証**: 状態更新を伴う処理（シミュレータ等のデータ変更）では、フロントエンドのReactステート更新だけでなく、永続化層（ファイル/DB）へ正しく反映され、別タブや別機能から読み込んだ際にも同期が取れるアーキテクチャになっているかをエンドツーエンドで確認すること。

## 10. テストコード内のURL/ドメイン規約

テストコード内で使用するURL・ドメイン名は **RFC 6761 予約済み TLD** を使用する。実在ドメインのテスト内使用は禁止。

```typescript
// ✅ 正しい（.test TLD）
vi.stubEnv('NEXT_PUBLIC_BASE_URL', 'https://myapp.test');
expect(isSafeRedirectUrl('https://untrusted.test')).toBe(false);
expect(isSafeRedirectUrl('https://evil.test/path')).toBe(false);

// ❌ 禁止（実在ドメイン）
vi.stubEnv('NEXT_PUBLIC_BASE_URL', 'https://cheernode.com');
expect(isSafeRedirectUrl('https://google.com')).toBe(false);
```

- **許容 TLD**: `.test`, `.example`, `.invalid`, `.localhost`
- **例外**: Stripe API のモック戻り値（`checkout.stripe.com` 等）は、`isSafeRedirectUrl` のホワイトリスト検証に必要なため許容
