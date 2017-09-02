class CreateSpreeSubscribes < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_subscribes do |t|
      t.string :email

      t.timestamps
    end
  end
end
