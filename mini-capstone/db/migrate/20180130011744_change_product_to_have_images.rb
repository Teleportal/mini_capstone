class ChangeProductToHaveImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :image_url, :string
    add_column :images, :product_id, :integer 
  end
end
