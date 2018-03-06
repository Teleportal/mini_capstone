class ProductsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    search_term = params[:search]

    @products = Product.all

    if search_term
      @products = @products.where("name iLike ?", "%#{search_term}%")
    end

    sort_attribute = params[:sort]

    if sort_attribute
      @products = @products.order(sort_attribute)
    end

    category_name = params[:category]
    if category_name
      @products = Category.find_by(name: category_name).products
    end

    render 'index.json.jbuilder'
  end

  def show
    @product = Product.find(params[:id])
    render 'show.json.jbuilder'
  end

  def create
    @product = Product.new(
                          name: params[:name],
                          price: params[:price],
                          description: params[:description],
                          supplier_id: params[:supplier_id]
                          )
    if @product.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])

    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.description = params[:description] || @product.description
    @product.supplier_id = params[:supplier_id] || @product.supplier_id

    if @product.save
      render 'show.json.jbuilder'
    else
      render json: {message: @product.errors.full_mesages}, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: {message: "Successfully deleted item ##{product.id}"}
  end

end
