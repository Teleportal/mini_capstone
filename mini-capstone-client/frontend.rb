require "unirest"
require "tty-table"
require "paint"
require_relative "controllers/products_controller"
require_relative "controllers/images_controller"
require_relative "controllers/users_controller"
require_relative "models/product"
require_relative "models/supplier"
require_relative "models/user"
require_relative "views/products_views"
require_relative "views/users_views"

class Frontend
  include ProductsController
  include ProductsViews
  include UserController
  include UsersViews

  
  def run
    while true
      @screen_size = 200

      system 'clear'

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
      puts "  [1.5] See products by category".center(@screen_size - 40)
      puts "[2] See one product".center(@screen_size - 40)
      # if 
        puts "[3] Create a new product".center(@screen_size - 40)
        puts "[4] Update a product".center(@screen_size - 40)
        puts "[5] Destroy a product".center(@screen_size - 40)
      # end
      
      puts "[signup] Create a new user".center(@screen_size - 40)
      puts "[login] Login (create a web token)".center(@screen_size - 40)
      puts "[logout] Logout (erase the web token)".center(@screen_size - 40)

      puts "[add] Add product to cart".center(@screen_size - 40)
      puts "[cart] See your cart".center(@screen_size - 40)
      puts "[remove] Remove an item from cart".center(@screen_size - 40)

      puts "[order] Create an order of products in your cart".center(@screen_size - 40)
      puts "[orders] See all orders".center(@screen_size - 40)

      puts "[q] Exit".center(@screen_size - 40)

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

      elsif input_option == "1.5"

        puts
        response = Unirest.get("http://localhost:3000/categories")
        category_hashes = response.body
        puts "Categories"
        puts "-" * 50
        category_hashes.each do |category|
          puts "- #{category["name"]}"
        end
        print "Enter Category Name: "
        category_name = gets.chomp
        response = Unirest.get("http://localhost:3000/products?category=#{category_name}")
        products_index_view(response.body)

      elsif input_option == "2"
        products_show_action
        
      elsif input_option == "3"
        products_create_action
        
      elsif input_option == "4"
        products_update_action
        

      elsif input_option == "5"
        products_destroy_action

      elsif input_option == "signup"
        user_create_action

      elsif input_option == "login"
        puts "Login"
        print "Email: "
        input_email = gets.chomp
        print "Password: "
        input_password = gets.chomp

        response = Unirest.post(
                                "http://localhost:3000/user_token",
                                parameters: {
                                              auth: {
                                                      email: input_email,
                                                      password: input_password
                                                    }
                                            }
                                )
        puts JSON.pretty_generate(response.body)
        jwt = response.body["jwt"]
        Unirest.default_header("Authorization", "Bearer #{jwt}")

      elsif input_option == "logout"
        jwt = ""
        Unirest.clear_default_headers()

      elsif input_option == "add"
        print "Product ID: "
        product = gets.chomp
        print "How many do you want: "
        amount = gets.chomp

        response = Unirest.post(
                                "http://localhost:3000/carted_products",
                                parameters: {
                                              product_id: product,
                                              quantity: amount
                                            }
                                )

        if response.code == 200
          puts JSON.pretty_generate(response.body)
        elsif response.code == 401
          puts "Nope, try logging in first."
        end

      elsif input_option == "cart"
        response = Unirest.get("http://localhost:3000/carted_products")

        if response.code == 200
          carted_products = response.body
          carted_products.each do |carted_product_hash|
            puts carted_product_hash["product"]
            puts carted_product_hash["quantity"]
          end
        else
          puts "Nope, try logging in first."
        end

      elsif input_option == "remove"

        print "Enter carted product's id: "
        input_id = gets.chomp

        response = Unirest.delete("http://localhost:3000/carted_products/#{input_id}")
        if response.code == 200
          puts JSON.pretty_generate(response.body)
        else
          puts "Nope, try logging in first."
        end

      elsif input_option == "order"
        response = Unirest.post(
                                "http://localhost:3000/orders"
                                )

        if response.code == 200
          puts JSON.pretty_generate(response.body)
        else
          puts "Nope, try logging in first."
        end
          
      elsif input_option == "orders"
        response = Unirest.get("http://localhost:3000/orders")
        # json_data = get_request("/orders")

        if response.code == 200
          puts JSON.pretty_generate(response.body)
        elsif response.code == 401
          puts "You don't have a list of orders until you log in."
        end

      elsif input_option == "q"
        puts "Thank you for your usage."
        exit
        
      end
        
      puts
      puts Paint["=", :red] * @screen_size
      gets


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