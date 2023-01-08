require './lib/attendee'
require './lib/auction'
require './lib/item'

RSpec.describe Auction do
  let(:auction) { Auction.new }

  describe "#initialize" do 
    it 'exists' do
      expect(auction).to be_instance_of(Auction)
    end
    
    it 'has attributes' do 
      expect(auction.items).to eq([])
    end
  end
end