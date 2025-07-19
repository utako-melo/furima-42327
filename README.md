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
|nickname--------|VARCHAR(255)|null: false, unique: true|
|email-----------|VARCHAR(255)|null: false, unique: true|
|password_digest-|VARCHAR(255)|null: false|
|last_name-------|VARCHAR(255)|null: false|
|first_name------|VARCHAR(255)|null: false|
|birth_date------|date--------|null: false|

### Association
has_many items
has_many orders


## items

|Column|Type|Options|
|name-------|VARCHAR(255)|null: false|
|description|TEXT--------|null: false|
|category---|VARCHAR(255)|null: false|
|price------|integer-----|null: false|
|user-------|references--|null: false, foreign key: true|

### Association
belongs_to user
has_many orders


## orders

|Column|Type|Options|
|item|references|null: false, foreign key: true|
|user|references|null: false, foreign key: true|

### Association
belongs_to user
belongs_to items
belongs_to addresses


## items

|Column|Type|Options|
|address-----|text--------|null: false|
|phone_number|VARCHAR(255)|null: false|
|order-------|references--|null: false, foreign key: true|

### Association
belongs_to orders