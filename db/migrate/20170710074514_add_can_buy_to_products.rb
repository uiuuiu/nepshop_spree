class AddCanBuyToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_products, :can_buy, :string, default: "All"
  end
end
