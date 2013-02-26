# DoubleBooked

Flexible double-entry accounting engine for Rails apps using ActiveRecord

## Overview

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

## Usage

To use `double_booked`, you'll need to create a model that is a subclass of
`DetailAccount`. A `DetailAccount` represents an account that is directly
debited from or credited to, for example a bank account.

Let's say your users have a TokenAccount record, and are able to award each other tokens from their accounts. You'd set up the models as such:

```ruby
class User < ActiveRecord::Base
  has_one :token_account, :as => :owner
end

class TokenAccount < DetailAccount
  owned_by :user
end
```

You may want to set up a special user to issue tokens:

```ruby
# Setup the token issuer and account (the "bank")
token_issuer = User.create :email => 'token_issuer@myapp.com', ...
token_bank = token_issuer.create_token_account

token_bank.current_balance
# => 0

# Issue 10 tokens to the user Jack
jack = User.find_by_name "Jack"
token_bank.transfer(10).to jack.token_account

jack.token_account.current_balance
# => 10

token_bank.current_balance
# => -10

# Now have Jack give 2 tokens to Bob
bob = User.find_by_name("Bob")

bob.token_account.current_balance
# => 0

jack.token_account.transfer(10).to bob.token_account

jack.token_account.current_balance
# => 8

bob.token_account.current_balance
# => 2
```

At any time, the total tokens in all accounts should sum up to zero.
