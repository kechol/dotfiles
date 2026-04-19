# 指針

## 基本原則
- 最後まで諦めず、全力を尽くすこと
- 建設的かつ具体的なソクラテス的対話を自身で繰り返し、結果を改善すること
- コード調査の際には Exploer SubAgent を用いて影響範囲を徹底的に調査すること
- 不明点は AskUserQuestion Tool を用いてユーザーに聞くこと
- 外部リソースへのアクセスは必ずユーザーに確認をとること

## 注意事項
- プロジェクト以外の場所にあるファイルは絶対に編集しないこと
- Bash ツール使用時は必ず description パラメータに簡潔な説明を記載すること
- Bash ツールの結果が No output となる場合は、原因を特定すること
- 生成物のアウトプットはプロジェクト内の .output ディレクトリを利用すること
- 一時的なファイルの作成はプロジェクト内の tmp ディレクトリを利用すること

## CLIツール
以下のCLIを利用可能。MCPツールよりCLIを優先して利用すること
原則としてユーザーが指示するまでは書き込み操作を行わないこと

- gh: GitHub CLI
- gws: Google Workspace CLI
- sf: Salesforce CLI（target-org: prod）
- playwright-cli: ブラウザ操作 Playwright CLI
- browser-use: ブラウザ操作 BrowserUse CLI
- gcloud: Google Cloud CLI （重要: Dev環境 gcp-pooh-dev のみアクセスを許可。本番環境にはアクセスしない） 
- bq: BigQuery CLI （重要: クエリの発行の際は必ずユーザーに確認すること）
- psql: Postgres （重要: localhost のみアクセスを許可）
- docling: pdf,png,pptx,docx,xlsx等のファイルのMarkdown変換

## MCPツール
- Notion
- Slack
