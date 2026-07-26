### commit メッセージ
すべての commit で以下の形式を使う。`更新` `fix` `wip` のような要約だけの commit を作らない。

    {{COMMIT_HEADER}}

    なぜ: 背景を1〜3文
    どうやって: 採った方針
    却下した案: 検討して選ばなかったものと理由（あれば）
    影響: 引き受けた負債（あれば）

    {{TASK_TRAILER_EXAMPLE}}
    {{DECISION_TRAILER_EXAMPLE}}

- 決定を伴う変更では `Decision:` trailer を必ず付ける（後から `git log --grep` で追えなくなる）
- 関連するタスクがあれば `Task:` trailer を必ず付ける
- 過去の経緯を聞かれたら、推測せず `{{GREP_DECISION_EXAMPLE}}` で確認してから答える
