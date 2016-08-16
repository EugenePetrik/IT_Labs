require 'faker'

class Comments

  def initialize
    @write_comment = Faker::Lorem.sentence
  end

  def to_s
    string = "Comment: #{@write_comment}\n"
    string << "-------------------------\n"
    string
  end

end