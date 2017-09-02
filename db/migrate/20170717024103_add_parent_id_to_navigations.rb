class AddParentIdToNavigations < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_navigations, :parent_navigation_id, :integer
  end
end
