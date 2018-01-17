require "unirest"
require "tty-table"


screen_size = 200

response = Unirest.get("http://localhost:3000/all_products")
products = response.body

puts JSON.pretty_generate(products)

puts
puts "=" * screen_size
puts "Okay let's try some WEIRD STUFF".center(screen_size)
puts "=" * screen_size
puts

data = []
products.each do |datum|
  row = []
  row << datum["id"] 
  row << datum["name"]
  row << datum["price"]
  row << datum["image_url"]
  row << datum["description"]
  data << row
end

table = TTY::Table.new ["id", "name", "price", "image_url", "description"], data

# table = TTY::Table.new(products)

puts table.render(:basic, reseize: true).center(screen_size)