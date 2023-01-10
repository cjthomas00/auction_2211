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
    bidder_info_hash = {} #<==== creates empty hash.
    
    bidders.each do |attendee| #<== iterates over the bidders array.
      bidder_info_hash[attendee] = { #<== makes attendee the key in the bidder_info_hash.
        budget: attendee.budget,
        items: items_by_attendee(attendee) # <== makes attendee budget and items they've bid on values for the Attendee key.
    }
    end
      bidder_info_hash
      #   #bidder_info = Hash.new {|hash, key| hash[key] = {budget: 0, items: []}}
      # # bidders = @items.flat_map {|item| item.ids.keys}.uniq
      # #bider.each do |attendee|
      #   bidder_info[attendee][:budget] = attendee.budget
      #   bidder_info[attendee][:items] += @items.find_all {|item| item.bids.include?(attendee) }
  # end
  # bidder_info
  end
    
  def items_by_attendee(attendee)  # <== helper method that selects its that an attendee in the arugment parameter has bid on.
      @items.select do |item|
        item.bids.keys.include?(attendee)
      end
  end

  def date 
    d = Date.today
    d.strftime("%d/%m/%Y") #can be found in Ruby docs (Date.today) 
  end
end