require 'stripe'
# require 'awesome_print'

class Transaction

  DEFAULT_CURRENCY = "cad"

  attr_reader :amount, :card_number, :id

  def initialize(amount, card_number)
    @amount = amount
    @card_number = card_number
  end

  def charge
    begin
      Stripe.api_key = "sk_test_hIbEn71uu7ZG7ZfP0rjA0hHc"
      charge = Stripe::Charge.create(
        :amount => self.amount, # amount in cents, again
        :currency => DEFAULT_CURRENCY, # value constant
        :source => {
          exp_month: 4,
          exp_year: 2018,
          number: self.card_number, # self.number => returns @number
          object: 'card',
          cvc: '123',
          name: 'Joe Bob'
        },
        :description => "Lighthouse Tuition"
      )

      # else
      # the code remaining in this block only runs if no error
      puts "I MADE IT"
      @id = charge.id
      return true
    rescue Stripe::CardError => e # CardError < StripeError < StandardError
      # the code here runs if there is a CardError error raised by Stripe.
      puts "ERROR!!!" # for debugging
      puts e.message
      return false
    # rescue NoMethodError # BAD ... V V BAD!
    #   puts "It works"
    end
  end



end
