FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' }
    prefecture_id { 47 }
    city { '札幌市中央区' }
    house_number { '8-9' }
    building_name { 'テストビル' }
    phone_number { '09098765432' }
    token { 'tok_abcdefghijk00000000000000000' }

    association :user, :item
  end
end
