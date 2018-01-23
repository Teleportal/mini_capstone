class ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products.as_json
  end
  def show
    product = Product.find(params[:id])
    render json: product.as_json
  end
  def create
    product = Product.new(
                          name: params[:name],
                          price: params[:price],
                          # in_stock: params[:in_stock],
                          image_url: params[:image_url],
                          description: params[:description]
                          )
    product.save
    render json: product.as_json
  end
  def update
    product = Product.find(params[:id])

    product.name = params[:name] || product.name
    product.price = params[:price] || product.price
    # product.in_stock = params[:in_stock] || product.in_stock
    product.image_url = params[:image_url] || product.image_url
    product.description = params[:description] || product.description
    product.save

    render json: product.as_json
  end
  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: {message: "Successfully deleted item ##{product.id}"}
  end
end
