class Account < ActiveRecord::Base
  has_many :balances
  validates_presence_of :name

  def self.owned_by(klass)
    @@owner_type = klass.to_s.classify.constantize
    belongs_to :owner, :polymorphic => true
    validate :check_owner_type
  end

  def balance_at(date)
    balance = Balance.find_by_account_id_and_evaluated_at(id, date)
    balance ||= Balance.new(:account => self, :evaluated_at => date)
  end

  def balance_before(date)
    balances.find :first, :conditions => ["evaluated_at < ?", date],
                          :order => "evaluated_at DESC"
  end

private
  def check_owner_type
    errors.add_to_base "owner must be an #{@@owner_type}" if
      @@owner_type and !(owner.is_a? @@owner_type)
  end

end
