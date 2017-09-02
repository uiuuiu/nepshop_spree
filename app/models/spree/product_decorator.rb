Spree::Product.class_eval do
  has_many :special_products, foreign_key: :spree_product_id
  has_many :special_product_types, through: :special_products
  # after_destroy :destroy_product_special_products
end
