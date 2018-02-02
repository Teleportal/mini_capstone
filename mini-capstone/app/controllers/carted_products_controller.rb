class CartedProductsController < ApplicationController

  def index
    @carted_products = CartedProduct.where("user_id = #{current_user.id}")

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

end
