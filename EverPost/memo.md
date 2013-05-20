# FilePostEverのタスクリスト

## FilePostEverとは
* InputEverのプロトタイプ
* FilePostの拡張アプリ
* PCで作成したファイルをEvernoteに登録可能とする
* その際にtitle, tag, notebookを指定可能とする

## 現状
* ボタンを押したらEvernoteのノートを追加する
done

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