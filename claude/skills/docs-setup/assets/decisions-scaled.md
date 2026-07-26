### `{{DOCS_DIR}}/decisions/` — 決めたこと（ADR・1決定1ファイル）

- ファイル名: `<4桁連番>-<英小文字kebab-case要約>.md`（例: `0007-use-postgres-over-mongodb.md`）
- 連番は欠番禁止・リネーム禁止・削除禁止
- **`Accepted` になった ADR の Context / Decision / Consequences は書き換えない**
- 決定が変わったら → **新しい ADR を書き、旧 ADR は Status のみ `Superseded by ADR-NNNN` に更新** して相互リンクする
- 価値があるのは個々の記録ではなく **決定の連鎖**。だから履歴を壊さない
- **エージェントはまず `INDEX.md` だけを読む。** 個別 ADR は関係するものだけ開く

#### ADR を書くべきトリガー

- 言語・フレームワーク・DB・外部サービスの選定
- 公開 API の形、データモデル、スキーマ
- 認証・認可の方式
- エラー処理、リトライ、タイムアウトの方針
- ディレクトリ構成やレイヤリングの原則
- パフォーマンス／コストのトレードオフ
- **あえて採用しなかった案**（これを書かないと同じ議論が繰り返される）

#### ADR を書かなくてよいもの

変数名・関数名 / 影響がファイル内に閉じる、いつでも戻せるリファクタリング / パッチバージョン更新

#### テンプレート

```markdown
---
id: ADR-0007
title: 主データストアに PostgreSQL を採用する
status: Accepted    # Proposed | Accepted | Superseded by ADR-NNNN | Deprecated
date: 2026-07-25
deciders: [@alice, @bob]
supersedes: []
superseded_by: []
---

## Context（状況）
（何を決めなければならなかったか。制約・前提・その時点で効いていた力を書く。過去形で）

## Decision（決定）
（1〜3文で断定的に。「〜を採用する」）

## Alternatives considered（検討した代替案）
| 案 | 却下理由 |
|---|---|
| MongoDB | 結合クエリが主要ユースケースで、スキーマレスの利点が小さい |
| DynamoDB | ローカル開発体験とコスト予測性が要件に合わない |

## Consequences（結果）
- 良くなること: トランザクションと結合が素直に書ける
- 悪くなること／引き受けた負債: 水平スケール時に手当てが必要
- 今後この決定に縛られること: マイグレーションは `migrations/` で管理する

## References
- 関連タスク: task-012
- 関連 ADR: ADR-0003
```

#### `INDEX.md`

1エントリ1行を厳守します。ADR を追加・Status 変更したら、**同じコミットで INDEX を更新**します。

```markdown
# Decisions INDEX

| ID | タイトル | Status | 日付 | 概要 |
|---|---|---|---|---|
| ADR-0007 | 主データストアに PostgreSQL を採用 | Accepted | 2026-07-25 | 結合とトランザクション重視 |
| ADR-0003 | セッションを JWT で持つ | Superseded by ADR-0011 | 2026-05-02 | — |
```
