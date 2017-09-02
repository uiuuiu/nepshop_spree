class AddPositionToBlog < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_blogs, :position, :integer
  end
end
