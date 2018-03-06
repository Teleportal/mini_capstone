require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe '#discounted?' do
    it 'should return true if the price is below 16' do
      shirt = Product.create(name: "Test Shirt", price: 15.00, description: "This shirt is meant to be tested on.")
      expect(shirt.discounted?).to eq(true)
    end

    it 'should return false if the price is above 16' do
      shirt = Product.create(name: "Test Shirt", price: 20.00, description: "This shirt is meant to be tested on.")
      expect(shirt.discounted?).to eq(false)
    end
  end

  describe '#tax' do
    it 'should return the price multiplied by 0.09' do
      shirt = Product.create(name: "Test Shirt", price: 20.00, description: "This shirt is meant to be tested on.")
      expect(shirt.tax).to eq(1.8)
    end
  end

  describe '#total' do
    it 'should return the sum of the price and the tax' do
      shirt = Product.create(name: "Test Shirt", price: 20.00, description: "This shirt is meant to be tested on.")
      expect(shirt.total).to eq(21.8)
    end
  end

end
