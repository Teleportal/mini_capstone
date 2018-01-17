class ProductsController < ApplicationController
  def all_products_method
    product = Product.all
    render json: product.as_json
  end
  def product_1_method
    product = Product.first
    render json: product.as_json
  end
  def product_2_method
    product = Product.find(2)
    render json: product.as_json
  end
  def product_3_method
    product = Product.last
    render json: product.as_json
  end
end
