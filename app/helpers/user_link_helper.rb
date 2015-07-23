module UserLinkHelper
  def user_profile_link(id)
    user = User.find(id)
    if user
      name = ''
      if user.first_name
        name += user.first_name
        name += ' '
      end
      if user.last_name
        name += user.last_name
        name += ' '
      end
      if name == ''
        name = user.email
      end
    return link_to(name.squish, profile_path(id))
    else
      return 'Udentified'
    end
  end
  
  def user_name(id)
    user = User.find(id)
    if user
      name = ''
      if user.first_name
        name += user.first_name
        name += ' '
      end
      if user.last_name
        name += user.last_name
        name += ' '
      end
      if name == ''
        name = user.email
      end
    return name.squish
    else
      return 'Udentified'
    end
  end
  
end
