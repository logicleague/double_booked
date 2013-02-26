require 'spec_helper'

describe Account do

  subject { build(:account) }

  it "fails validation when an Account is instantiated" do
    subject.should_not be_valid
    subject.should have(1).error_on(:base)
    message_regex = /must not be an Account or a direct subclass of it/
    subject.errors_on(:base).first.should match message_regex
  end

end

describe DetailAccount do

  subject { build(:detail_account) }

  it "fails validation when a DetailAccount is instantiated" do
    subject.should_not be_valid
    subject.should have(1).error_on(:base)
    message_regex = /must not be an Account or a direct subclass of it/
    subject.errors_on(:base).first.should match message_regex
  end

end

describe FooAccount do

  subject { build(:foo_account) }

  it { should be_valid }

  let(:foo_account){ create(:foo_account) }

  describe "calculating current balances" do
    it "should have an valid balance of 0 to start" do
      balance = foo_account.current_balance
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should == 0.0
    end

    it "should be decremented with a debit" do
      foo_account.transfer(10.00).to(create(:foo_account), :description => "Test transfer")
      balance = foo_account.current_balance
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should be_within(0.0001).of(-10.00)
    end

    it "should be incremented with a debit" do
      target = create(:foo_account)
      foo_account.transfer(10.00).to(target, :description => "Test transfer")
      balance = target.current_balance
      balance.should_not be_nil
      balance.should be_valid
      balance.balance.should be_within(0.0001).of(10.00)
    end

    describe "in the past" do

      before(:each) do
        @from = create(:foo_account)
        @to = create(:foo_account)
      end
    
      it "should be decremented with a debit" do
       foo_account.transfer(10.00).to(create(:foo_account), :description => "Test transfer",
                                                                  :created_at => 1.week.ago)
       balance = foo_account.balance_at(1.day.ago)
       balance.should_not be_nil
       balance.should be_valid
       balance.balance.should be_within(0.0001).of(-10.00)
      end

      it "should be incremented with a debit" do
        target = create(:foo_account)
        foo_account.transfer(10.00).to(target, :description => "Test transfer", :created_at => 1.week.ago)
        balance = target.balance_at(1.day.ago)
        balance.should_not be_nil
        balance.should be_valid
        balance.balance.should be_within(0.0001).of(10.00)
      end

      it "should ignore transactions outside date range" do
        target = create(:foo_account)
        foo_account.transfer(10.00).to(target, :description => "Test transfer")
        balance = target.balance_at(1.day.ago)
        balance.should_not be_nil
        balance.should be_valid
        balance.balance.should be_within(0.0001).of(0.00)
      end

    end
  end

  describe "finding previous balances" do

    it "should find the most recent balance before a given date" do
      day_b4 = create(:balance, :account => foo_account, :evaluated_at => 2.days.ago)
      yesterday = create(:balance, :account => foo_account, :evaluated_at => 1.day.ago)
      foo_account.balance_before(Date.today).should == yesterday
    end
  end

  it "should spec owned_by once that's understood"
end

describe SummaryAccount do

  subject { build(:foo_bar_account) }

  it { should be_valid }

  it "should not be able to reference itself" do
    sa = build(:foo_bar_account)
    sa.accounts << sa
    sa.should_not be_valid
  end

end
