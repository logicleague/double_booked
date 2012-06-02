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
    tranaction.account_from = args[:account_from]
    tranaction.account_to = args[:account_to]
    tranaction.amount = args[:amount]
    transaction.save!
  end

end
