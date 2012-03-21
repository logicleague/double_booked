require 'spec_helper'

describe Balance do

  let(:account) { FactoryGirl.create(:detail_account) }

  context "with a previous balance" do
    before(:each) { FactoryGirl.create(:old_balance)

  it "gets previous balance of detail account" do
    balance = account.balance_at(1.month.ago)
    balance.previous.should_not be nil
  end

  it "gets previous balance amount of detail accounttwo" do
    balance = account.balance_at(1.month.ago)
    assert_equal 4, balance.previous_balance
  end

  it "calculates balance of detail accounttwo" do
    balance = account.balance_at(3.days.ago)
    assert_equal 3, balance.balance
  end

  it "saves balance of detail account" do
    balance = account.balance_at(3.days.ago)
    assert balance.save
  end

end
