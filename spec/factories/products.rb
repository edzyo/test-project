FactoryBot.define do
  factory :product do
    name { Faker::Food.fruits }
    price { Faker::Commerce.price }
    category_id nil
  end
end