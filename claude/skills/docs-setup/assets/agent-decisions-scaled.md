### decisions/
- セッション開始時に `INDEX.md` を読み、既存の決定に反する実装をしない。
  反する必要があるなら、まず報告して指示を仰ぐ
- アーキテクチャ・依存・データモデル・公開API・認証に関わる選択をしたら、
  コードを書く前に ADR を `status: Proposed` で作り、INDEX に1行追加する
- **Accepted の ADR の本文は書き換えない。** 覆すときは新しい ADR を書き、
  旧 ADR は Status を `Superseded by ADR-NNNN` にするだけ
- 連番は欠番禁止・リネーム禁止・削除禁止
