class Image < ActiveRecord::Base
#  attr_accessible :file
  has_attached_file :file, styles: { thumbnail: '100x100#' }
  belongs_to :gallery
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
