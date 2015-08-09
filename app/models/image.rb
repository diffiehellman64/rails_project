require 'digest/md5'

class Image < ActiveRecord::Base
#  attr_accessible :file

  before_save :rename_file

  has_attached_file :file, 
    styles: { large:     '1024x1024>', 
              thumbnail: '100x100#' },
    url:    '/gallery/:style/photo_:id_:filename',
    path:   ':rails_root/public:url'

  def rename_file
    self.file.instance_write :file_name, rename_file_f(file_file_name)
  end

  belongs_to :gallery

  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  private

  def rename_file_f(name)
    ext_begin = name.rindex('.')
    ext = name[ext_begin, name.length]
    name = Digest::MD5.hexdigest(name)
    return name + ext
  end

end
