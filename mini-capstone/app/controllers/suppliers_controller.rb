class SuppliersController < ApplicationController
  def index
    search_term = params[:search]

    @suppliers = Supplier.all

    if search_term
      @suppliers = @suppliers.where("name iLike ?", "%#{search_term}%")
    end

    sort_attribute = params[:sort]

    if sort_attribute
      @suppliers = @suppliers.order(sort_attribute)
    end

    render 'index.json.jbuilder'
  end

  def show
    @supplier = Supplier.find(params[:id])
    render 'show.json.jbuilder'
  end

  def create
    @supplier = Supplier.new(
                            name: params[:name],
                            email: params[:email],
                            phone_number: params[:phone_number]
                            )
    if @supplier.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @supplier.errors.full_messages}, status: :unprocessable_untity
    end
  end

  def update
    @supplier = Supplier.find(params[:id])

    @supplier.name = params[name] || @supplier.name
    @supplier.email = params[email] || @supplier.email
    @supplier.phone_number = params[phone_number] || @supplier.phone_number

    if @supplier.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @supplier.errors.full_messages}, status: :unprocessable_untity
    end

  end

  def destroy
    supplier = Supplier.find(params[:id])
    supplier.destroy
    render json: {message: "Successfully deleted supplier #{supplier.name}"}
  end
end
