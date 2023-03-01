FactoryBot.define do
  factory :item do
    item_text                { "テストテキスト" }
    item_name                { "テストネーム" }
    category_id              { 2 }
    situation_id             { 2 }
    shipping_charge_id       { 2 }
    prefecture_id            { 2 }
    number_of_day_id         { 2 }
    price                    { 300 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
