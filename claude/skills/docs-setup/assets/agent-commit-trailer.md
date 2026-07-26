### commit メッセージ
理由は ADR とタスクに書かれているので commit 本文は簡潔でよい。ただし **trailer で ID を必ず結ぶ**。
`更新` `fix` `wip` のような要約だけの commit を作らない。

    {{COMMIT_HEADER}}

    （必要なら本文。判断の骨子や、ADR に書くほどでない補足）

    {{TASK_TRAILER_EXAMPLE}}
    {{DECISION_TRAILER_EXAMPLE}}

- 決定を伴う変更では `Decision:` trailer を必ず付ける（決定と実装が結び付かなくなる）
- 関連するタスクがあれば `Task:` trailer を必ず付ける
- 過去の経緯を聞かれたら、推測せず該当 ADR と `{{GREP_DECISION_EXAMPLE}}` で確認してから答える
