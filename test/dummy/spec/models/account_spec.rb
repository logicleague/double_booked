require 'spec_helper'

describe Account do

  it { should have_many(:balances) }
  it { should_not belong_to(:owner) }

  it "doesn't save an account record" do
    lambda { Account.create! }.should_raise ActiveRecord::RecordInvalid
  end

  it "gets a balance of zero" do
    account = FactoryGirl.create(:detail_account)
    account.balance_at(Time.now).balance.should eq 0
  end

  context "with a previous balance" do
    subject do
      FactoryGirl.create(:balance)
      DetailAccount.last
    end

    it "gets the current balance" do
      subject.current_balance.balance.should eq 4
    end

    it "gets the balance from three months ago" do
      subject.balance_at(3.months.ago).balance.should eq 0
    end
  end

end
