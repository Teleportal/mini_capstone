class Product < ApplicationRecord

  def discounted?
    price < 16.00
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

  def as_json
    {
    id: id,
    name: name,
    price: price,
    tax: tax,
    total: total,
    is_discounted: discounted?,
    in_stock: in_stock,
    image_url: image_url,
    description: description
    }
  end

end
