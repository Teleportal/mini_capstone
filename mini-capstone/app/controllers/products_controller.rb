class ProductsController < ApplicationController
  def index
    search_term = params[:search]

    products = Product.all

    if search_term
      products = products.where("name iLike ?", "%#{search_term}%")
    end

    sort_attribute = params[:sort]

    if sort_attribute
      products = products.order(sort_attribute)
    end

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
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_untity
    end
  end

  def update
    product = Product.find(params[:id])

    product.name = params[:name] || product.name
    product.price = params[:price] || product.price
    # product.in_stock = params[:in_stock] || product.in_stock
    product.image_url = params[:image_url] || product.image_url
    product.description = params[:description] || product.description
    if product.save
      render json: product.as_json
    else
      render json: {message: product.errors.full_mesages}, status: :unprocessable_untity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: {message: "Successfully deleted item ##{product.id}"}
  end

end
