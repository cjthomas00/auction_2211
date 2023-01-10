class Auction
  attr_reader :items, :bidders

  def initialize
    @items = []
    @bidders =[]
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map { |item| item.name }
  end

  def unpopular_items
    @items.find_all { |item| item.bids == {} }
  end

  def potential_revenue
    revenue = 0
    @items.each do |item| 
      revenue += item.current_high_bid if item.bids != {}
    end
    revenue
  end

  def bidders 
    attendees = []

    @items.each do |item|  #<=== goes over items array
      item.bids.keys.each do |attendee| #<=== looks @ item and shows bids. The .keys will show bidders w/o bid amt on item. The .each do |attendee| will iterate over the attendees.
        attendees << attendee # <==== Shovels attendee into attendees array.
      end
    end
    attendees.uniq  # < ===== removes multiple occurences of a single element. i.e. [Bob, Bob] becomes [Bob]
    # @items.flat_map do |item|
    #   item.bids.map do |bidder, bid_amt|
    #     bidder.name
    #   end
    # end.uniq
  end

  def bidder_info
    bidder_info_hash = {}

    bidders.each do |attendee|
      bidder_info_hash[attendee] = { 
        budget: attendee.budget,
        items: items_by_attendee(attendee) 
    }
    end
      bidder_info_hash
  end
    
  def items_by_attendee(attendee)
      @items.select do |item|
        item.bids.keys.include?(attendee)
      end
  end

  def date 
    d = Date.today
    d.strftime("%d/%m/%Y") #can be found in Ruby docs (Date.today) 
  end
end