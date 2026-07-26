---
name: docs-setup
description: |
  リポジトリ内でドキュメントを運用するための初期化スキル。
  「やること（backlog）」「決めたこと（decisions）」の台帳と運用ルールを整備し、
  CLAUDE.md / AGENTS.md / .claude/rules/ にエージェント向けの短い指示を追記して、以降のセッションで守られる状態にする。
  リポジトリの規模・commit 規約・言語規約・既存のドキュメント構成を読み取り、
  backlog と decisions のそれぞれについて 1ファイル台帳（compact）か 1件1ファイル + INDEX（scaled）かを
  AskUserQuestion で提案して決める。
  「/docs-setup」で起動する。「ドキュメント運用を初期化して」「docs を初期化して」「backlog と decisions を作って」
  「ADR の仕組みを導入したい」「タスク管理をリポジトリ内で始めたい」「設計判断を残す仕組みを作って」
  「CLAUDE.md にドキュメントのルールを追加して」といった、**仕組みを新しく入れる**要求で必ず使う。
  初期化の一環として、既存の README・依存関係・git 履歴からの決定・タスクの抽出と、
  直下に散らばった NOTES.md / PLAN.md / TODO.md の棚卸し提案まで行う。
  既に運用が回っているリポジトリでの日常操作（ADR を1件書く、タスクを1件追加する、docs を整理する）や、
  個別ドキュメントの執筆・翻訳・Markdown 変換には使わない。それらは運用ルール側の仕事。
---

# /docs-setup — リポジトリのドキュメント運用を初期化する

このスキルが作るのは**運用が回る仕組み**であって、ドキュメントそのものではない。
中心にある考えは1つ:

> **台帳は「何があるか」だけを持ち、「なぜそうしたか」は別の場所（commit メッセージ、または ADR 本文）に置く。
> 両者を ID で結ぶ。**

台帳に理由を書き始めると肥大し、肥大するとエージェントも人間も読まなくなり、読まれない台帳は嘘をつき始める。
ID で結んでおけば台帳は小さいまま保たれ、理由は `git log --grep` でいつでも復元できる。
生成物のすべての設計はここから導かれている。

## やること / やらないこと

- **やること**: 既存の慣習の調査 → 規模と配置先の提案・確定 → 運用ルールの設置 → 台帳の作成 →
  エージェント指示の追記 → 既存 `.md` の棚卸し提案 → 既存の決定・タスクの抽出 → commit メッセージ案の提示
- **やらないこと**: git commit / push の実行（案を出すところまで）、既存ファイルの削除・移動の実行（提案まで）、
  CI や hook の設置（ルール文中で推奨するだけ）

## フェーズ0 — 既に運用が回っていないかを確認する

**ここで止まるべきリポジトリを、初期化して壊さないための関門。** 成熟した運用を持つリポジトリに
同等内容の劣化版を足すのが、このスキルの最も害の大きい失敗。3つのシグナルを順に見る。

```bash
rg -l 'docs-setup:begin' -g '*.md' .                                   # ① このスキルの設置跡
git log --format='%(trailers:key=Decision,valueonly)' | rg -cv '^$'    # ② trailer の実運用
git log --format='%(trailers:key=Task,valueonly)' | rg -cv '^$'
fd -i '^(backlog|decisions?|adr)' -e md -d 3 | rg -v node_modules      # ③ 台帳の存在
rg -l '台帳|ledger|Decision Record|ADR' README.md CLAUDE.md AGENTS.md docs/README.md .claude/**/*.md 2>/dev/null
```

| 検出 | モード |
|---|---|
| ① マーカーあり | **更新モード**。台帳の中身と ID は一切触らず、マーカー間のブロックだけ差し替える |
| ② `Task:` / `Decision:` trailer が実際に使われている、または ③ 中身のある台帳 + 運用ルール文書がある | **導入済み。初期化を中止する**（下記） |
| どれも無い / 台帳ファイルはあるが空 | 初期化を続行。既存の ID 体系と最大番号を読み取り、続きから採番する |

### 導入済みだったとき

**ファイルを1つも作らない。** 代わりに差分レポートを出す。既に回っている運用の方が、
このスキルの素材より実態に合っていることが多い——素材は初期化用の最小形であり、
実運用はそこから正当に進化している。上書きではなく、**差分の提示に徹する**。

レポートに含めるもの:

- 検出した運用の形（台帳の位置、ID 体系、理由の置き場、規模）
- **素材側にあって既存に無いもの**（例: 分割しきい値、機械的強制の推奨、禁止事項の項目）
- **既存にあって素材に無いもの**（逆方向の学び。ユーザーの資産なので、そのまま伝える）
- 明らかな綻び（ID の欠番、trailer の付け漏れ、台帳と実装の乖離）があれば指摘

そのうえで「取り込む価値がありそうな差分はどれか」をユーザーに問い、指示があった分だけ適用する。

**ID の振り直しは commit trailer を全部無効にするので絶対にしない。** 実運用のリポジトリでは
コード・ドキュメント・テストに数百〜千件規模の ID 参照が積み上がっている。

## フェーズ1 — リポジトリを調査する

`references/repo-survey.md` を読んで実施する。確定させたい変数は次のとおり。

| 変数 | 内容 | 決め方 |
|---|---|---|
| `{{DOCS_DIR}}` | ドキュメントディレクトリ | 既存に従う。**`docs/` が SSG プロジェクトなら使わない**（§2） |
| `{{POLICY_PATH}}` | 運用ルールの配置先 | `.claude/rules/` があればそこが第1候補。無ければ `{{DOCS_DIR}}/README.md`（§3） |
| 言語 | 生成物の言語 | 既定は日本語。**リポジトリに言語規約が明文化されていればそれに従う**（§4） |
| `{{COMMIT_HEADER}}` | commit 1行目の形式 | 既存の commit 規約に従う。無ければ Conventional Commits（§5） |
| `{{AGENT_FILE}}` | エージェント指示の追記先 | `.claude/rules/` > `CLAUDE.md` > `AGENTS.md` の順で候補にし、確認（§6） |
| `{{DEFAULT_BRANCH}}` | 既定ブランチ名 | `git symbolic-ref refs/remotes/origin/HEAD` |
| ID 体系 | タスク・決定の採番形式 | **既存があれば必ずそれに従う**。無ければ `T-NNN` / `D-NNN` |

新しい流儀を持ち込むほど守られなくなる。**判定できたものは聞かず、判定が割れたものだけ聞く。**

特に外しやすいのが `{{DOCS_DIR}}`。`docs/` が Astro / Docusaurus / VitePress / MkDocs のプロジェクトである
リポジトリは多く、そこへ台帳を置くと公開サイトのビルド対象に紛れ込む。内部ドキュメントが
`.claude/docs/` などに別途あるなら、**台帳は内部側に置く**。

## フェーズ2 — 規模を決める（2軸）

`references/scale-selection.md` を読んで判断材料を集める。**backlog と decisions は増え方が違うので、
それぞれ独立に決める。**

- **backlog**: なし / compact（1ファイル・1タスク1行） / scaled（1タスク1ファイル + INDEX）
- **decisions**: compact（1ファイル・1決定1行） / scaled（1決定1ファイル = ADR + INDEX）

**理由の置き場は decisions 軸で決まる。** compact なら commit メッセージ本文、scaled なら ADR 本文。
commit メッセージ節の素材もこれに従って選ぶ。

決め手になるのは行数や人数より **並行して触る人・エージェントがいるか**、そして
**リポジトリが既に持っている文書運用の形**。既存が「1トピック1ファイル + 索引表」なら、
decisions もそれに揃えるほうが守られる。迷ったら compact。

**既存の台帳が compact / scaled のどちらでもない形をしていたら、その形を踏襲する。**
実運用では「台帳は1行だが、詳細はエリア別ファイルに置く」「compact から scaled へ移行途中で
古い決定だけ本文を持つ」といった中間形態が普通に現れ、たいていは正当な理由がある。
2択に押し込めようとせず、既存の形のまま素材の節を書き換えて使う。

## フェーズ3 — AskUserQuestion で確定する

**1回の呼び出しにまとめる。** 2〜4問に絞り、候補は次から選ぶ:

1. **backlog の規模**（ほぼ必ず聞く）— なし / compact / scaled
2. **decisions の規模**（ほぼ必ず聞く）— compact / scaled
3. **エージェント指示と運用ルールの配置先**（ほぼ必ず聞く）— 検出したファイルを候補にする
4. **運用ルールを既存索引に足すか別ファイルか**（既存 README が索引として機能している場合のみ）

推奨を第1選択肢に置き、ラベル末尾に `（推奨）` を付ける。description には「規模が大きいので」ではなく
**具体的な数字**を書く（「`.claude/worktrees/` に2件、内部ドキュメントが18ファイル + 索引表で運用中」）。
根拠が具体的だとユーザーは反証しやすい。

聞かないもの: ディレクトリ名（既存に従えば決まる）、ID 体系（固定）、commit 規約（既存から読み取る）、
言語（既定は日本語、明文規約があればそれに従う）。

## フェーズ4 — 生成する

素材は節単位のフラグメントになっている。枠に3つの節を差し込んで1つのルールを組み立てる。

| 差し込み先 | backlog=なし | backlog=compact | backlog=scaled |
|---|---|---|---|
| `{{SECTION_BACKLOG}}`（`assets/frame.md`） | 挿入しない | `assets/backlog-compact.md` | `assets/backlog-scaled.md` |
| `{{SECTION_BACKLOG}}`（`assets/agent-frame.md`） | 挿入しない | `assets/agent-backlog-compact.md` | `assets/agent-backlog-scaled.md` |

| 差し込み先 | decisions=compact | decisions=scaled |
|---|---|---|
| `{{SECTION_DECISIONS}}`（frame） | `assets/decisions-compact.md` | `assets/decisions-scaled.md` |
| `{{SECTION_COMMIT}}`（frame） | `assets/commit-rationale.md` | `assets/commit-trailer.md` |
| `{{SECTION_DECISIONS}}`（agent-frame） | `assets/agent-decisions-compact.md` | `assets/agent-decisions-scaled.md` |
| `{{SECTION_COMMIT}}`（agent-frame） | `assets/agent-commit-rationale.md` | `assets/agent-commit-trailer.md` |

残りのプレースホルダは選択に応じて埋める。

| プレースホルダ | decisions=compact のとき | decisions=scaled のとき |
|---|---|---|
| `{{RATIONALE_HOME}}` | `commit メッセージ` | `ADR 本文（{{DOCS_DIR}}/decisions/）` |
| `{{DECISION_TRAILER_EXAMPLE}}` | `Decision: D-003` | `Decision: ADR-0007` |
| `{{GREP_DECISION_EXAMPLE}}` | `git log --grep='Decision: D-003'` | `git log --grep='Decision: ADR-0007'` |

| プレースホルダ | 埋め方 |
|---|---|
| `{{LAYOUT_TREE}}` | 実際に作る構成をツリーで書く。作らない台帳は載せない |
| `{{LEDGER_LIST}}` | 例: `` `docs/backlog.md` と `docs/decisions.md` ``。backlog=なしなら decisions のみ |
| `{{TASK_TRAILER_EXAMPLE}}` | backlog=compact なら `Task: T-012`、scaled なら `Task: task-012`、なしなら行ごと省く |
| `{{GREP_TASK_EXAMPLE}}` | 上に対応する `git log --grep='Task: ...' --stat`。backlog=なしなら行ごと省く |

**既存の ID 体系があれば、素材中の ID 例をすべてそれに合わせて書き換える。**
実運用ではマイルストーンを含む形（`T7-13`）などが使われていることがあり、例だけ `T-012` のまま残すと
そちらを真似た採番が混ざる。書式説明・例・trailer・grep コマンドの全箇所を揃える。

### 言語

既定は日本語。**リポジトリに言語規約が明文化されている場合はそれに従う**（英語規約なら英語で生成する）。
素材は日本語なので、英語で出すときは意味を保って訳す。**訳語は既存ドキュメントの用語に合わせる**——
リポジトリ固有の語（invariant、ledger、decision record など）は既存の使われ方を優先する。

### 書き込みの作法（既存を壊さないため）

- **既存ファイルへは、必ず Read してから Edit で追記する。Write を使ってよいのは新規作成のときだけ。**
  Write は全置換なので、既存の README やエージェント指示を丸ごと失う事故が起きる
- `<!-- docs-setup:begin -->` / `<!-- docs-setup:end -->` のマーカーは必ず残す。
  更新モードではこの範囲だけを Edit で差し替え、マーカー外は読むだけで触らない
- 既存ファイルに追記する場合、見出しレベルを既存の構造に合わせる（素材は `##` 始まり）
- **書き込み後に `rg '\{\{' <生成物>` を実行し、置換漏れがないことを必ず確認する**
- 日付を含む例（`2026-07-25` など）は、今日の日付を基準に自然な過去日付へ書き換える。
  未来日付が例に残っていると、そのまま真似されて台帳が壊れる

### 台帳を作る

- **backlog=compact**: `{{DOCS_DIR}}/backlog.md`（`# Backlog` + Epic セクション）
- **backlog=scaled**: `{{DOCS_DIR}}/backlog/INDEX.md` と `{{DOCS_DIR}}/backlog/archive/.gitkeep`
- **decisions=compact**: `{{DOCS_DIR}}/decisions.md`（`# Decisions` + 参照方法の1行 + エントリ）
- **decisions=scaled**: `{{DOCS_DIR}}/decisions/INDEX.md`

個別ファイルはフェーズ5で抽出したものだけ作る。**空のテンプレートファイルは置かない**（使われずに腐る）。
既存の索引（`.claude/docs/README.md` など）があるリポジトリでは、その索引に1行足すのが作法であることが多い。

### エージェント指示

`{{AGENT_FILE}}` にマーカー付きでブロックを置く。`.claude/rules/` に置く場合は新規ファイルを1つ足し、
そのディレクトリの索引があれば1行追加する。

ここに詳細を書かないのが重要。**毎セッション全文がコンテキストに載るため、長いほど遵守率が下がる。**
詳細は `{{POLICY_PATH}}` 側に置き、指示からは「作業前に読め」と参照させる。
同じ理由で、台帳を `@import` してはいけない。

## フェーズ5 — 棚卸しと抽出

`references/inventory-and-extraction.md` を読んで実施する。要点:

- **抽出元は git 追跡下のファイルに限る。** `.gitignore` されたファイル（`TODO.md` など）は
  意図的に共有対象外にされていることが多く、そこから起こした台帳を commit すると方針違反になる。
  存在と概要だけ伝えて判断を仰ぎ、**中身は移植しない**
- 散らばった `.md` は**分類して提案する**。移動・削除は実行しない
- **台帳以外の系統には触らない。** 実装から書き起こしたリファレンス文書や、凍結された原本・記録は
  台帳とは役割が違う。棚卸しの対象は「行き場を失った文書」であって、既に役割を持つ文書ではない
- 決定・タスクは、明示的に読み取れるものだけ起こす。件数は絞らない。守る境界は
  「**根拠のないエントリを1件も作らない**」ことだけ

## フェーズ6 — 報告し、commit を提案する

作ったファイル一覧、確定した変数、抽出した件数、そして**ユーザーに判断を委ねた提案**
（削除候補、見送った抽出、取り込まなかった issue など）を簡潔に伝える。

そのうえで、**導入した規約どおりの commit メッセージ案を提示する**。
初期化そのものが「ドキュメント運用を導入する」という1つの決定なので、decisions の最初のエントリと
対にすると、この運用の見本がリポジトリに1件残る。

**commit の実行はしない。** ユーザーが案を確認して指示するのを待つ。

## 参照ファイル

- `references/repo-survey.md` — 調査コマンドと各変数の決め方（SSG 判定、言語規約、配置先の優先順位）
- `references/scale-selection.md` — backlog / decisions それぞれの規模判断と、compact → scaled の移行手順
- `references/inventory-and-extraction.md` — 追跡状態の確認、既存 `.md` の分類、抽出元と抽出の原則
- `assets/frame.md` — 運用ルールの枠（考え方・置き場所・禁止事項・分量・チェックリスト・機械的強制）
- `assets/{backlog,decisions}-{compact,scaled}.md` — 台帳ごとの節
- `assets/commit-{rationale,trailer}.md` — commit メッセージ節（decisions の規模で選ぶ）
- `assets/agent-*.md` — エージェント指示側の同じ構成（枠 + 各節）

## ユーザー起動

- `/docs-setup` — カレントのリポジトリを調査して初期化を開始
- `/docs-setup <パス>` — 指定リポジトリに対して実行
