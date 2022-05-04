# README

tokaidoは[todo.txt format][1]の[topydo colums][2]ライクなキーボードで操作するビューワーです。

## 機能
- Vimライクなキー操作で[todo.txt][1]の内容ををブラウザ上でわかりやすく確認
  - 全体表示エリア, 期限間近表示エリア、期限切れ表示エリア、プロジェクトごとの表示エリアでそれぞれのtodoを優先度順に表示出来る
  - 各todoの移動は`hjkl`操作で可
- NeoVimと連携して各todoの詳細をNeoVim上でmarkdownで編集
- 選択中のtodoについて作業時間を自動で記録(SQLite3のデータベースに保存)

## デモ
![gif][3]

## 設定
### 環境変数
- NVIM_LISTEN_ADDRESS
  - NeoVimとの連携に使用します。指定しないときのデフォルトは`/tmp/nvim.sock`
- TODOTXT_DIR
  - `todo.txt`のファイル配置ディレクトリになります。指定しないときのデフォルトは`$HOME/todotxt/`
  - 対象ディレクトリが存在しないときはRailsサーバ起動時に自動的に作ります。
  - `todo.txt`が`TODOTXT_DIR`配下に存在しないときは空ファイルをサーバ起動時に自動的に作ります。
  - `TODOTXT_DIR/todo`が存在しないときはサーバ起動時に作ります。このディレクトリには前述のNeoVim連携時に各todoの詳細をメモするためのmarkdownファイルが配置されます。

## インストール & 起動
```
❯ git clone git@github.com:maedana/tokaido.git
❯ cd tokaido
❯ ./bin/setup
❯ ./bin/dev
```

## 操作方法
Vimライクなキーボード操作のみ可能です。
- j
  - 次のtodoにフォーカスが移動
- k
  - 前のtodoにフォーカスが移動
- h
  - 左のリストのtodoにフォーカスが移動
- l
  - 右のリストのtodoにフォーカスが移動
- o
  - todo内部にURLがある場合に対象URLを別ウィンドウで開く
- e
  - NVIM_LISTEN_ADDRESSを指定したNeoVimプロセスが存在すれば、todoの詳細メモ用のmarkdownファイルをNeoVim上に自動で開く
  
## その他
### 連携用のNeoVimの起動例
```
❯ NVIM_LISTEN_ADDRESS=/tmp/nvim.sock nvim
```

[1]: https://github.com/todotxt/todo.txt
[2]: https://github.com/topydo/topydo
[3]: https://raw.githubusercontent.com/maedana/tokaido/master/docs/demo.gif
