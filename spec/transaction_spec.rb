require 'transaction'

describe Transaction do

  describe '#charge' do 
    it 'successfully can charge given amount to Stripe' do 
      success_charge = double() # empty object instance
      expect(success_charge).to receive(:id).and_return(23445) # id method
      expect(Stripe::Charge).to receive(:create).and_return(success_charge) # fake #create on Stripe::Charge that returns the above
      transaction = Transaction.new(20, '4111111111111111') # good card
      expect(transaction.charge).to eq(23445)
    end

    it 'unsuccessfully charge if the CC declines' do 
      expect(Stripe::Charge).to receive(:create)
      transaction = Transaction.new(20, '4000000000000002') # bad card
      expect(transaction.charge).to be(false)
    end
  end

end
