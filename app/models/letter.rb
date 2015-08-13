class Letter < ActiveRecord::Base
  belongs_to :director
  has_one :chief

  has_attached_file :incomming_letter,
                    url:    '/letters/incomming/:id.pdf',
                    path:   ':rails_root/public:url'
                    
  validates_attachment :incomming_letter, content_type: { content_type: "application/pdf" }

end
