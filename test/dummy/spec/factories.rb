FactoryGirl.define do

  factory :detail_account do
    factory :other_account do
    end
  end

  factory :summary_account do
  end

  factory :user_account do
    user :user
  end

  factory :entry do
    factory :credit do
      amount 1.00
    end
    factory :debit do
      amount -1.00
    end
  end

  factory :transaction do
    account_from :detail_account
    account_to :other_account
    amount 1.00
  end

  factory :balance do
    account :detail_account
    balance 4.00
    evaluated_at 2.months.ago
  end

  factory :user do
  end

end
