FactoryGirl.define do
    factory :order do
        user_id 1
        menu 'menuname*2*50'
        status AllConstants::PENDING 
        owner_id AllConstants::VALUE
    end
  end