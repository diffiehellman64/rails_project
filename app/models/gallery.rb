class Gallery < ActiveRecord::Base
  has_many :image, :dependent => :destroy
end
