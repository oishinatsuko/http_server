http_server
===========

# 3年目目標のHTTPサーバー

## 実装内容

1  パスによってファイルを表示(適当なhtmlでOK)
2	ドキュメントルートの設定は設定ファイルで
3	存在しないパスが指定された場合は404
4	複数のリクエストをさばけること
5	リクエストとリクエストに対しての結果をログにはく
6	表示内容：
		リクエストのURL, メソッド, ContentType, AcceptType
		レスポンスのステータス
7	デーモン化は不要

## 確認方法

1	ブラウザで http://localhost/hoge.html で表示できること
2	ブラウザで http://localhost/sample/hoge.html
3	ブラウザで http://localhost/fuga.html で404が返される
4	ブラウザで http://localhost/bigfile.html リクエスト後
5	別ブラウザ(別タブ)で http://localhost/hoge.html で表示できること
		bigfile.htmlも表示されること
		(hoge.html, sample/hoge.html, bigfile.htmlは用意しておく、bigfileは500Mぐらい?)
6	ログを確認
