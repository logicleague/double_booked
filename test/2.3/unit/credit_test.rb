require File.expand_path(__FILE__ + '/../../helper')

class CreditTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "first law of monetodynamics" do
    detail_one = accounts(:detail_one)
    detail_two = accounts(:detail_two)
    transaction = Transaction.new :description => "test"
    transaction.save(false)
    debit = transaction.build_debit :amount => -200,
                                    :detail_account => detail_one
    assert debit.save
    credit = transaction.build_credit :amount => 100,
                                      :detail_account => detail_two
    assert !credit.save
  end

end
