require 'spec_helper'

describe DetailAccount do

  subject { FactoryGirl.create :detail_account }
  let(:other_account) { FactoryGirl.create :other_account }

  it { should have_many(:entries) }
  it { should have_many(:transactions) }
  it { should have_many(:debits) }
  it { should have_many(:credits) }

  it "transfers to another account" do
    subject.transfer(1).to other_account
    subject.current_balance.balance.should eq -1
    other_account.current_balance.balance.should eq 1
  end

end
