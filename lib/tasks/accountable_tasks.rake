namespace :accountable do
  desc "Cache balances for all DetailAccounts"
  task :update_balances => :environment do
   DetailAccount.all.each do |a|
     a.balance_at(Date.today).save
   end
  end
end
