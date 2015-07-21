class Ability
  include CanCan::Ability

# Default actions: index show new edit create update destroy
  def initialize(user)
    alias_action :new, :edit, :create, :update, :destroy, to: :modify
    alias_action :index, :show, to: :read
    user ||= User.new # guest user (not logged in)
    #Admin
    if user.has_role? :admin
      can :modify, Article
      can :read, Article
    # Editor
    elsif user.has_role? :editor
      can :read, :all
      can :manage, :newsroom
      can :manage, Post
    #Member
    elsif user.has_role? :member
        can :read, :all
        can :create, Post
        can :status, Post
        can :update, Post do |post|
            post.try(:user) == user
        end
    #Guest
    else
        can :read, Article
    end    
  end
end
