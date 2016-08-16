require 'faker'

class Boards

  def initialize
    @title = Faker::Space.company
    @cards = []
    @lists = []
  end

  def to_s
    string = "Board title: #{@title}\n"
    string << "---------------------\n"
    string
  end

end