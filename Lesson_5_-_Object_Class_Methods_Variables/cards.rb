require 'faker'

class Cards

  attr_accessor :comments, :checklist, :current_list

  def initialize
    @card_name =  Faker::Lorem.sentence
    @checklist_item = Faker::Lorem.sentence
    @current_list = 0
    @checklist = []
    @comments = []
  end

  def to_s
    string = "Card name: #{@card_name}\n"
    string << "-----------------------\n"
    string
  end

  def add_checklist(string)
    @checklist << string
  end

  def add_new_comment(comment)
    @write_comment = comment
    @comments << comment
  end

  def delete_comment(comment)
    @comments.delete(comment)
  end

  def move_card_to_another_list(new_list)
    @current_list = new_list
  end

end