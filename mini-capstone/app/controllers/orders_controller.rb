class OrdersController < ApplicationController

  def index
    @orders = Order.all.where(user_id: current_user.id)

    render 'index.json.jbuilder'
  end

  def create
    subtotal = Product.find(params[:product_id]).price * params[:quantity].to_i
    tax = subtotal * 0.09
    total = tax + subtotal

    @order = Order.new(
                      user_id: current_user.id,
                      product_id: params[:product_id],
                      quantity: params[:quantity],
                      subtotal: subtotal,
                      tax: tax,
                      total: total 
                      )

    if @order.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @order.errors.full_messages}, status: :bad_request
    end
  end

end
