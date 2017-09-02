class Spree::Blog < ApplicationRecord
  has_attached_file :image,
    styles: { small: "64x64", med: "339x162", large: "572x273" }
  validates_attachment :image, content_type:
    {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}

  acts_as_list
  default_scope { order(position: :asc) }
end
