FactoryBot.define do
  factory :project do
    title { Faker::Lorem.word }
    user_id { Faker::Number.number(10) }
  end
end
