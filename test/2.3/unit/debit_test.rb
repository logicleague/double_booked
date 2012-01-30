require File.expand_path(__FILE__ + '/../../helper')

class DebitTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "not balanced" do
    detail_one = accounts(:detail_one)
    detail_two = accounts(:detail_two)
    transaction = Transaction.new :description => "test"
    transaction.save(false)
    debit = transaction.build_debit :amount => -200,
                                    :detail_account => detail_one
    assert debit.save
    assert debit.credit.nil?
  end

  test "balanced" do
    one = accounts(:detail_one)
    two = accounts(:detail_two)
    transaction = Transaction.new :account_from => one, :account_to => two,
                                  :amount => 200, :description => "test"
    assert transaction.save
    debit = transaction.debit
    assert debit.balanced?
  end

end
