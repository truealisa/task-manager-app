FactoryBot.define do
  factory :task do
    name { Faker::StarWars.character }
    status false
    project_id nil
    priority { Faker::Number.number(5) }
    deadline { Faker::Number.number(5) }
  end
end
