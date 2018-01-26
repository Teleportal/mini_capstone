class Product
  attr_accessor :id, :name, :image_url, :description, :price, :tax, :total, :formatted_price, :is_discounted

  def initialize(input_options)
    @id = input_options["id"]
    @name = input_options["name"]
    @image_url = input_options["image_url"]
    @description = input_options["description"]
    @price = input_options["price"]
    @tax = input_options["tax"]
    @total = input_options["total"]
    @formatted_price = input_options["formatted_price"]
    @is_discounted = input_options["is_discounted"]
  end
  
end