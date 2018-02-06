class Order < ApplicationRecord

  belongs_to :user
  has_many :carted_products
  has_many :products, through: :carted_products

  def calculate_subtotal
    sum = 0
    carted_products.each do |carted_product|
      sum += carted_product.subtotal
    end

    self.subtotal = sum
  end

  def calculate_tax
    self.tax = subtotal * 0.09
  end

  def calculate_total
    self.total = tax + subtotal
  end

  def calculate_totals
    calculate_subtotal
    calculate_tax
    calculate_total
  end

end
