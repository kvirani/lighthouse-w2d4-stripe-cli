require 'transaction'

describe Transaction do

  describe '#charge' do
    it 'successfully can charge given amount to Stripe' do
      # fake_charge = Stripe::Charge.new(... oh crap what goes here ... ) # annoying
      # fake_charge below is a "Double" class. Because it responds to id, we are making it quack like Stripe::Charge instance
      fake_charge = double(id: "ch_fdsasafsa") # using RSpec's mocking functionality

      # expect(fake_charge).to receive(:id).and_return()
      # fake_charge = Object.new
      # fake_charge.define_method :id do
      #   "ch_45fdglkj354"
      #   return 5
      # end
       # string like to_s
      expect(Stripe::Charge).to receive(:create).and_return(fake_charge)
      t = Transaction.new(1_000, '4111111111111111')
      expect(t.charge).to be(true)
    end

    # Didn't full implement this (discussed at the end) ...
    # it 'handles stripe card error properly' do
    #   expect(Stripe::Charge).to receive(:create)._and_raise_error(Stripe::CardError.new())
    # end
  end

end
