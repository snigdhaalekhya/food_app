FactoryGirl.define do
    factory :order do
        user_id AllConstants::VALUE
        menu 'menuname*2*50'
        status AllConstants::PENDING 
        owner_id AllConstants::VALUE
    end
  end