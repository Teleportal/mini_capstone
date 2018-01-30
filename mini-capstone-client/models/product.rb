class Product
  attr_accessor :id, :name, :images, :description, :price, :tax, :total, :formatted_price, :formatted_tax, :formatted_total, :is_discounted, :supplier_name, :supplier_id

  def initialize(input_options)
    @id = input_options["id"]
    @name = input_options["name"]
    @images = []
    input_options["images"].each do |image|
      @images << image["url"]
    end
    @description = input_options["description"]
    @price = input_options["price"]
    @tax = input_options["tax"]
    @total = input_options["total"]
    @formatted_price = input_options["formatted"]["price"]
    @formatted_tax = input_options["formatted"]["tax"]
    @formatted_total = input_options["formatted"]["total"]
    @is_discounted = input_options["is_discounted"]
    @supplier_name = input_options["supplier"]["name"]
    @supplier_id = input_options["supplier"]["id"]
  end
  
  def self.convert_hashes(product_hashes)
    collection = []

    product_hashes.each do |product|
      collection << Product.new(product)
    end

    collection
  end

end