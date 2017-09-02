class CreateSpreeSpecialProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_special_products do |t|
      t.references :spree_product, foreign_key: true
      t.references :spree_special_product_type, foreign_key: true
      t.boolean :visible,default: false
      t.integer :position

      # t.timestamps
    end
  end
end
