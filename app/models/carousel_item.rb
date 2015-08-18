class CarouselItem < ActiveRecord::Base
  belongs_to :carouselable, polymorphic: true
end
