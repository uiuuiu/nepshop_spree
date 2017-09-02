class Spree::Navigation < ApplicationRecord
  has_many :spree_taxonomies
  has_many :sub_navigations, class_name: Spree::Navigation.name,
    foreign_key: "parent_navigation_id", dependent: :destroy

  acts_as_list # Update position
  default_scope { order(position: :asc) }

  has_attached_file :image,
    styles: { small: "64x64", med: "100x100", large: "810x172" }
  validates_attachment :image, content_type:
    {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}
end
