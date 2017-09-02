class CreateSpreeNavigations < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_navigations do |t|
      t.string :name
      t.string :link_navigation
      t.attachment :image
      t.string :link_image
      t.integer :position
      t.string :taxonomy_ids

      t.timestamps
    end
  end
end
