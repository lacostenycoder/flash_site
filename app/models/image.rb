class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_attached_file :attachment, styles:  { thumb: "100x100!" }
  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\z/
end
