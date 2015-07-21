class Article < ActiveRecord::Base
  belongs_to :user
  has_paper_trail on: [:create, :update]

  before_destroy do
    self.versions.destroy_all
  end

end
