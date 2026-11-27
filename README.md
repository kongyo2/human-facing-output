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

### 呼んだときだけ使う版

自動で読み込ませたくない場合は、代わりに `human-facing-output-manual` を入れます。Skill の中身は同じで、frontmatter に `disable-model-invocation: true` を足してあります。

```
/plugin install human-facing-output-manual@human-facing-output
```

`/human-facing-output-manual:human-facing-output` を実行したときだけ読み込まれます。

Agent Skills に対応したほかのツールでは、`skills/human-facing-output/` をそのツールの skills ディレクトリに置いてください。


## ライセンス

MIT
