# Memo App

メモを管理できる簡易的なアプリケーションです。

***DEMO:***

![memo_app](https://user-images.githubusercontent.com/48541378/175830390-d7a564d5-f649-44ad-95f8-e5cfc7c417ce.gif)

## Description

メモの作成、編集、削除、一覧表示の機能を実装しています。

## Features

* タイトルを未設定でのメモの作成、編集は警告が表示されます。
* 配色は[GitHub](https://github.com)を参考にしました。
* テーブル作成、初期データの投入は初期化ファイルを用意しました。
* SQLインジェクション対策済みです。

## Requirment

* ruby
* PostgreSQL
* gem sinatra
* gem webrick
* gem pg

## Installation

リポジトリをcloneしてgemをインストールします。

```shell
$ cd your_workspace
$ git clone https://github.com/karlley/sinatra-memo.git
$ cd sinatra_memo
$ bundle install
```

PostgreSQLへのDB作成、テーブル作成、初期データの投入を行います。

```shell
$ psql -c "CREATE DATABASE memo_app"
$ psql -d memo_app -f initialize.sql
```

アプリケーションを起動します。

```shell
$ bundle exec ruby main.rb
```

## Usage

`http://localhost:4567/memos` にアクセスするとアプリケーションが表示されます。

### 一覧

* `http://localhost:4567/memos` にアクセスすると作成したメモ一覧ページが表示されます。
* 各ページのヘッダー部の`Memo App` をクリックするとメモ一覧ページが表示されます。

### 詳細

* メモ一覧ページから詳細表示したいメモの`Title:` のタイトル名をクリックするとメモ詳細ページが表示されます。
* `http://localhost:4567/memos/[memo_id]`でメモの詳細が表示されます。

### 作成

1. メモ一覧ページの`New Memo` ボタンをクリックするとメモ作成ページが表示されます。
2. `Title`、`Content` を入力後、`Save Memo` ボタンをクリックするとメモが作成されます。
3. 新規メモ作成後、メモ一覧ページに遷移します。

**`Title` が未入力で`Save Memo` をクリックすると警告が出ます。**

### 編集

1. メモ一覧ページから詳細表示したいメモの`Title:` のタイトル名をクリックするとメモ詳細ページが表示されます。
2. メモ詳細ページ内の`Edit Memo` ボタンをクリックするとメモ編集ページが表示されます。
3. `Title`、`Content` を編集して`Update Memo` をクリックするとメモの編集が保存されます。
4. メモ編集後、メモ詳細ページに遷移します。

**`Title` が未入力で`Update Memo` をクリックすると警告が出ます。**

### 削除

1. メモ一覧ページから詳細表示したいメモの`Title:` のタイトル名をクリックするとメモ詳細ページが表示されます。
2. メモ詳細ページ内の`Delete Memo` ボタンをクリックするとメモが削除されます。
3. メモ削除後、メモ一覧ページに遷移します。

## Author

[@karlley](https://twitter.com/home)
