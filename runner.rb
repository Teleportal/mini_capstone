require "unirest"
require "tty-table"
require "paint"

screen_size = 200

puts "-" * screen_size
puts "~*~*~*~*~*~ Welcome to my Very Nice™ Store ~*~*~*~*~*~".center(screen_size)
puts "-" * screen_size
puts

puts Paint["Options", :blue].center(screen_size)
puts "[1] See all products".center(screen_size - 40)
puts "[2] See one product".center(screen_size - 40)
puts "[3] Create a new product".center(screen_size - 40)
puts "[4] Update a product".center(screen_size - 40)
puts "[5] Destroy a product".center(screen_size - 40)

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/products")

  products = response.body

  puts Paint["Here are my products", :white]
  puts 
  puts JSON.pretty_generate(products)

elsif input_option == "2"
  print Paint["Enter product id:", :yellow]
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body

  puts Paint["Here is what you were looking for:", :white]
  puts
  puts JSON.pretty_generate(product)
elsif input_option == "3"
  puts Paint["I'm going to need some details...", :magenta]
  client_params = {}
  print Paint["Name: ", :yellow]
  client_params[:name] = gets.chomp
  print Paint["Price: ", :yellow]
  client_params[:price] = gets.chomp
  print Paint["Image URL: ", :yellow]
  client_params[:image_url] = gets.chomp  
  print Paint["Description: ", :yellow]
  client_params[:description] = gets.chomp

  response = Unirest.post("http://localhost:3000/products",
                          parameters: client_params
                          )
  new_product = response.body
  puts JSON.pretty_generate(new_product)

elsif input_option == "4"
  puts Paint["Enter product id:" :yellow]
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body

  puts Paint["I'm going to need some details...", :magenta]
  client_params = {}
  print Paint["Name (#{product["name"]}): ", :yellow]
  client_params[:name] = gets.chomp
  print Paint["Price (#{product["price"]}): ", :yellow]
  client_params[:price] = gets.chomp
  print Paint["Image URL (#{product["image_url"]}): ", :yellow]
  client_params[:image_url] = gets.chomp  
  print Paint["Description (#{product["description"]}): ", :yellow]
  client_params[:description] = gets.chomp

  client_params.delete_if { |key, value| value.empty? }  

  response = Unirest.patch("http://localhost:3000/products/#{input_id}",
                          parameters: client_params
                          )
  updated_product = response.body


elsif input_option == "5"
  puts Paint["Enter product id:" :yellow]
  input_id = gets.chomp
  
  response = Unirest.delete("http://localhost:3000/products/#{input_id}")
  data = response.body
  puts data["message"]
end
  
  


# puts
# puts "=" * screen_size
# puts Paint["Okay let's try some WEIRD STUFF", :blue].center(screen_size)
# puts "=" * screen_size
# puts

# data = []
# products.each do |datum|
#   row = []
#   row << datum["id"] 
#   row << datum["name"]
#   row << datum["price"]
#   row << datum["image_url"]
#   row << datum["description"]
#   data << row
# end

# table = TTY::Table.new ["id", "name", "price", "image_url", "description"], data

# # table = TTY::Table.new(products)

# puts table.render(:basic, resize: true).center(screen_size)