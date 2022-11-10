FactoryGirl.define do
    factory :cart do
      count  AllConstants::ID_OR_COUNT
      owner_id AllConstants::ID_OR_COUNT
    end
end
  