require './lib/item'
require './lib/attendee'

RSpec.describe Item do
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') }
  let(:attendee1) { Attendee.new(name: 'Megan', budget: '$50') }
  let(:attendee2) { Attendee.new(name: 'Bob', budget: '$75') }

  describe '#initialize' do 
    it "exists" do
    expect(item1).to be_instance_of(Item)
    end

    it "has attributes" do 
      expect(item1.name).to eq("Chalkware Piggy Bank")
    end
  end

  describe "#current_high_bid" do
    it 'displays highest bid' do

      expect(item1.bids).to eq({})
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.current_high_bid).to eq(22)
    end
  end
end