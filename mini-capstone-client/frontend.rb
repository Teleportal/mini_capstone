require "unirest"
require "tty-table"
require "paint"
require_relative "controllers/products_controller"
require_relative "models/product"
require_relative "models/supplier"
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
    puts "  [1.2] See all products sorted by price".center(@screen_size - 40)
    puts "  [1.3] See all products sorted by name".center(@screen_size - 40)
    puts "  [1.4] See all products sorted by description".center(@screen_size - 40)
    puts "[2] See one product".center(@screen_size - 40)
    puts "[3] Create a new product".center(@screen_size - 40)
    puts "[4] Update a product".center(@screen_size - 40)
    puts "[5] Destroy a product".center(@screen_size - 40)

    input_option = gets.chomp

    if input_option == "1"
      product_index_action
      
    elsif input_option == "1.1"
      products_search_action

    elsif input_option == "1.2"
      products_sort_action("price")
      
    elsif input_option == "1.3"
      products_sort_action("name")
      
    elsif input_option == "1.4"
      products_sort_action("description")

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

private
  def get_request(url, client_params={})
    Unirest.get("http://localhost:3000#{url}", parameters: client_params).body
  end

  def post_request(url, client_params={})
    response = Unirest.post("http://localhost:3000#{url}", parameters: client_params).body
  end

  def patch_request(url, client_params={})
    Unirest.patch("http://localhost:3000#{url}", parameters: client_params).body
  end

  def delete_request(url, client_params={})
    Unirest.delete("http://localhost:3000#{url}", parameters: client_params).body
  end
end