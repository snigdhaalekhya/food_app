FactoryGirl.define do
    factory :order do
        user_id AllConstants::ID_OR_COUNT
        menu 'menuname*2*50'
        status AllConstants::PENDING 
        owner_id AllConstants::ID_OR_COUNT
    end
end
