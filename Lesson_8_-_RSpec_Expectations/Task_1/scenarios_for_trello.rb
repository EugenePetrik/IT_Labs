require 'test/unit'
require 'rspec'
require_relative "lists"
require_relative "comments"
require_relative "cards"
require_relative "boards"
require_relative "team"
require_relative "users"

class TestTrello < Test::Unit::TestCase

  include RSpec::Matchers

  def setup
    @user = Users.new
    @team = Team.new
    @list = Lists.new
    @done_list = Lists.new
    @board = Boards.new
    @card = Cards.new
    @new_comment = Comments.new
    @new_card = @list.create_new_card_for_list(@list)
  end

  def test_create_new_user
    @user
    puts "========================"
    puts "User"
    puts "========================"
    expect(@user).to be_a_kind_of(Users)
    puts @user
  end

  def test_create_new_team
    @team
    puts "========================"
    puts "Team"
    puts "========================"
    puts @team
  end

  def test_add_user_to_team
    @team.members << @user
    puts "========================"
    puts "Team members"
    puts "========================"
    expect(@team.members).to include(@user)
    puts @team.members
  end

  def test_named_user
    @team.add_new_user('Eugeniy')
    puts "========================"
    puts "All users in the team"
    puts "========================"
    expect(@team.members).to satisfy { |user| user.first_name == "Eugeniy" }
    puts @team.members
  end

  def test_create_new_board
    @board
    puts "========================"
    puts "Boards"
    puts "========================"
    puts @board
  end

  def test_create_two_lists
    @list
    @done_list
    puts "========================"
    puts "Initial list"
    puts "========================"
    puts @list
    puts "========================"
    puts "Done list"
    puts "========================"
    puts @done_list
  end

  def test_create_new_card
    @card
    @list.cards << @card
    puts "========================"
    puts "Cards"
    puts "========================"
    expect(@list.cards).to include(@card)
    puts @list.cards
  end

  def test_create_new_card_for_list
    @new_card
    @list.cards << @new_card
    puts "========================"
    puts "Cards with new"
    puts "========================"
    expect(@list.cards).to include(@new_card)
    puts @list.cards
  end

  def test_show_cards_in_initial_list
    puts "========================"
    puts "Cards in initial list"
    puts "========================"
    @new_card
    @list.cards << @new_card
    @list.show_cards_in_list(@list)
    expect(@list.cards).to satisfy { |card| card.current_list == @list }
  end

  def test_move_card_to_done_list
    @new_card.move_card_to_another_list(@done_list)
    puts "========================"
    puts "Card was moved from initial to done"
    puts "========================"
    expect(@new_card.current_list).to eql(@done_list)
  end

  def test_add_checklist_to_card
    new_checklist = @card.add_checklist("Hello checklist!")
    puts "========================"
    puts "Checklists"
    puts "========================"
    expect(@card.checklist).to include("Hello checklist!"))
    puts @card.checklist
  end

  def test_create_new_comment
    @new_comment = @card.add_new_comment("Hello this is comment")
    puts "========================"
    puts "Comments"
    puts "========================"
    expect(@card.comments).to include("Hello this is comment")
    puts @card.comments
  end

  def test_delete_comment
    @new_comment = @card.add_new_comment("Hello this is comment for delete")
    @card.delete_comment("Hello this is comment for delete")
    puts "========================"
    puts "Comments after delete"
    puts "========================"
    expect(@card.comments).to be_empty
    puts @card.comments
  end

end