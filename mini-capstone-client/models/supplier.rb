class Supplier
  attr_accessor :id, :name, :email, :phone_number

  def initialize(input_options)
    @id = input_options["id"]
    @name = input_options["name"]
    @email = input_options["email"]
    @phone_number = input_options["phone_number"]
  end


end