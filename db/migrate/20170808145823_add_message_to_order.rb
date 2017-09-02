class AddMessageToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_orders, :message, :text
  end
end
