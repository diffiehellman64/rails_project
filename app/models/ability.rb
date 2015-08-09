class Ability
  include CanCan::Ability

# Default actions: index show new edit create update destroy
  def initialize(user)
    alias_action :new, :edit, :create, :update, :destroy, to: :modify
    alias_action :index, :show, to: :read
    user ||= User.new # guest user (not logged in)
    #Admin
    if user.has_role? :admin
#      can :access, :rails_admin   # grant access to rails_admin
#      can :dashboard              # grant access to the dashboard
      can :modify, Article
      can :modify, Menu
      can :read, Article
      can :read, Menu
      can :read, Gallery
      can :modify, Gallery
      can :add_image, Gallery
      can :del_image, Gallery
#      can :read, :all
    # Editor
    elsif user.has_role? :manager
      can :read, :all
      can :manage, Article
    #Member
#    elsif user.has_role? :member
#        can :read, :all
#        can :create, Post
#        can :status, Post
#        can :update, Post do |post|
#            post.try(:user) == user
#        end
    #Guest
    else
        can :read, Article
    end    
  end
end
