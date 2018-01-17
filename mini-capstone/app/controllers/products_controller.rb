class ProductsController < ApplicationController
  def all_products_method
    product = Product.all
    render json: product.as_json
  end
end
