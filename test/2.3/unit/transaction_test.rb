require File.expand_path(__FILE__ + '/../../helper')

class TransactionTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "transfer" do
    one = accounts(:detail_one)
    two = accounts(:detail_two)
    one_count = one.debits.count
    two_count = two.credits.count
    transaction_count = Transaction.count
    transaction = Transaction.new :account_from => one, :account_to => two,
                                  :amount => 500, :description => "test"
    assert transaction.save
    assert_equal transaction_count + 1, Transaction.count
    assert_equal one_count + 1, one.debits.count
    assert_equal -500, transaction.debit.amount
    assert_equal two_count + 1, two.credits.count
    assert_equal 500, transaction.credit.amount
  end

  test "transfer fails on account_to" do
    one = accounts(:detail_one)
    one_debits = one.debits.count
    one_credits = one.credits.count
    transaction_count = Transaction.count
    invalid = Credit.first
    transaction = Transaction.new :account_from => one, :account_to => invalid,
                                  :amount => 500, :description => "test"
    assert_raises ActiveRecord::AssociationTypeMismatch do
      transaction.save
    end
    assert transaction.new_record?
    assert_equal transaction_count, Transaction.count
    assert_equal one_debits, one.debits.count
    assert_equal one_credits, one.credits.count
  end

  test "transfer fails on account_from" do
    one = accounts(:detail_one)
    one_debits = one.debits.count
    one_credits = one.credits.count
    transaction_count = Transaction.count
    invalid = Debit.first
    transaction = Transaction.new :account_from => invalid, :account_to => one, 
                                  :amount => 500, :description => "test"
    assert_raises ActiveRecord::AssociationTypeMismatch do
      transaction.save
    end
    assert transaction.new_record?
    assert_equal transaction_count, Transaction.count
    assert_equal one_credits, one.credits.count
    assert_equal one_debits, one.debits.count
  end

  test "transfer fails on transaction" do
    one = accounts(:detail_one)
    two = accounts(:detail_two)
    one_count = one.debits.count
    two_count = two.credits.count
    transaction_count = Transaction.count
    transaction = Transaction.new :account_from => one, :account_to => two, 
                                  :amount => 500
    assert !transaction.save
    assert transaction.new_record?
    assert_equal transaction_count, Transaction.count
    assert_equal one_count, one.debits.count
    assert_equal two_count, two.credits.count
  end

end
