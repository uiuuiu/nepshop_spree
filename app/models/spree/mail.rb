class Spree::Mail < ApplicationRecord
  belongs_to :spree_magazine, class_name: Spree::Magazine.name
end
