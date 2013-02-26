FactoryGirl.define do

  factory :transaction do |t|
    t.description "Test transaction"
    t.association :account_from, :factory => :foo_account
    t.association :account_to, :factory => :foo_account
    t.amount 10.00
  end

  factory :invoice_payment, :parent => :transaction do
    auxilliary_model :factory => :invoice
  end
  
end
