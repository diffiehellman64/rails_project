class Ability
  include CanCan::Ability

# Default actions: index show new edit create update destroy
  def initialize(user)
    alias_action :new, :edit, :create, :update, :destroy, to: :modify
    alias_action :new, :create, to: :touch
    alias_action :index, :show, to: :read
    user ||= User.new # Если не авторизован, то будет новый пользователь с пустыми полями

    #Admin
    if user.has_role? :admin
      # can :access, :rails_admin   # grant access to rails_admin
      # can :dashboard              # grant access to the dashboard
      can :modify, Article
      can :read, Article
      can :read, Menu
      can :modify, Menu
      can :read, Gallery
      can :modify, Gallery
      can :del_image, Gallery
      can :read, Letter
      can :modify, Letter
      # can :read, :all

    # Editor
    elsif user.has_role? :manager
      can :read, :all
      can :touch, Article
      can :manage, Article do |g|
        g.try(:user_id) == user.id
      end
      can :touch, Gallery
      can :manage, Gallery do |g|
        g.try(:user_id) == user.id
      end
      can :del_image, Gallery do |g|
        g.try(:user_id) == user.id
      end

    # Guest
    else
        can :read, Article
        can :read, Gallery
    end    

  end
end
