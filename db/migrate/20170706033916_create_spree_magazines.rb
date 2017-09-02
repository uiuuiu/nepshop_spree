class CreateSpreeMagazines < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_magazines do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
