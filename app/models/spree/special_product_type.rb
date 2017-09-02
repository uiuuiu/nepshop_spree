class Spree::SpecialProductType < ApplicationRecord
  default_scope { order(position: :asc) }
  has_many :special_products, foreign_key: :spree_special_product_type_id, dependent: :destroy
  has_many :products, through: :special_products
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :title, presence: true
  acts_as_list # Update position
end
