ActiveRecord::Schema.define(:version => 0) do
  create_table :accounts, :force => true do |t|
    t.string :type
    t.string :name
    t.integer :owner_id
    t.string :owner_type
  end
  create_table :balances, :force => true do |t|
    t.integer :account_id
    t.datetime :evaluated_at
    t.decimal :balance
  end
  create_table :entries, :force => true do |t|
    t.string :type
    t.integer :detail_account_id
    t.integer :transaction_id
    t.decimal :amount
  end
  create_table :transactions, :force => true do |t|
    t.string :type
    t.string :description
    t.datetime :transaction_date
    t.integer :auxilliary_model_id
    t.string :auxilliary_model_type
    t.timestamps
  end
  create_table :invoices, :force => true do |t|
    t.integer :buyer_account_id
    t.integer :seller_account_id
  end
  create_table :invoices, :force => true do |t|
    t.integer :buyer_account_id
    t.integer :seller_account_id
  end
# Test app models
  create_table :invoice_lines, :force => true do |t|
    t.integer :invoice_id
    t.integer :line_item_id
  end
end
