class DetailAccount < Account
  has_many :entries
  has_many :transactions, :through => :entries
  has_many :debits
  has_many :credits

  def transfer_to(recipient, amount, args = {})
    args.merge!( :from_account => self,
                 :to_account => recipient,
                 :amount => amount )
    Transaction.create! args
  end

end
