class CreateSpreeBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_blogs do |t|
      t.string :title
      t.text :body
      t.integer :status
      t.integer :category_id
      t.datetime :publish_date

      t.timestamps
    end
  end
end
