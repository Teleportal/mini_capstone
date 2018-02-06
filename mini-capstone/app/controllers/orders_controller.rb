class OrdersController < ApplicationController
  before_action :authenticate_user


  def index
    @orders = current_user.orders

    render 'index.json.jbuilder'
  end

  def create
    @carted_products = current_user.cart

    @order = Order.new(
                      user_id: current_user.id
                      )
    if @order.save
      @carted_products.each do |carted_product|
        carted_product.order_id = @order.id
        carted_product.status = "purchased"
        if carted_product.save
        else
          render json: {errors: carted_product.errors.full_messages}, status: :bad_request
        end
      end
    else
      render json: {errors: @order.errors.full_messages}, status: :bad_request
    end

    @order.calculate_totals

    @order.save

    render 'show.json.jbuilder'
  end


end
