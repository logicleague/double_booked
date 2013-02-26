FactoryGirl.define do

  factory :balance do |b|
    b.association :account, :factory => :foo_account
    b.evaluated_at 1.day.ago
    b.balance 100.00
  end
  
end
