# Memo App

メモを管理できる簡易的なアプリケーションです。

***DEMO:***

![memo_app](https://user-images.githubusercontent.com/48541378/175830390-d7a564d5-f649-44ad-95f8-e5cfc7c417ce.gif)

## Description

メモの作成、編集、削除、一覧表示の機能を実装しています。

## Features

* タイトルを未設定でのメモの作成、編集は警告が表示されます。
* 作成したメモは作成順に並びます。
* 配色は[GitHub](https://github.com)を参考にしました。

## Requirment

* ruby
* gem sinatra
* gem webrick

## Usage

リポジトリをcloneしてgemをインストールするだけです。

```shell
$ cd your_workspace
$ git clone https://github.com/karlley/sinatra-memo.git
$ cd sinatra_memo
$ bundle install
$ bundle exec ruby main.rb
```

`http://localhost:4567/` にアクセスするとアプリケーションが表示されます。

## Author

[@karlley](https://twitter.com/home)
