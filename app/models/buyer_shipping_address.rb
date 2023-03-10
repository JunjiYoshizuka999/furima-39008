class BuyerShippingAddress
  include ActiveModel::Model
  attr_accessor  :user_id,:item_id, :prefecture_id, :municipality, :address, :building_name, :post_code, :telephone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :municipality
    validates :address
    validates :telephone_number, numericality: {only_integer: true}, length: { in: 6..11 }
    validates :token
  end

  def save
    buyer = Buyer.create(user_id: user_id,item_id: item_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, building_name: building_name, telephone_number: telephone_number,address: address, buyer_id: buyer.id)
  end
end

