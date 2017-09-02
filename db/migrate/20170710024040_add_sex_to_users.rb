class AddSexToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_users, :sex, :string, default: "Male"
  end
end
