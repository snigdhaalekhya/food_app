FactoryGirl.define do
    factory :menu do
      menu_name Faker::Lorem.characters(number: 18, min_alpha: 18, min_numeric: 0)
      menu_cost Faker::Number.number[4]
      menu_description Faker::Lorem.paragraph
      menu_image AllConstants::IMAGE
      menu_category AllConstants::CATEGORY[0]
      owner_id AllConstants::ID_OR_COUNT
    end
end
  