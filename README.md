# human-facing-output

人間が読む文章を、読み手の問いに答える分だけに圧縮して書くための Agent Skill です。Claude Code のプラグインとして入れられます。

## 何をするか

RL で後学習されたモデルは、採点者に向けて書く癖を持っています。採点者は全部を読み、書き漏らしだけを減点するので、「迷ったら書く」が既定になります。人間の読み手は注意と時間に限りがあり、文章は残ってユーザーの名前で出ていくので、既定は逆になります。

この Skill は、書き癖を一つずつ挙げて削らせる代わりに、書く前の選び方を変えます。

- 読み手を一人決め、その人がこの件で聞くことを三つまで書き出す
- 本文はその答えだけにして、そこで終わる
- 読み手がすでに持っているもの、自分で導けるもの、書き手についてのもの（調べた経緯、念のための留保、作業側の事情）は問いに入れない
- 書かなかったことは別の場所へ移さず、聞かれたら答える

回答、作業後の報告、説明、メール、チャット投稿、ドキュメント、変更や不具合の説明など、人間が読む文章全般に使います。エージェント同士の引き継ぎメモや作業ログでは、除外した選択肢や試したことを明示的に書くほうが役に立つので、そちらには使いません。

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
| `skills/human-facing-output/references/examples.md` | 場面の違う例 |
| `skills/human-facing-output/references/background.md` | 方針の根拠と出典 |

## English

An Agent Skill, written in Japanese, for any text a human will read. Models post-trained with RL write for a grader that reads everything and penalizes only omissions, so they include whenever in doubt. This skill reverses that default: before writing, the agent picks one reader, lists at most three questions that reader would ask, answers only those, and stops. What the reader already has, can derive, or that is about the writer (process, hedges, backstory) stays out and is not moved elsewhere. Install it with the commands above.

## ライセンス

MIT
