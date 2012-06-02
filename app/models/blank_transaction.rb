class BlankTransaction
  attr_accessor :amount, :account_from

  def initialize(amount, account_from)
    @amount = amount
    @account_from = account_from
  end

  def to(account_to, args = {})
    args.merge!( :account_from => account_from,
                 :account_to => account_to,
                 :amount => amount )
    transaction = Transaction.new
    transaction.account_from = args[:account_from]
    transaction.account_to = args[:account_to]
    transaction.amount = args[:amount]
    transaction.save!
  end

end
