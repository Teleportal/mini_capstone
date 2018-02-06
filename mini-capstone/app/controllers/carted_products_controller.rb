class CartedProductsController < ApplicationController
  before_action :authenticate_user

  def index
    @carted_products = current_user.cart

    render 'index.json.jbuilder'
  end

  def create
    @carted_product = CartedProduct.new(
                                         status: "carted",
                                         user_id: current_user.id,
                                         product_id: params[:product_id],
                                         quantity: params[:quantity]
                                        )
    @carted_product.save
    render json: {message: "#{@carted_product.quantity} of #{@carted_product.product.name} added to cart."}
  end

  def destroy
    carted_product = CartedProduct.find(params[:id])
    if carted_product.status == "carted"
      carted_product.status = "removed"
      if carted_product.save
        render json: {message: "Successfully removed #{carted_product.product.name} from cart."}
      else
        render json: {errors: carted_product.errors.full_messages}, status: :bad_request
      end
    else
      render json: {message: "That item isn't in your cart!"}
    end
  end

end
