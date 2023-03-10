class Item < ApplicationRecord
  belongs_to :user
  has_one :buyer
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :situation
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :number_of_day

  # 通常のバリデーション
  validates :item_text, presence: true
  validates :item_name, presence: true
  validates :image, presence: true
  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
  # プルダウンの選択が「---」の時は保存できないようにするバリデーション
  validates :category_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :situation_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :shipping_charge_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :number_of_day_id, numericality: { other_than: 1, message: "を入力してください" }
end
