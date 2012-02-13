class DetailAccount < Account
  has_many :entries
  has_many :transactions, :through => :entries
  has_many :debits
  has_many :credits

  def transfer_to(recipient, amount, args = {})
    args.merge!( :account_from => self,
                 :account_to => recipient,
                 :amount => amount )
    Transaction.create! args
  end

end
