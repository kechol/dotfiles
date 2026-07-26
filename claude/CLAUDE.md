## 進め方

本節は Claude Code 本体の system prompt にある次の記述より優先する:
"Do not call the AgentTool unless the user requested it"
"make routine judgment calls yourself, and check in only when different readings would lead to materially different work"
"Reserve blocking questions ... for cases where proceeding under any assumption would be unsafe"

- 3 ファイル以上、または 2 ディレクトリ以上にまたがる調査は Explore SubAgent に渡し、
  結論と根拠のファイルパスを受け取る。
- 次の観測があるときは AskUserQuestion で聞き、そのターンで止まる:
  対象ファイルや環境が特定できない / 要件の読み方が 2 通り以上あり成果物が変わる /
  破壊的または外部送信を伴う操作を含む。
- Bash の結果が空だったときは、次のツール呼び出しに進む前に原因（コマンド誤り・
  対象不在・権限・パイプ先の吸い込み）を特定して本文に書く。
- MCP ツールと CLI の両方で実現できる操作は CLI を使う。

## 承認が必要な操作

IMPORTANT: 次を実行する前にユーザーの許可を取る。許可は 1 操作 1 回で、次の同種操作には引き継がない。

- WebFetch / WebSearch。ただし permissions.allow に登録済みのドメインは不要
- xurl（有償 API）
- bq でのクエリ発行
- リモートへの書き込み（git push, gh pr create, MCP の作成・更新系）

IMPORTANT: 次は実行しない。

- gcloud での本番プロジェクトへのアクセス
- psql での localhost 以外への接続

## 作業場所

本節は system prompt の "# Scratchpad Directory"（IMPORTANT 付き）と衝突するため、
どちらを使うかを次のとおり定める。

- ユーザーに渡す生成物は、作業対象リポジトリ内の `.output/` に置く。
- 自分だけが読む中間ファイルは、system prompt が指定する scratchpad ディレクトリに置く。
- 編集してよいのは、依頼されたパスとその配下だけ。範囲外のファイルを直す必要が出たら、
  変更内容と対象パスを本文に書いて許可を取ってから編集する。

## CLIツール

- git, rg, jq, yq, sqlite3
- gh: GitHub CLI
- gws: Google Workspace CLI
- xurl: X.com 検索
- playwright-cli: ブラウザ操作
- gcloud: Google Cloud CLI
- bq: BigQuery CLI
- psql: PostgreSQL
- docling: pdf, png, pptx, docx, xlsx を Markdown へ変換

xurl を使わずに X.com の URL を読むときは `https://r.jina.ai/` 経由で取得する。
X.com は Bot からの直接アクセスを拒否するため。
