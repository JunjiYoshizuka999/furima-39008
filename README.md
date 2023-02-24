# README

## usersテーブル

| Column               |  Type  | Options                  |
| -------------------- | ------ | ------------------------ |
|email                 | string | null: false, unique: true|
|encrypted_password    | string | null: false              |
|name                  | string | null: false              |
|second_name           | string | null: false              |
|first_name            | string | null: false              |
|name_katakana_second  | string | null: false              | 
|name_katakana_first   | string | null: false              |
|birthday              | date   | null: false              |

### Association

- has_many :items
- has_many :buyers

## itemsテーブル

| Column             |  Type      | Options                         |
| ------------------ | ---------- | ------------------------------- |
|item_text           | text       | null: false                     |
|item_name           | string     | null: false                     |
|category_id         | integer    | null: false                     |
|situation_id        | integer    | null: false                     |
|shipping_charge_id  | integer    | null: false                     | 
|prefecture_id       | integer    | null: false                     |
|number_of_day_id    | integer    | null: false                     |
|price               | integer    | null: false                     |
|user                | references | null: false, foreign_key: true  |

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

## shipping_addressesテーブル

| Column          |  Type      | Options                         |
| --------------- | ---------- | ------------------------------- |
|prefecture_id    | integer    | null: false                     |
|municipality     | string     | null: false                     |
|address          | string     | null: false                     |
|building_name    | string     |                                 |
|post_code        | string     | null: false                     | 
|telephone_number | string     | null: false                     |
|buyer            | references | null: false, foreign_key:true   |

### Association

- belongs_to :buyer