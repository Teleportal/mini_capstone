module ProductsViews
  def products_show_view(product)
    puts Paint["~*~*~*~ Here is the product ~*~*~*~", :white].center(@screen_size)
    puts
    puts "#{product.name} - ID: #{product.id}"
    puts "Brought to you by #{product.supplier_name}"
    puts product.description
    puts product.images
    puts
    puts product.formatted_price
    puts product.formatted_tax
    puts "------------------"
    puts product.formatted_total
  end

  def products_index_view(products)
    puts Paint["~*~*~*~ Here are the products you were looking for ~*~*~*~", :white].center(@screen_size)
    puts
    products.each do |product|
      puts "#{product.name} - ID: #{product.id}"
      puts "Brought to you by #{product.supplier_name}"
      puts product.description
      puts product.images
      puts
      puts product.formatted_price
      puts product.formatted_tax
      puts "------------------"
      puts product.formatted_total
      puts
    end
  end

  def products_destroy_view(data)
    puts Paint[data["message"], :red].center(@screen_size)
  end

  def product_id_form
    print Paint["Enter product id: ", :yellow]
    gets.chomp
  end  

  def products_new_form
    puts Paint["I'm going to need some details...", :magenta]
    client_params = {}
    print Paint["Name: ", :yellow]
    client_params[:name] = gets.chomp
    print Paint["Price: ", :yellow]
    client_params[:price] = gets.chomp
    # print Paint["Image URL: ", :yellow]
    # client_params[:images] = gets.chomp
    print Paint["Description: ", :yellow]
    client_params[:description] = gets.chomp
    print Paint["Supplier ID: ", :yellow]
    client_params[:supplier_id] = gets.chomp

    client_params
  end

  def products_update_form(product)
    puts Paint["I'm going to need some details...", :magenta]
    client_params = {}
    print Paint["Name (#{product.name}): ", :yellow]
    client_params[:name] = gets.chomp
    print Paint["Price (#{product.price}): ", :yellow]
    client_params[:price] = gets.chomp
    # print Paint["Image URL (#{product.image_url}): ", :yellow]
    # client_params[:image_url] = gets.chomp  
    print Paint["Description (#{product.description}): ", :yellow]
    client_params[:description] = gets.chomp
    print Paint["Supplier ID (#{product.supplier_id}): ", :yellow]
    client_params[:supplier_id] = gets.chomp

    client_params.delete_if { |key, value| value.empty? }
    client_params
  end

  def product_errors_view(errors)
    errors.each do |error|
        puts error
      end
  end

  def products_search_form
    print "Enter a name to search by: "
    gets.chomp
  end

  def add_image_form
    client_params = {}
    print "What is the image's url:"
    client_params[:url] = gets.chomp
    print "what is the id of the product for this image:"
    client_params[:product_id] = gets.chomp
    client_params
  end

end