require 'faker'
require_relative "cards"

class Lists

  attr_accessor :cards

  def initialize
    @list_name = Faker::Lorem.sentence
    @cards = []
  end

  def to_s
    string = "List name: #{@list_name}\n"
    string << "-----------------------\n"
    string
  end

  def create_new_list(list_name)
    new_list = Lists.new
    @list_name = list_name
  end

  def show_cards_in_list(list)
    cards_in_list = @cards.find {|card| card.current_list == list}
    puts cards_in_list
  end

  def create_new_card_for_list(list)
    new_card = Cards.new
    new_card.current_list = list
    new_card
  end

end