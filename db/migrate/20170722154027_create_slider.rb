class CreateSlider < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_sliders do |t|
      t.string :title
      t.string :link
      t.attachment :background
      t.attachment :logo
      t.integer :position

      t.timestamps
    end
  end
end
