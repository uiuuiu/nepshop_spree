class Spree::Slider < ApplicationRecord
  acts_as_list # Update position
  default_scope { order(position: :asc) }

  has_attached_file :background,
    styles: { small: "64x64", med: "100x100", large: "1292x526" }
  validates_attachment :background, content_type:
    {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}
  has_attached_file :logo,
    styles: { small: "64x64", med: "100x100", large: "246x128" }
  validates_attachment :logo, content_type:
    {content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]}
end
