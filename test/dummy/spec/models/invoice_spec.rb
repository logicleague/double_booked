require File.expand_path(__FILE__ + '/../../helper')

class InvoiceTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "create invoice" do
    assert Invoice.create(:buyer_account => accounts(:detail_one),
                              :seller_account => accounts(:detail_two))
  end

  test "get line_items" do
    invoice = Invoice.create(:buyer_account => accounts(:detail_one),
                                 :seller_account => accounts(:detail_two))
    invoice.line_items = accounts(:detail_one).entries
    assert_equal 2, invoice.line_items.count
  end

  test "get amount_billed" do
    invoice = Invoice.create(:buyer_account => accounts(:detail_one),
                                 :seller_account => accounts(:detail_two))
    invoice.line_items = accounts(:detail_one).entries
    assert_equal 4, invoice.amount_billed
  end

  test "show unpaid" do
    invoice = Invoice.create(:buyer_account => accounts(:detail_one),
                                 :seller_account => accounts(:detail_two))
    invoice.line_items = accounts(:detail_one).entries
    assert !invoice.paid?
  end

  test "create partial payment" do
    invoice = Invoice.create(:buyer_account => accounts(:detail_one),
                                 :seller_account => accounts(:detail_two))
    invoice.line_items = accounts(:detail_one).entries
    assert_equal 0, invoice.amount_paid
    assert invoice.pay(0.50)
    assert_equal 0.50, invoice.amount_paid
  end

  test "create full payment" do
    invoice = Invoice.create(:buyer_account => accounts(:detail_one),
                                 :seller_account => accounts(:detail_two))
    invoice.line_items = accounts(:detail_one).entries
    assert_not_equal 0, invoice.amount_owed
    assert invoice.pay_in_full
    assert_equal 0, invoice.amount_owed
  end

end
