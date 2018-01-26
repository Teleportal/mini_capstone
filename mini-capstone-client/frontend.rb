require "unirest"
require "tty-table"
require "paint"
require_relative "controllers/products_controller"
require_relative "models/product"
require_relative "views/products_views"

class Frontend
  include ProductsController
  include ProductsViews

  def run
    
    @screen_size = 200

    puts Paint["-", :red] * @screen_size
    puts Paint["~*~*~*~*~*~ Welcome to my Very Nice™ Store ~*~*~*~*~*~", :blue].center(@screen_size)
    puts Paint["-", :red] * @screen_size
    puts

    puts Paint["Options", :blue].center(@screen_size)
    puts "[1] See all products".center(@screen_size - 40)
    puts "  [1.1] Search by product name".center(@screen_size - 40)
    puts "  [1.2] See all products sorted".center(@screen_size - 40)
    puts "[2] See one product".center(@screen_size - 40)
    puts "[3] Create a new product".center(@screen_size - 40)
    puts "[4] Update a product".center(@screen_size - 40)
    puts "[5] Destroy a product".center(@screen_size - 40)

    input_option = gets.chomp

    if input_option == "1"
      product_index_action
      
    elsif input_option == "1.1"
      print "Enter a name to search by: "
      search_term = gets.chomp

      response = Unirest.get("http://localhost:3000/products?search=#{search_term}")
      product = response.body

      puts Paint["~*~*~*~ Here is what you were looking for ~*~*~*~", :white].center(@screen_size)
      puts
      puts JSON.pretty_generate(product)  

    elsif input_option == "1.2"
      print "Enter what you would like to sort by: "
      sort_term = gets.chomp

      response = Unirest.get("http://localhost:3000/products?sort=#{sort_term}")
      product = response.body

      puts Paint["~*~*~*~ Here is what you were looking for ~*~*~*~", :white].center(@screen_size)
      puts
      puts JSON.pretty_generate(product)  
      
    elsif input_option == "2"
      products_show_action
      
    elsif input_option == "3"
      products_create_action
      
    elsif input_option == "4"
      products_update_action
      

    elsif input_option == "5"
      products_destroy_action
    end
      
    puts
    puts Paint["=", :red] * @screen_size
    puts


    # puts
    # puts "=" * @screen_size
    # puts Paint["Okay let's try some WEIRD STUFF", :blue].center(@screen_size)
    # puts "=" * @screen_size
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

    # table = TTY::Table.new(["id", "name", "price", "image_url", "description"], data)

    # table = TTY::Table.new(products)

    # puts table.render(:basic, resize: true).center(@screen_size)
  end
end