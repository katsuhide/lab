# FilePostEverのタスクリスト

## FilePostEverとは
* InputEverのプロトタイプ
* FilePostの拡張アプリ
* PCで作成したファイルをEvernoteに登録可能とする
* その際にtitle, tag, notebookを指定可能とする

## 現状
* Notebookをインクリメンタルサーチ可能とする
1. notebookの一覧を取得する
2. リストをcomboboxの値に設定する
そうすれば、自然とインクリメンタルサーチができるようになるはず
3. 指定されたnotebookを取得する
4. 指定されたnotebookを元にcreate noteする

## マイルストーン
* モック画面の作成
* ボタンを押したらEvernoteのノートを追加する
* ノートを追加する際に添付ファイルを追加する
* 指定された値、ファイルでノートを追加する
* Notebookをインクリメンタルサーチ可能とする
* tagをインクリメンタルサーチ可能とする

## 課題
* evernoteへpostするためのrbをrquireする際のパスの指定が固定
* evernoteAPIを叩くための各種ファイルのrquireをどうするか（今は.rbenv
* 複数ファイルの添付を可能にする
