class User < ActiveRecord::Base
  rolify
  apply_simple_captcha
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :authentication_keys => [:login]
  
  # apply_simple_captcha

  before_save { self.email = email.downcase }

  has_many :article
  has_many :gallery
  has_many :image, through: :gallery

#  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username, presence: true,
            uniqueness: { case_sensitive: false }


#  validate :captcha_valid

#  def captcha_valid
#    if !self.valid_with_captcha?
#    if !valid_with_captcha?
#      errors.add(:captcha, "Captcha not valid!")
#    end
#  end

#  def captcha
#  end
#            format: { with: VALID_EMAIL_REGEX }

  attr_accessor :login
  
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end 

#  def self.find_for_database_authentication(warden_conditions)
#    conditions = warden_conditions.dup
#    if login = conditions.delete(:login)
#      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
#    else
#      where(conditions.to_h).first
#    end
#  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  has_attached_file :avatar, 
                    styles: { large:  '400x400>',
                              medium: '200x200>', 
                              thumb:  '16x16>' },
                    url:    '/avatars/:style/avatar_:id',
                    path:   ':rails_root/public:url',
                    default_url: '/avatars/default/:style/default.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
