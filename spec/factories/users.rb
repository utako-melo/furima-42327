FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) + '1a' }
    password_confirmation { password }
    last_name { Gimei.last }
    first_name { Gimei.first }
    first_name_kana { Gimei.first.katakana }
    last_name_kana { Gimei.last.katakana }
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2015-12-31  ') }
  end
end
