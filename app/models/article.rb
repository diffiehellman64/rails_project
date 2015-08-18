class Article < ActiveRecord::Base
  belongs_to :user
  has_one :carousel_item, as: :carouselable
  has_paper_trail on: [:create, :update], ignore: [:anons]

  before_destroy do
    self.versions.destroy_all
  end

  validates :title, presence: true,
                    uniqueness: { case_sensitive: false }


  before_save do
    if self.text == ''
      self.text = '<p>Пока что ничего не написано здесь...</p>'
    end
  end

  def prew
    if self.anons and self.anons != ''
      return self.anons
    else
      return self.text
    end
  end

  def author
    return User.find(self.user_id)
  end

end
