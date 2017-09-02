class CreateSpreeMails < ActiveRecord::Migration[5.0]
  def change
    create_table :spree_mails do |t|
      t.text :more_email
      t.boolean :all_user, default: false
      t.string :bcc
      t.datetime :date_time
      t.references :spree_magazine, foreign_key: true

      t.timestamps
    end
  end
end
