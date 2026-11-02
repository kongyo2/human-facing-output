# 書き換え例

各例に「書き換え前」「書き換え後」と、判断の理由を添えてある。

## 1. 回答：否定の羅列

書き換え前：

> 原因はメモリ不足ではありません。ディスク容量の問題でもなく、ネットワークの遅延も該当しません。設定ファイルの記述ミスでもないことを確認しました。原因はログのローテーションが止まっていたことです。

書き換え後：

> 原因はログのローテーションの停止です。3 月の設定変更で `logrotate` のジョブが無効になっていました。ジョブを有効に戻せば解消します。

理由：除外した 4 つの候補は、誰も挙げていない調査メモ。ユーザーが「メモリ不足だと思う」と言っていたなら、「メモリ不足ではなく、ログのローテーションの停止が原因です」と一度だけ否定する。

## 2. 回答：必要な否定と不要な否定

- ユーザー：「メモリを倍にしたけど遅いままだった」→「原因はメモリではなく N+1 クエリです」
- ユーザー：「このページが遅い」→「原因は N+1 クエリです」

## 3. コミットメッセージ（他所のリポジトリ）

書き換え前：

```
Fix parseTimeout to handle empty values

The AI reviewer flagged that TIMEOUT can be an empty string in CI.
Per that feedback, I first tried throwing a clearer error, but that
broke two existing tests, so I changed it to fall back to the default.
I ran the full test suite (142 passed), lint, and the type checker.
This does not change behavior for non-empty values and is not a
breaking change.

Session: https://agent.example.com/s/abc123
```

書き換え後：

```
Use the default timeout when TIMEOUT is empty

Some CI templates export TIMEOUT="", which made parseTimeout throw at
startup.
```

理由：本文に残したのは、差分から読み取れない理由だけ。レビューの経緯、試行錯誤、実行記録、誰も疑っていない互換性への否定、セッション URL を削った。

## 4. コードコメント

書き換え前：

```ts
// Note: the reviewer pointed out that TIMEOUT may be empty in CI.
// Per that feedback, we now return the default instead of throwing.
if (raw === "") return DEFAULT_TIMEOUT_MS;
```

書き換え後：

```ts
// An empty TIMEOUT means "unset"; some CI templates export it as "".
if (raw === "") return DEFAULT_TIMEOUT_MS;
```

理由：コメントの主語を「レビューで何が言われたか」から「コードの前提」に戻した。

## 5. 逃がしの例

依頼：「コードコメントから経緯を消して」

書き換え前（逃がしている）：

- コメントからは消したが、コミット本文に「Background: the reviewer noted that…」を足した
- `docs/notes/timeout-fix.md` を新しく作り、経緯をそこへ移した

書き換え後：

- コメントにはコードの前提だけを残す（例 4）
- コミット本文には変更の理由だけを書く（例 3）
- メモファイルは作らない

## 6. PR 説明（他所のリポジトリ）

書き換え前：

```
## Context
While working on our internal deploy tooling, we noticed that ...
Our internal review and an AI reviewer pointed out that ...

## What this PR does NOT do
- It does not change the public API.
- It does not affect Windows.
- It is not related to #456.

## Verification
I ran npm test (passed), npm run lint (passed), npm run typecheck
(passed), and tested manually on two machines.

## Notes
This PR was developed over several iterations with an AI agent.
```

書き換え後：

```
Fixes #123.

`parseTimeout` now returns the default timeout when `TIMEOUT` is set
to an empty string, which some CI templates do. Previously startup
failed with "Invalid timeout".

Added a regression test in `test/config.test.ts`.
```

理由：社内の事情、レビューの経緯、誰も疑っていない影響範囲の否定、実行記録を削った。「Previously startup failed」はバグの症状で、変更の理由に当たる。

## 7. 肯定文に言い換えても役割が残る例

書き換え前：

> 新しいキャッシュで p95 レイテンシは 800 ms から 200 ms になった。ただし、これだけでサービスが SLO を満たしたことにはならない。

否定の禁止だけを指示された言い換え（予防線の役割が残っている）：

> したがって、SLO の達成状況は、キャッシュの効果だけでなくエラー率や容量とあわせて評価する必要がある。

書き換え後：

> 新しいキャッシュで p95 レイテンシは 800 ms から 200 ms になり、チェックアウト API の SLO（300 ms）を満たした。

理由：「SLO を満たしたことにはならない」は、誰も主張していない結論を持ち出して打ち消している。証拠が SLO の達成まで示しているならそう書き、示していないなら示している範囲（レイテンシの改善）だけを書く。

## 8. 記事：伝聞、時点注記、リンクの過多

書き換え前：

> 公式ブログは、このライブラリがエージェントから使う前提で設計されているとしている。公式ブログによれば、出力は JSON で受け取れるという。また、ドキュメントは、API キーが OS のキーチェーンに保存されるとしている（2026 年 10 月時点）。[ブログ] [ドキュメント] [リリースノート]

書き換え後：

> このライブラリは、エージェントから使う前提で作られている。出力は JSON で受け取れ、API キーは OS のキーチェーンに保存される（[公式ドキュメント]）。

理由：確かめられる事実は直接書き、出典は確認に使う一つに絞った。時点注記は、料金のように変わりやすい事実に付ける。

## 9. 作業後の最終報告

書き換え前：

> まず README を読み、次に `src/config.ts` を確認しました。最初は環境変数の読み込み順が原因だと考えましたが、そうではありませんでした。（中略）最終的に `parseTimeout` を修正しました。`npm test` を実行して 142 件成功し、lint と型チェックも成功しました。念のため…

書き換え後：

> `parseTimeout` を修正し、空の `TIMEOUT` を既定値（30 秒）として扱うようにしました。回帰テストを 1 件追加し、既存のテストはすべて通っています。

理由：調査の時系列を削り、変更と確認結果を残した。

## 10. 削除の依頼

依頼：「`legacy_export.py` を削除して」

書き換え前（逃がしている）：

- `legacy_export.py.bak` を残す
- 中身をコメントアウトして残す
- `deprecated/` に移す
- README に「旧エクスポート機能は非推奨です」と追記する

書き換え後：

- ファイルを削除し、参照が残っていないことを確かめる
- 報告は「`legacy_export.py` を削除しました」の一文
