FactoryBot.define do
  factory :buyer_shipping_address do
    post_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    telephone_number { '123456789' }
    token {"tok_abcdefghijk00000000000000000"}

  end
end