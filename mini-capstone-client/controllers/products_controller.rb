module ProductsController

  def product_index_action
    response = Unirest.get("http://localhost:3000/products")

    products_hash = response.body
    products = []


    puts Paint["~*~*~*~ Here are my products ~*~*~*~", :white].center(@screen_size)
    puts 
    products_hash.each do |product|
      products << Product.new(product)
    end
    
    products_index_view(products)
  end

  def products_show_action
    print Paint["Enter product id: ", :yellow]
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product_hash = response.body
    product = Product.new(product_hash)

    products_show_view(product)    
  end

  def products_create_action
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
    if response.code == 200
      new_product = response.body
      puts Paint["~*~*~*~ Here is the new product ~*~*~*~"].center(@screen_size)
      puts JSON.pretty_generate(new_product)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end

  def products_update_action
    print Paint["Enter product id: ", :yellow]
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
    if response.code == 200
    updated_product = response.body

    puts JSON.pretty_generate(updated_product)
    
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end

  def products_destroy_action
    print Paint["Enter product id: ", :yellow]
    input_id = gets.chomp
    
    response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    data = response.body
    puts Paint[data["message"], :red].center(@screen_size)
  end

end