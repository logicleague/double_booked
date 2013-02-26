FactoryGirl.define do

  factory :account do
  end

  factory :detail_account do
  end

  factory :summary_account do
  end

  # FooAccount is a subclass of DetailAccount
  factory :foo_account do
  end

  # BarAccount is a subclass of DetailAccount
  factory :bar_account do
  end

  # FooBarAccount is a subclass of SummaryAccount
  factory :foo_bar_account do
    accounts do
      [FactoryGirl.create(:foo_account), FactoryGirl.create(:bar_account)]
    end
  end

end
