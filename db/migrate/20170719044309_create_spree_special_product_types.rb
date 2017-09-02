class CreateSpreeSpecialProductTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_special_product_types do |t|
      t.string :name
      t.string :title
      t.text :description
      t.integer :position
      t.string :applies_to,default: "Spree::Product"
      # t.timestamps
    end
  end
end
