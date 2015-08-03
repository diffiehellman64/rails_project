class Article < ActiveRecord::Base
  belongs_to :user
  has_paper_trail on: [:create, :update], ignore: [:anons]

  before_destroy do
    self.versions.destroy_all
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
