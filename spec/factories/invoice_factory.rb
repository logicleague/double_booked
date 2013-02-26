FactoryGirl.define do

  factory :invoice do
    buyer_account :factory => :foo_account
    seller_account :factory => :foo_account
    closed false
  end
  
end
