# DoubleBooked

Flexible double-entry accounting engine for Rails apps using ActiveRecord

## Usage

The core of `double_booked` are Accounts and Transactions.  The concept of an account is probably familiar to most developers-- think of your checking or savings accounts.  A transaction links two accounts together, posting a debit to one, and a credit to another.  The credits and debits must be equal in amount.  That's it!

The system also includes invoices, payments, and the ability to mark any eligible transaction as payment for an invoice, as long as the buyer's account is involved in the transaction.

## Installation

In your Gemfile, put:
```
source :rubygems

gem 'double_booked'
```

Then on the command line:
```bash
bundle install
rails g double_booked:migrations
rake db:migrate
```
