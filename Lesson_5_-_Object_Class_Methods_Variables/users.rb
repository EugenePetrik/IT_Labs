require 'faker'

class Users

  attr_accessor :first_name, @last_name, :users

  def initialize
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email(@first_name + @last_name)
    @password = Faker::Internet.password(10, 20)
    @name = @first_name + ' ' + @last_name
  end

  def to_s
    string = "Name: #{@name}\n"
    string << "Email: #{@email}\n"
    string << "Password: #{@password}\n"
    string << "---------------------\n"
    string
  end

end