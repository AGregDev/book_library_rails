FactoryBot.define do
  factory :library do
    name { Faker::University.name }
  end
end
