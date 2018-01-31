class ImagesController < ApplicationController
  def index
    search_term = params[:search]

    @images = Image.all

    if search_term
      @images = @images.where("name iLike ?", "%#{search_term}%")
    end

    sort_attribute = params[:sort]

    if sort_attribute
      @images = @images.order(sort_attribute)
    end

    render 'index.json.jbuilder'
  end

  def show
    @image = Image.find(params[:id])
    render 'show.json.jbuilder'
  end

  def create
    @image = Image.new(
                          url: params[:url],
                          product_id: params[:product_id]
                          )
    if @image.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @image.errors.full_messages}, status: :unprocessable_untity
    end
  end

  def update
    @image = Image.find(params[:id])

    @image.name = params[:name] || @image.name
    @image.price = params[:price] || @image.price
    # @image.in_stock = params[:in_stock] || @image.in_stock
    @image.image_url = params[:image_url] || @image.image_url
    @image.description = params[:description] || @image.description
    if @image.save
      render 'show.json.jbuilder'
    else
      render json: {message: @image.errors.full_mesages}, status: :unprocessable_untity
    end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    render json: {message: "Successfully deleted image ##{image.id}"}
  end
end
