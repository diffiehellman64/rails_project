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
      avatar = content_tag(:div, class: 'img-avatar') do
        image_tag(user.avatar.url(:thumb))
      end
      link = link_to(name.squish, profile_path(id)) 
      result = content_tag(:span) do
        avatar + " " +  link
      end
      return result # + link_to(name.squish, profile_path(id))
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
