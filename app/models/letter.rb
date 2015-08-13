class Letter < ActiveRecord::Base
  belongs_to :director
  has_one :chief
#  before_save :rename_file
  has_attached_file :incomming_letter,
                    url:    '/letters/incomming/photo_:id_:filename',
                    path:   ':rails_root/public:url'

  validates_attachment_content_type :incomming_letter, content_type: { content_type: 'application/pdf' } 

#  def rename_file
#    self.file.instance_write :incomming_letter, rename_file_f(incomming_letter_file_name)
#  end

#  def rename_file
#    self.file.instance_write :file_name, rename_file_f(incomming_letter_file_name)
#  end

#  private

#  def rename_file_f(name)
#    ext_begin = name.rindex('.')
#    ext = name[ext_begin, name.length]
#    name = Digest::MD5.hexdigest(name)
#    return name + ext
#  end

end
