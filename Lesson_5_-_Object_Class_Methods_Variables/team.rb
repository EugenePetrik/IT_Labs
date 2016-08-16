require 'faker'

class Team

  attr_accessor :teams, :members, :first_name

  def initialize
    @name = Faker::Name.name
    @description = Faker::Lorem.sentence
    @teams = []
    @members = []
  end

  def add_user_to_team(user)
    @members << user
  end

  def to_s
    string = "Team name: #{@name}\n"
    string << "Description: #{@description}\n"
    string << "---------------------------\n"
    string
  end

  def add_new_user(first_name)
    new_user = Users.new
    new_user.first_name = first_name
    @members << new_user
  end

end