FactoryBot.define do
  factory :user do
    name                  { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    second_name           { 'てすと' }
    first_name            { 'てすと' }
    name_katakana_second  { 'テスト' }
    name_katakana_first   { 'テスト' }
    birthday              { Faker::Date.backward }
  end
end
