require File.expand_path(__FILE__ + '/../../helper')

class AccountTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "get balance of one" do
    account = accounts(:detail_one)
    assert_equal 4, accounts(:detail_one).balance_at(Time.now).balance
  end

  test "get balance of two" do
    account = accounts(:detail_two)
    assert_equal 5, accounts(:detail_two).balance_at(Time.now).balance
  end

  test "get old balance of two" do
    account = accounts(:detail_two)
    assert_equal 4, accounts(:detail_two).balance_at(1.month.ago).balance
  end

end
