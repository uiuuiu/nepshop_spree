class AddImageToBlog < ActiveRecord::Migration[5.0]
  def up
    add_attachment :spree_blogs, :image
  end

  def down
    remove_attachment :spree_blogs, :image
  end
end
