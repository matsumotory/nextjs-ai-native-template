---
description: コードの品質チェックとテスト実行を行う
---

# 品質チェック ワークフロー

リント、型チェック、テストを実行してコードの健全性を確認する。

// turbo-all

## 手順

1. リント実行と自動修正
```bash
npm run lint -- --fix
```

2. TypeScript型チェック
```bash
npx tsc --noEmit
```

3. ユニットテスト実行
```bash
npm run test
```

4. エラーがあれば修正を試み、修正後に再実行
5. 結果をユーザーに報告
