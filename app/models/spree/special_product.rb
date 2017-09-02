module Spree
  class SpecialProduct < ApplicationRecord
    default_scope { order(position: :asc) }
    belongs_to :product, foreign_key: :spree_product_id
    belongs_to :special_product_type, foreign_key: :spree_special_product_type_id
    validates_uniqueness_of :spree_product_id, scope: :spree_special_product_type_id
    scope :visible, -> { where(visible: true) }
    scope :special, -> (name){
                              joins("LEFT JOIN spree_special_product_types
                                   ON spree_special_products.spree_special_product_type_id = spree_special_product_types.id")
                            .where("spree_special_product_types.name = ?", name)
                            }
    acts_as_list # Update position
  end
end
