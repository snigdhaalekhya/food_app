FactoryGirl.define do
    factory :owner do
      name Faker::Name.name[1..18]
      email Faker::Internet.email
      address Faker::Lorem.paragraph
      password Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password
    end
  end