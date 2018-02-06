class CartedProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :order, optional: true

  def subtotal
    price * quantity
  end

private

  def price
    product.price
  end

end
