# README

tokaidoは[todo.txt format][1]のテキストファイルを[topydo colums][2]にインスパイアされたVimライクなキーボード操作でブラウザから閲覧するためのビューワ。

## 機能
- [todo.txt][1]の内容をかんばんのUIで表示
  - かんばん内はVimライクな`hjkl`のキー操作でtodoを選択出来る
  - 全体表示エリア, 期限間近表示エリア、期限切れ表示エリア、プロジェクトごとの表示エリアでそれぞれのtodoリストを優先度順に表示出来る
- NeoVimと連携することで各todoの詳細をNeoVimでmarkdownファイルとして開いて編集出来る
- 編集系機能は未実装。[todo.txt format][1]には多様なクライアントがあり、編集はそれらを利用したり、直接エディタで[todo.txt format][1]のファイルを編集する想定。

## デモ
![gif][3]

## 設定
### 環境変数
- NVIM_LISTEN_ADDRESS
  - NeoVimとの連携に使用します。指定しないときのデフォルトは`/tmp/nvim.sock`
- TODOTXT_DIR
  - `todo.txt`のファイル配置ディレクトリ。指定しないときのデフォルトは`$HOME/todotxt/`
  - 対象ディレクトリが存在しないときはローカルサーバ起動時に自動作成。
  - `todo.txt`が`TODOTXT_DIR`配下に存在しないときは空ファイルをローカルサーバ起動時に自動作成。
  - `$TODOTXT_DIR/todo`が存在しないときはローカルサーバ起動時に自動作成。このディレクトリには前述のNeoVim連携時に各todoの詳細をメモするためのmarkdownファイルが配置される。

## インストール & 起動
```
❯ git clone git@github.com:maedana/tokaido.git
❯ cd tokaido
❯ ./bin/setup
❯ ./bin/dev
```
NeoVim連携を利用する場合、別ターミナルで以下を実行してNeoVimを起動しておく
```
❯ NVIM_LISTEN_ADDRESS=/tmp/nvim.sock nvim
```

## 操作方法
基本的にはキーボード操作のみ対応。NeoVim連携が正しく設定されていればフォーカスのあるtodoのメモがNeoVim側で自動で開く。また各todoはマウスでの選択にも対応。
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

## 注意事項
- [todo.txt][1]のプロジェクト名に日本語が含まれていると一部機能しなくなる


[1]: https://github.com/todotxt/todo.txt
[2]: https://github.com/topydo/topydo
[3]: https://raw.githubusercontent.com/maedana/tokaido/main/docs/demo.gif
