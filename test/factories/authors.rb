FactoryBot.define do
  
  factory :author do
    name { Faker::Name.first_name }
  end
  
end