### git commit メッセージ

**理由の一次情報はここに置きます。** 台帳の1行を読んだ人が「なぜ？」と思ったとき、
`git log --grep` でたどり着く先がこれです。

#### 書式

```
{{COMMIT_HEADER}}

なぜ: （この変更が必要になった背景。1〜3文）
どうやって: （採った方針。実装の詳細ではなく判断の骨子）
却下した案: （検討して選ばなかったもの と その理由。なければ省略）
影響: （引き受けた負債・今後この判断に縛られること。なければ省略）

{{TASK_TRAILER_EXAMPLE}}
{{DECISION_TRAILER_EXAMPLE}}
```

- 最後の `Task:` / `Decision:` / `Supersedes:` は **git trailer**。1行1件、複数可
- **決定を伴う変更では `Decision:` を必ず付ける。** これが無いと後から検索できない
- 決定だけ先に固めて実装が後になる場合は、台帳を更新する commit に `Decision:` を付ける（本文に理由を書く）
- **squash merge するときは、trailer と本文を squash 後のメッセージにも残すこと**

#### 例

```
feat(search): 全文検索エンドポイントを追加

なぜ: 一覧からの絞り込みが手作業になっており、件数増加で破綻していた。
どうやって: tsvector 列 + GIN インデックス。クエリは plainto_tsquery で組む。
却下した案: Elasticsearch — 運用コストが現在の規模に見合わない。
          LIKE 検索 — 1万件で 800ms かかり要件を満たさない。
影響: 検索対象カラムを増やすたび migration とインデックス再構築が必要。

{{TASK_TRAILER_EXAMPLE}}
{{DECISION_TRAILER_EXAMPLE}}
```

#### 参照のしかた

```bash
{{GREP_DECISION_EXAMPLE}}          # ある決定の経緯をすべて
{{GREP_TASK_EXAMPLE}}              # あるタスクで何が変わったか
```
