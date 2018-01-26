module ProductsViews
  def products_show_view(product)
    puts Paint["~*~*~*~ Here is what you were looking for ~*~*~*~", :white].center(@screen_size)
    puts
    puts "#{product.name} - ID: #{product.id}"

    puts product.description
    puts
    puts product.price
    puts product.tax
    puts "------------------"
    puts product.total
  end

  def products_index_view(products)
    products.each do |product|
      puts "#{product.name} - ID: #{product.id}"

      puts product.description
      puts
      puts product.price
      puts product.tax
      puts "------------------"
      puts product.total
    end
  end
end