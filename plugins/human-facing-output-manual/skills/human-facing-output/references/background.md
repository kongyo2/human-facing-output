# 背景：この Skill の方針の根拠

この Skill の方針は、末尾に挙げた研究に基づく。数値はそれぞれの研究の条件での値で、どのモデルで測ったかを併記した。研究が直接測っていない部分は、そう書いてある。

## 書き癖はどこから来るか

**書いても損をしない。** コーディングエージェントの余計な確認行動は、どちらを選んでも成否が同じになる分岐で始まり、成果報酬の勾配はそこでゼロになる。必要な確認量が指示に書かれていないとき、Claude Opus 5.5 は 78.5% の実行で必要以上の確認をした。確認量を指示に書くと 5.7% に下がった。[1] これは行動についての結果で、文章にも同じ仕組みが働くというのは、この Skill の推論である。

**書くほど点が上がる。** 報酬モデルで品質だけを最適化する強化学習は、出力を長くした。長さを 3 割ほど抑えても、品質の向上はほぼ保たれた（小型のオープンモデル）。[8] 公開されている報酬モデルの一つは、括弧書きの補足説明、「何があれば見解が変わるか」の一文、結びの定型句に加点した。より強い LLM ジャッジは、補足説明のない版のほうを好んだ。[9] 報酬が直接触れていない特徴も、報酬のつく出力と一緒に現れていれば強まる。[10]

**AI の評価者は好み、人間は好まない。** 論文の段落を「査読者の懸念に対応して」書き直させると、根拠のない留保が増えた。AI 査読者はその書き直しを高く採点し、明晰さも高く評価したが、人間の読者（4 名）は読みにくく、著者の確信が弱いと評価した。効果が大きかったのは GPT 系のモデルである。Claude Opus 5.5 は、既定の依頼では留保をほとんど足さなかった。ただし、レビューと修正の往復を 3 回重ねると、段落は 128 語から 314 語に伸びた。[2] 中国語の「不是X，而是Y（X ではなく Y）」構文では、文脈上不要な用例でも、報酬モデル 5 種のうち 3 種が比較の 68〜77% でこの語順を高く評価した。LLM ジャッジ 2 種も構文を残すほうを好み、その好みは用例が必要かどうかで変わらなかった。[3]

**個別の癖の集まりではない。** 後学習を経たモデルと基盤モデルの文体の差（磨かれた言い回し、留保、規則的な構成）は、その多くが内部表現の一つの方向で説明できた（小型のオープンモデル）。[11] AI をよく使う読み手は、語彙を避けさせた文章でも、構成や過剰な説明といった別の手がかりで AI の文章を見分けた。[17]

## 何が効き、何が効かないか

**禁止は形を変えて戻る。** 報告書の執筆で「defensive writing を避けよ」と指示すると、予防線は 59 件から 7 件に減ったが、根拠のない事実の追加が 2 件から 51 件に増えた。「原稿にない疑問や主張は考慮しなくてよい」と書く範囲を指定すると、予防線は 1 件になった（GPT-6.1 Sol、25 件の報告書）。[4] この Skill が「読み手の問い」で書く範囲を先に決めるのは、このためである。

**量は、明示すると守られる。** 上の確認量の結果（78.5% から 5.7%）がこれに当たる。[1] 問いを三つまでとするのは、量を先に決めるためである。

**書いたあとの点検では見つからない。** 自分の答えのどの文が冗長かをモデルに尋ねると、当たる率は偶然と変わらなかった（AUROC 0.495、小型のオープンモデル）。「簡潔に」という指示は、言い直しを消すのではなく、別の小さな答えを書かせることで出力を短くした。[12] 何を書くかを先に決め、書いてから削る進め方を採らないのは、このためである。

**実例は規則の列挙より強い。** 同じ用途の Skill を二つ読み込ませた実験で、出力の形は規則よりも実例に引かれた（オープンモデルと GPT-4.1）。[13]

**語を詰めると読みにくくなる。** フロンティアモデルの文章は、同じ意味の言い換えに比べて、人間の読解負荷と結びつくとされる構文を多く使う（読む時間は測っていない。Claude Opus 5.5 は Opus 5 より、21 の比較のうち 19 で低かった）。[5] モデルに書き直させたニュース記事は、語数が減っても、一語あたりの推定読み時間が増えた。[16] 減らすのは事柄で、語ではない。

## 読み手の側で起きること

**受け入れられにくい。** 不要な防御的作業を含むエージェントの実行に対し、開発者 20 名の満足度は 5 段階で 1.27 点低く、そのまま受け入れる率は 78% から 38% に下がった。こうした実行の 92.7% は合否判定に合格していた（Claude Opus 5 など 8 モデル。Opus 5.5 は含まれない）。[6]

**長さは信用にならない。** オープンソースのバグ報告 12 万件の調査では、AI が関わった報告は項目の充足度が高かったが、有効と認められる割合は変わらなかった。有効と認められた報告の中でも、技術的な主張の 32.65%、修正案の 33.76% はメンテナに退けられた。AI が関わった報告には、観察と推測を切り分けるための問い合わせが多く返った。[14] 実務者 239 名への調査では、AI が書いた変更について、説明文を十分な証拠とみなす人は 15.9% から 8.8% に減った。[15]

**目立つ。** Claude Code のコミットメッセージの中央値は 73 語で、同じリポジトリの人間は 10 語だった。ほかのエージェントは 14〜60 語である。[7]

## 圧縮の代償

人間の圧縮にも代償がある。落とした部分に「これは単純化したもの」という札は付かず、単純化がそのまま前提として固まることがある。この Skill は歯止めを三つ置いている。圧縮は落とすだけで、書き換えない。読み手の判断を変える限界は残す。落とした内容は手元（会話、エージェント向けの記録）に残し、聞かれたら出す。

## 出典

1. Luo et al. "Over-Defense in Coding Agents Begins at Silent Forks." arXiv:2610.24949
2. Liao et al. "Defensive Writing in GPT Models." arXiv:2610.11355
3. Peng et al. "Not X, but When: Diagnosing a Mandarin LLM Writing Tic through Contextual Appropriateness." arXiv:2610.22249
4. Chang. "A Harness Reducing over-Defensive Writing in Agents by Isolating Objections." arXiv:2610.36717
5. Clark, Martin, and Mahowald. "Why is AI-generated language so hard to understand?" arXiv:2610.29162
6. Luo et al. "ParanoiaEval: Benchmarking Unnecessary Defensive Work in Agentic Coding." arXiv:2610.08662
7. Horikawa et al. "Agent or Human? Detecting Commits by AI Coding Agents in the Absence of Authorship Signatures." arXiv:2610.36229
8. Weng et al. "Quality Determines Direction, Length Shapes Magnitude: Length Control for Open-Ended RL." arXiv:2609.34718
9. Wang, Arcuschin, and Conmy. "Automatically Finding Reward Model Biases." arXiv:2602.15222
10. Soubki, Tan, and Cranmer. "Trait Hitchhiking in LLM Post-Training." arXiv:2611.14683
11. Anand et al. "Measuring, Localizing, and Reducing the AI-Like Writing Style of Post-Trained LLMs." arXiv:2605.30526
12. Alyosify et al. "Beyond Truncation: When Can LLMs Safely Omit Generated Text?" arXiv:2611.08975
13. Razmara, Azizi, and Aryashad. "One Skill Takes Over: Clashing Agent Skills and a One-File Fix." arXiv:2610.25064
14. Liu et al. "Copilot or Culprit? How AI Is Changing Open-Source Bug Reporting and Maintenance." arXiv:2611.25605
15. Rahman et al. "Plausible Is Not Enough: Trust and Evidence in AI-Authored Pull Request Review." arXiv:2610.21144
16. Cekini et al. "The Cognitive Cost of LLM Writing: A Reading-Time Comparison with Human Text." arXiv:2610.23715
17. Russell, Karpinska, and Iyyer. "People who frequently use ChatGPT for writing tasks are accurate and robust detectors of AI-generated text." arXiv:2501.15654
