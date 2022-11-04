FactoryGirl.define do
    factory :menu do
      menu_name 'Menuname'
      menu_cost Faker::Number.number[4]
      menu_description Faker::Lorem.paragraph
      menu_image AllConstants::IMAGE
      menu_category AllConstants::CATEGORY[0]
      owner_id AllConstants::VALUE
    end
  end