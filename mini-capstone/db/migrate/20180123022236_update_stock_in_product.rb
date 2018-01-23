class UpdateStockInProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :in_stock, :boolean, default: true
    remove_column :products, :stock, :integer
  end
end
