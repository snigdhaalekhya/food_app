FactoryGirl.define do
    factory :owner do
      name Faker::Name.name[1..18]
      email Faker::Internet.email
      address Faker::Lorem.paragraph
      password 'Abcdef@3'
    end
  end