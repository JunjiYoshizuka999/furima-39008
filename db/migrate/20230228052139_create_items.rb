class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.text :item_text,                 null: false
      t.string :item_name,               null: false
      t.integer :category_id,            null: false
      t.integer :situation_id,           null: false
      t.integer :shipping_charge_id,     null: false
      t.integer :prefecture_id,          null: false
      t.integer :number_of_day_id,       null: false
      t.integer :price,                  null: false
      t.references :user,                null: false, foreign_key: true
      t.timestamps
    end
  end
end
