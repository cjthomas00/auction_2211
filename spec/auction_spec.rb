require './lib/attendee'
require './lib/auction'
require './lib/item'

RSpec.describe Auction do
  let(:auction) { Auction.new }
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') }
  let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
  let(:item4) { Item.new('2 Days Dogsitting') }
  let(:item5) { Item.new('Forever Stamps') }
  let(:attendee1) { Attendee.new(name: 'Megan', budget: '$50') }
  let(:attendee2) { Attendee.new(name: 'Bob', budget: '$75') }
  let(:attendee3) { Attendee.new(name: 'Mike', budget: '$100') }

  describe "#initialize" do 
    it 'exists' do
      expect(auction).to be_instance_of(Auction)
    end
    
    it 'has attributes' do 
      expect(auction.items).to eq([])
    end
  end

  describe "#add_item(item)" do 
    it 'can add items' do
      auction.add_item(item1)
      auction.add_item(item2)
      
      expect(auction.items).to eq([item1, item2])
    end
  end

  describe "#item_names" do 
    it 'can return item names' do
      auction.add_item(item1)
      auction.add_item(item2)
    
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])  
    end
  end

  describe "#unpopular_items" do
    it "displays items with no bids" do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq([item2, item3, item5])

      item3.add_bid(attendee2, 15)

      expect(auction.unpopular_items).to eq([item2, item5])
    end
  end

  describe "#potential revenue" do
    it "displays revenue of items bid on" do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.potential_revenue).to eq(87)
    end
  end

  describe "#bidders" do
    it 'shows an array of bidders' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.bidders).to eq([attendee2, attendee1, attendee3]).or eq(["Bob", "Megan", "Mike"])
    end
  end

  describe '#bidder_info' do
    it 'shows a hash of attendees' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expected = {
    attendee1 => {:budget => 50,
                  :items => [item1] },
    attendee2 => { :budget => 75,
                    :items => [item1, item3] },
    attendee3 => { :budget => 100,
                   :items => [item4]}
          }
      expect(auction.bidder_info).to eq(expected)
    end
  end

  describe '#date' do 
    it "can determine the date" do
      allow(auction).to receive(:date) {"07/01/2023"}

      expect(auction.date).to eq("07/01/2023")
    end
  end
end