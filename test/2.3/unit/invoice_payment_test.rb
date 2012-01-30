require File.expand_path(__FILE__ + '/../../helper')

class InvoicePaymentTest < ActiveSupport::TestCase

  def setup
    load_models
  end

  test "partial payment" do
    invoice = Invoice.create(:buyer_account => accounts(:detail_one),
                             :seller_account => accounts(:detail_two))
    invoice.line_items = accounts(:detail_one).entries
    assert payment = invoice.pay(0.50)
    assert !payment.pays_in_full?
  end

  test "full payment" do
    invoice = Invoice.create(:buyer_account => accounts(:detail_one),
                                 :seller_account => accounts(:detail_two))
    invoice.line_items = accounts(:detail_one).entries
    assert payment = invoice.pay_in_full
    assert payment.pays_in_full?
  end

end
