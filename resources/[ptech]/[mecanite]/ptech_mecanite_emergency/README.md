# P-Tech Mecanite Emergency

`pemsblazer`（EMS Blazer Aqua）と、水上で無人になった時の係留アシストを含む緊急車両リソースです。

## 導入

1. `ptech_mecanite_emergency` をサーバーの resources 配下へ配置します。
2. `server.cfg` に `ensure ptech_mecanite_emergency` を追加します。
3. 車両管理・ガレージ側で `pemsblazer` を必要な職種へ登録します。

## 挙動

- 武装抑止は **pemsblazer の運転席だけ**に適用します。標準 `blazer5` は一切変更しません。
- 係留アシストは、無人・水上・低速時だけ横方向の流速を減衰させます。
- 一定以上の速度または押し出しを検知すると、2.5秒間は係留を解除します。移動後に再び静止すれば、その場所で再度待機します。
- 位置凍結、衝突無効化、無敵化、元位置へのワープは使いません。そのため他艇の衝突・押し出しと戦闘への干渉を避けます。
- 物理を操作できるネットワーク所有者のクライアントだけが減衰を適用します。OneSyncでの実機確認が必要です。

## 注意

- 元の Police Off-Road Pack 系 `polblazer` を配信するリソースとは、レイアウト・警光灯・音声設定が重複するため同時起動しないでください。
- FiveM実機では、スポーン、警光灯・サイレン、水陸切替、武装抑止、無人時の水上待機、他艇での押し出し、再乗車を確認してください。

## クレジット

原作：Police Off-Road Pack [Add-On | Template] 2.0 — SAS994 & ShaoyeBen（RiME557）。

原作のクレジットと利用条件は [docs/CREDITS.md](docs/CREDITS.md) を参照してください。P-Techによる変更はEMS塗装、FiveM構成、武装抑止、係留アシストです。
