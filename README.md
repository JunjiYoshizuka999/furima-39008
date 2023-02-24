# README

## usersテーブル

| Column               |  Type  | Options                  |
| -------------------- | ------ | ------------------------ |
|email                 | string | null: false, unique: true|
|password              | string | null: false              |
|name                  | string | null: false              |
|name_kana_second      | string | null: false              |
|name_kana_first       | string | null: false              |
|name_katakana_second  | string | null: false              | 
|name_katakana_first   | string | null: false              |
|birthday_year         | integer| null: false              |
|birthday_month        | integer| null: false              |
|birthday_date         | integer| null: false              |

### Association

- has_many :items
- has_many :buyers

## itemsテーブル

| Column           |  Type      | Options                         |
| ---------------- | ---------- | ------------------------------- |
|text              | text       | null: false                     |
|item_name         | string     | null: false                     |
|category          | string     | null: false                     |
|situation         | string     | null: false                     |
|shipping_charges  | string     | null: false                     | 
|sender            | string     | null: false                     |
|number_of_days    | integer    | null: false                     |
|price             | integer    | null: false                     |
|user              | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_one :buyer

## buyersテーブル

| Column    |  Type      | Options                        |
| --------- | ---------- | ------------------------------ |
|item       | references | null: false, foreign_key: true |
|user       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addressテーブル

| Column          |  Type      | Options                         |
| --------------- | ---------- | ------------------------------- |
|prefectures      | string     | null: false                     |
|municipality     | string     | null: false                     |
|address          | string     | null: false                     |
|building_name    | string     |                                 |
|post_code        | integer    | null: false                     | 
|telephone_number | integer    | null: false                     |
|buyer            | references | null: false, foreign_key:true   |

### Association

- belongs_to :buyer