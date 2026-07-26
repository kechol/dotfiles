# リポジトリ調査（フェーズ1の詳細）

セットアップの質は、既存の慣習をどれだけ拾えたかで決まる。新しい流儀を持ち込むほど守られなくなるので、
**リポジトリが既に持っているもの（ディレクトリ名・commit の書き方・指示ファイル・言語規約）に合わせる**のが原則。
判定できたものはユーザーに聞かず、判定が割れたものだけ聞く。

調査は Explore SubAgent に投げてよい。以下は「何を確定させたいか」と、その判断材料の取り方。

## 1. git リポジトリか

```bash
git rev-parse --show-toplevel 2>/dev/null
git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|origin/||'   # {{DEFAULT_BRANCH}}
```

git でないなら、この運用は commit メッセージに理由を預ける設計なので成立しない。
`git init` を提案し、ユーザーが断るなら台帳だけ作って commit 規約の節は入れない旨を伝える。

以降のパスはすべてリポジトリルート基準。カレントがサブディレクトリでも、ルートに対して作業する。

## 2. ドキュメントディレクトリ — `{{DOCS_DIR}}`

```bash
ls -d docs doc documentation Documentation .docs .claude/docs 2>/dev/null
```

**`docs/` があっても、それがドキュメント置き場とは限らない。** 静的サイトジェネレータのプロジェクトが
入っていることが多く、そこへ台帳を置くとビルド対象に紛れ込む。採用する前に必ず確認する。

```bash
ls docs/astro.config.* docs/docusaurus.config.* docs/mkdocs.yml docs/package.json \
   docs/.vitepress docs/book.toml docs/conf.py 2>/dev/null
```

| 判定 | 採用する `{{DOCS_DIR}}` |
|---|---|
| `docs/` が普通の Markdown 置き場 | `docs` |
| **`docs/` が SSG プロジェクト**（上のいずれかが存在） | `docs` は使わない。`.claude/docs/` など**内部ドキュメントの実際の置き場**を探して採用する。無ければ候補を挙げてユーザーに確認する |
| `doc` / `documentation` / `.claude/docs` などが実質の置き場 | それを採用 |
| どれも無い | `docs` |

`.claude/docs/` のようにエージェント向けの内部ドキュメントが既に整備されているリポジトリでは、
公開用の `docs/` と内部用を混ぜない。**台帳は内部側に置く。**

## 3. 運用ルールの配置先 — `{{POLICY_PATH}}`

既定は `{{DOCS_DIR}}/README.md` への追記。ただし **既存ファイルが何をしているか**で向き不向きが変わる。

```bash
head -60 <候補>/README.md 2>/dev/null
wc -l <候補>/README.md 2>/dev/null
ls .claude/rules 2>/dev/null
```

| 既存の状態 | 推奨 |
|---|---|
| **`.claude/rules/` がある** | `.claude/rules/<name>.md` を第1候補にする。規範的ルールの正規の置き場であり、`paths:` でスコープすれば必要なときだけコンテキストに載る |
| `{{DOCS_DIR}}/README.md` が無い | `{{DOCS_DIR}}/README.md` を新規作成 |
| 短い説明文だけ（〜50行） | 同ファイルに追記 |
| **docs 配下の索引として機能している**（他ファイルへのリンクが並ぶ）／既に長大（150行〜） | 別ファイルに分け、索引から1行リンクする。ファイル名はユーザーに確認（`DOCUMENTATION.md` / `HOW_TO_DOC.md` / `CONVENTIONS.md` など） |

索引を持つリポジトリでは、**索引に1行足すのが既存の作法**であることが多い。その作法に乗る。

`{{POLICY_PATH}}` はリポジトリルートからのパス（例: `.claude/rules/docs.md`）。
構成図の中では実際の相対パスで書く。

## 4. 言語規約 — 生成物を何語で書くか

**既定は日本語。ただしリポジトリに言語規約が明文化されていれば、それに従う。**
規約に反する言語で書かれたルールは、それ自体が規約違反として扱われ、守られない。

```bash
rg -i -n 'english|日本語|language convention|言語規約' CLAUDE.md AGENTS.md CONTRIBUTING.md .claude/rules/*.md 2>/dev/null | head
```

- 「comments, docs, commit messages are **English**」のような明文がある → **英語で生成する**
  （素材は日本語なので、意味を保って英訳する。訳語は既存ドキュメントの用語に合わせる）
- 明文が無い → 日本語で生成する。README や commit が英語でも、明文が無いなら日本語のままでよい
- 公開 OSS で英語規約、内部メモは日本語、のような分岐がある場合は、**台帳が置かれる側の規約**に従う

## 5. commit ヘッダ規約 — `{{COMMIT_HEADER}}`

```bash
git log -50 --format='%s' | rg -c '^[a-z]+(\([a-z0-9_./-]+\))?!?: ' || true
git log -50 --format='%(trailers:only)' | rg -v '^$' | sort -u
```

- 半数以上が Conventional Commits 形式 → `<type>(<scope>): <1行要約>` をそのまま採用
- 従っていない、または commit が少なすぎて判断できない → 同じく Conventional Commits を採用し、
  報告時に「commit ヘッダ規約もこの機会に導入した」と明示する
- 独自の規約が明確に見える（例: `[JIRA-123] ...`）→ その形を使い、本文と trailer だけを足す

## 6. エージェント指示ファイル — `{{AGENT_FILE}}`

```bash
ls CLAUDE.md AGENTS.md GEMINI.md CONTRIBUTING.md 2>/dev/null
ls .claude/rules .cursor/rules .github/copilot-instructions.md 2>/dev/null
```

見つかったものを候補として AskUserQuestion で確認する（複数選択可）。優先順位の考え方:

- **`.claude/rules/` があればそれが第1候補。** 規範ルールの置き場として設計されており、
  CLAUDE.md を膨らませずに済む。既存ファイルに追記するのではなく、新規ファイルを1つ足す
- 無ければ `CLAUDE.md`。それも無ければ `CLAUDE.md` 新規作成、次点で `AGENTS.md`
- `AGENTS.md` と `CLAUDE.md` が両方ある場合、多くは AGENTS.md が本体で CLAUDE.md が参照している。
  その関係を読み取ってから提案する（両方に同じ内容を重複させない）

`CLAUDE.md` が既に長い（150行〜）場合は、追記でさらに膨らませるより別ファイル + 参照1行の方がよい。
**毎セッション全文がコンテキストに載るため、長いほど遵守率が下がる。**

## 7. 既に導入済みか

```bash
rg -l 'docs-setup:begin' -g '*.md' .
```

マーカーが見つかったら新規初期化ではなく **更新モード**。既存の台帳・ID を保存したまま、
マーカー間のブロックだけ差し替える。ID の振り直しは絶対にしない（commit trailer が全部無効になる）。

マーカーは無いが台帳や ADR ディレクトリが既にある場合は、既存の ID 体系と最大番号を読み取り、続きから採番する。

```bash
rg -o 'D-[0-9]+' <docs>/decisions.md 2>/dev/null | sort -u | tail -3
rg -o 'T-[0-9]+' <docs>/backlog.md 2>/dev/null | sort -u | tail -3
fd . <docs>/adr <docs>/decisions -e md 2>/dev/null | sort | tail -3
```

## 8. 課題管理の実態

backlog を作るべきかの判断材料。GitHub Issues や Jira で既にタスクを管理しているなら、
台帳を二重管理にすると必ず片方が腐る。

```bash
gh issue list --limit 5 2>/dev/null
ls .github/ISSUE_TEMPLATE 2>/dev/null
```

Issues が活発なら、backlog を「作らない」も含めてユーザーに確認する。
未完了タスクが数件しかないリポジトリでも同じく「作らない」が正解になりうる。
