FactoryGirl.define do
    factory :cart do
      count  AllConstants::VALUE
      owner_id AllConstants::VALUE
    end
  end
  