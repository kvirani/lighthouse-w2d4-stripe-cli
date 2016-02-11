require 'stripe'

class Transaction

  attr_reader :amount, :number

  # attr_reader :number
  # ===
  # def number
  #   @number
  # end

  def initialize(amount, number)
    @amount = amount
    @number = number
  end

  def charge
    #require 'stripe' # works but not good practice
    Stripe.api_key = "sk_test_3DRar3kMwtZw8F68j7RDuNfv"

    begin
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
      puts "Charge done!"
      puts charge.inspect
      return charge.id
    rescue Stripe::CardError => e
      puts e.inspect
    #rescue NetworkError
      return false
    end
    # return true # not a good place for return true in this scenario (why??)

  end

end
