class Invoice < ActiveRecord::Base
  belongs_to :buyer_account, :class_name => 'DetailAccount'
  belongs_to :seller_account, :class_name => 'DetailAccount'
  has_many :invoice_payments, :as => :auxilliary_model
  has_many :invoice_lines
  has_many :line_items, :through => :invoice_lines

  validates_presence_of :buyer_account, :seller_account

  def self.build(entries)
    accounts = check_accounts entries
    invoice = Invoice.new
    invoice.buyer_account = accounts[:buyer]
    invoice.seller_account = accounts[:seller]
    invoice.save!
    entries.each do |entry|
      line = invoice.invoice_lines.new
      line.line_item = entry
      line.save!
    end
    invoice.close
  end

  def close
    self.open = false
    save!
  end

  def closed?
    !open
  end

  def paid?
    amount_owed <= 0
  end

  def amount_billed
    line_items.inject(0) {|amount, item| amount + item.amount}
  end

  def amount_paid
    invoice_payments(true).inject(0) {|amount, payment| amount + payment.amount}
  end

  def amount_owed
    amount_billed - amount_paid
  end

  def pay_in_full(options = {})
    pay(amount_owed, options)
  end

  def pay(amount, options = {})
    options.merge!({:description => "Payment for Invoice ##{formatted_id}",
                    :auxilliary_model => self,
                    :account_from => buyer_account,
                    :account_to => seller_account,
                    :amount => amount})
    invoice_payment = InvoicePayment.new
    invoice_payment.description = options[:description]
    invoice_payment.auxilliary_model = options[:auxilliary_model]
    invoice_payment.account_from = options[:account_from]
    invoice_payment.account_to = options[:account_to]
    invoice_payment.amount = options[:amount]
    invoice_payment.save!
  end

  def formatted_id
    "%08i" % id
  end

private
  def self.check_accounts(entries)
    accounts = {}
    entries.each do |entry|
      accounts = get_accounts entry
      raise ArgumentError, "All entries must involve the same accounts" unless
        accounts = last_accounts or last_accounts.nil?
      last_accounts = accounts
    end
    accounts
  end

  def self.get_accounts(entry)
    buyer = entry.detail_account
    seller = entry.transaction.debit_account
    seller = entry.transaction.credit_account if seller == buyer
    {:seller => seller, :buyer => buyer}
  end

end
