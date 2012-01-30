require File.expand_path(__FILE__ + '/../../helper')

class StatementTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "get statement of two from previous month" do
    account = accounts(:detail_two)
    statement = Statement.new account, 1.month.ago, Time.now
    assert_equal 2, statement.entries.count
    assert_equal 4, statement.start_balance
    assert_equal 5, statement.end_balance
  end

end
