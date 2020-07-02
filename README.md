# README

## 基本情報
アプリ名：ColorSend
URL：　https://color-send.herokuapp.com

## 機能
アプリの仕様のうち、分かりにくそうなものをピックアップしました。

### Facebook認証
認証されているURL(有効なOAuthリダイレクトURI)
①ローカル環境（設定済み）
* https://localhost:3001/users/auth/facebook/
* https://localhost:3001/users/auth/facebook/callback/
②ローカル環境（未設定）
* https://localhost:3000/users/auth/facebook/
* https://localhost:3000/users/auth/facebook/callback/
③本番環境
* https://color-send.herokuapp.com/users/auth/facebook
* https://color-send.herokuapp.com/users/auth/facebook/callback/

### サインアップ
Home画面で”さあ、はじめよう”と書かれたボタンをクリック
-> Facebook認証
-> 新規登録画面で必要事項の入力
-> ユーザー登録される
-> 自動ログイン

### ログイン（２パターン）
①Home画面で”さあ、はじめよう”と書かれたボタンをクリック
-> Facebook認証
-> ログイン
②Home画面で”ログイン”と書かれたボタンをクリック（右上）
-> ユーザー名、パスワード入力
-> ログイン

### 通知機能
非同期になっている。リロードされると通知が来ているかどうか分かる。
