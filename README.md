W2D4
=========

## Objective

Build a Class to charge people money,

To make this interesting, I'm gonna make it REAL and use a real payment processing service (Stripe). But that means a bit of hand waving and extra context / explanation will be required.

In the process try and cover the following:

1. Constants in Ruby
2. Namespacing (again)
3. Custom Exceptions
4. Stubbing and Mocking in RSpec (common use case)













```ruby
    Stripe.api_key = "sk_test_hIbEn71uu7ZG7ZfP0rjA0hHc"
    charge = Stripe::Charge.create(
      :amount => self.amount, # amount in cents, again
      :currency => "cad",
      :source => {
        exp_month: 4,
        exp_year: 2018,
        number: self.number, # self.number => returns @number
        object: 'card',
        cvc: '123',
        name: 'Joe Bob'
      },
      :description => "Example charge"
    )
```











```ruby
  fake_charge = double(id: "ch_fdsasafsa") # using RSpec's mocking
  expect(Stripe::Charge).to receive(:create).and_return(fake_charge)
  t = Transaction.new(1_000, '4111111111111111')
  expect(t.charge).to be(true)
```
