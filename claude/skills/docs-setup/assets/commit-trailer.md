### git commit メッセージ

理由はドキュメント側（ADR とタスク）に書かれているので、commit 本文は簡潔でかまいません。
そのかわり **trailer で ID を結び**、`git log --grep` でコードの変更から記録へ辿れるようにします。

#### 書式

```
{{COMMIT_HEADER}}

（必要なら本文。判断の骨子や、ADR に書くほどでない補足）

{{TASK_TRAILER_EXAMPLE}}
{{DECISION_TRAILER_EXAMPLE}}
```

- 最後の `Task:` / `Decision:` は **git trailer**。1行1件、複数可
- **決定を伴う変更では `Decision:` を必ず付ける。** これが無いと決定と実装が結び付かない
- **squash merge するときは、trailer を squash 後のメッセージにも残すこと**
- `更新` `fix` `wip` のような要約だけの commit を作らない

#### 参照のしかた

```bash
{{GREP_DECISION_EXAMPLE}}          # ある決定に紐づく実装をすべて
{{GREP_TASK_EXAMPLE}}              # あるタスクで何が変わったか
```
