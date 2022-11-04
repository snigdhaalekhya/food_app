FactoryGirl.define do
    factory :worker do
      name Faker::Name.name[1..18]
      mobile_no Faker::Number.number(digits: 10)
      email Faker::Internet.email
      address Faker::Lorem.paragraph
      password Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password
    end
  end