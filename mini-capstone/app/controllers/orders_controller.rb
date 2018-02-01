class OrdersController < ApplicationController
  before_action :authenticate_user


  def index
    @orders = current_user.orders

    render 'index.json.jbuilder'
  end

  def create
    @order = Order.new(
                      user_id: current_user.id,
                      product_id: params[:product_id],
                      quantity: params[:quantity] 
                      )

    @order.calculate_totals

    if @order.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @order.errors.full_messages}, status: :bad_request
    end
  end

end
