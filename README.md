# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users

|Column|Type|Options|
|nickname----------|string|null: false|
|email-------------|string|null: false, unique: true|
|encrypted_password|string|null: false|
|last_name---------|string|null: false|
|first_name--------|string|null: false|
|last_name_kana----|string|null: false|
|first_name_kana---|string|null: false|
|birth_date--------|date--|null: false|

### Association
has_many items
has_many orders


## items

|Column|Type|Options|
|name-------------|string----|null: false|
|description------|text------|null: false|
|category_id------|integer---|null: false|
|condition_id-----|integer---|null: false|
|shipping_costs_id|integer---|null: false|
|prefecture_id----|integer---|null: false|
|delivery_time_id-|integer---|null: false|
|price------------|integer---|null: false|
|user-------------|references|null: false, foreign key: true|

### Association
belongs_to user
has_one :order


## orders

|Column|Type|Options|
|item|references|null: false, foreign key: true|
|user|references|null: false, foreign key: true|

### Association
belongs_to user
belongs_to item
has_one address


## addresses

|Column|Type|Options|
|post_code----|string----|null: false|
|prefecture_id|integer---|null: false|
|city---------|string----|null: false|
|house_number-|string----|null: false|
|building_name|string----|
|phone_number-|string----|null: false|
|order--------|references|null: false, foreign key: true|

### Association
belongs_to order

# # # # #
upstream app_server {
  # Unicornと連携させるための設定
  server unix:/var/www/furima-42327/shared/tmp/sockets/unicorn.sock;
}

# {}で囲った部分をブロックと呼ぶ。サーバの設定ができる
server {
  # このプログラムが接続を受け付けるポート番号
  listen 80;
  # 接続を受け付けるリクエストURL ここに書いていないURLではアクセスできない
  server_name Elastic IP;

  # クライアントからアップロードされてくるファイルの容量の上限を2ギガに設定。デフォルトは1メガなので大きめにしておく
  client_max_body_size 2g;

# 接続が来た際のrootディレクトリ
  root /var/www/furima-42327/current/public;

# assetsファイル(CSSやJavaScriptのファイルなど)にアクセスが来た際に適用される設定
  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
    root /var/www/furima-42327/current/public;
  }

  try_files $uri/index.html $uri @unicorn;

  location @unicorn {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://app_server;
  }

  error_page 500 502 503 504 /500.html;
}