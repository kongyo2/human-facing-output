# human-facing-output

人間が読む文章から、RL の学習環境で身についた書き癖を削る Agent Skill です。Claude Code のプラグインとして入れられます。

## 何をするか

回答、作業後の報告、コミットメッセージ、PR の説明、コードコメント、ドキュメント、記事などを書くときに、次の書き癖を読み手の都合に合わせて削ります。

- 誰も挙げていない選択肢を「A ではない。B でもない」と打ち消す
- 根拠のない留保や予防線を足す
- 作業やレビューの経緯を語る
- 「〜という指摘があった」「〜としている」のように伝聞の形で書く
- 出典リンクや時点注記を多めに付ける

削った内容をコミット本文、PR、メモファイル、脚注などの別の場所へ移して残すことも防ぎます。未完了の作業、破壊的変更、証拠に基づく限界のように、読み手に必要な情報は残します。

これらの書き癖が負担になるのは、読み手が人間のときです。エージェント同士の引き継ぎメモや作業ログでは同じ書き方が役に立つので、この Skill は人間が読む文章にだけ使います。

## インストール

Claude Code のセッションで次を実行します。

```
/plugin marketplace add kongyo2/human-facing-output
/plugin install human-facing-output@human-facing-output
```

シェルからは次のとおりです。

```
claude plugin marketplace add kongyo2/human-facing-output
claude plugin install human-facing-output@human-facing-output
```

該当する文章を書くときに自動で読み込まれます。明示的に使うときは `/human-facing-output:human-facing-output` を実行します。

Agent Skills に対応したほかのツールでは、`skills/human-facing-output/` をそのツールの skills ディレクトリに置いてください。

## 構成

| パス | 内容 |
|---|---|
| `skills/human-facing-output/SKILL.md` | Skill の本体 |
| `skills/human-facing-output/references/contexts.md` | 場面別の指針 |
| `skills/human-facing-output/references/examples.md` | 書き換え例 |
| `skills/human-facing-output/references/background.md` | 方針の根拠と出典 |

## English

An Agent Skill, written in Japanese, that removes RL-sandbox writing habits from human-facing text: negating alternatives nobody raised, ungrounded caveats, process narration, reported-speech attributions, and excess links. It also keeps the removed content from being moved to another place. Install it with the commands above.

## ライセンス

MIT
