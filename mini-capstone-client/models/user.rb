[class User
  attr_accessor :name, :email, :password_digest

  def initialize(input_options)
    @name = input_options["name"]
    @email = input_options["email"]
    @password_digest = input_options["password_digest"]
  end

end