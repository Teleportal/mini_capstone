module ProductsController

  def product_index_action
    products_hashes = get_request("/products")

    products = Product.convert_hashes(products_hashes)
    
    products_index_view(products)
  end

  def products_show_action
    input_id = product_id_form

    # response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)

    products_show_view(product)    
  end

  def products_create_action
    client_params = products_new_form

    response = Unirest.post("http://localhost:3000/products",
                            parameters: client_params
                            )
    # json_data = post_request('/products', client_params)

    if response.code == 200
      new_product = Product.new(response.body)
      products_show_view(new_product)
    elsif response.code == 422
      errors = response.body["errors"]
      product_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end

    # if !json_data["errors"]
    #   new_product = Product.new(json_data)
    #   products_show_view(new_product)
    # else
    #   errors = json_data["errors"]
    #   product_errors_view(errors)
    # end
  end

  def products_update_action
    input_id = product_id_form

    product_hash = get_request("/products/#{input_id}")
    product = Product.new(product_hash)

    client_params = products_update_form(product)      

    response = Unirest.patch("http://localhost:3000/products/#{input_id}", parameters: client_params)

    # json_data = patch_request("/products/#{input_id}", client_params)


    if response.code == 200
      updated_product = Product.new(json_data)

      products_show_view(updated_product)
    
    elsif response.code == 422
      errors = response.body["errors"]
      product_errors_view(errors)
      
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
  end

  def products_destroy_action
    input_id = product_id_form
    
    response = Unirest.delete("http://localhost:3000/products/#{input_id}")
    # data = delete_request("/products/#{input_id}")

    if response.code == 200
      products_destroy_view(response.body)
    elsif response.code == 422
      errors = response.body["errors"]
      product_errors_view(errors)
    elsif response.code == 401
      puts JSON.pretty_generate(response.body)
    end
  end

  def products_search_action
    search_term = products_search_form

    products_hash = get_request("/products?search=#{search_term}")

    products = Product.convert_hashes(products_hash)
    
    products_index_view(products)
    
  end

  def products_price_sort_action(attribute)

    products_hash = get_request("/products?sort=#{attribute}")

    products = Product.convert_hashes(products_hash)
    
    products_index_view(products)
  end

end