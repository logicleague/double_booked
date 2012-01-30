require File.expand_path(__FILE__ + '/../../helper')

class BalanceTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "get previous balance of two" do
    account = accounts(:detail_two)
    balance = account.balance_at(1.month.ago)
    assert_equal 1, balance.previous.id
  end

  test "get previous balance amount of two" do
    account = accounts(:detail_two)
    balance = account.balance_at(1.month.ago)
    assert_equal 4, balance.previous_balance
  end

  test "calculate balance of two" do
    account = accounts(:detail_two)
    balance = account.balance_at(3.days.ago)
    assert_equal 3, balance.balance
  end

  test "save balance of two" do
    account = accounts(:detail_two)
    balance = account.balance_at(3.days.ago)
    assert balance.save
  end

end
