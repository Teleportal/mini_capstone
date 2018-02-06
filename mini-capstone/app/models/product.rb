class Product < ApplicationRecord

  validates :name, presence: true,
                   uniqueness: true
  # validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { in: 10..500 }

  belongs_to :supplier
  has_many :images
  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :carted_products
  has_many :orders, through: :carted_products
  

  def discounted?
    price < 16.00
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

end
