module UserLinkHelper

  def user_profile_link(id)
    user = User.find(id)
    name = user_name(id)
    if name != 'Udentified'
      avatar = content_tag(:div, class: 'img-avatar') do
        image_tag(user.avatar.url(:thumb))
      end
      link = link_to(name, profile_path(id)) 
      result = content_tag(:span, title: 'Go to user profile') do
        avatar + " " +  link
      end
      return result
    else
      return 'Udentified'
    end
  end
  
  def user_name(id)
    user = User.find(id)
    if user
      name = ''
      if user.first_name and user.first_name != ''
        name += user.first_name
        name += ' '
      end
      if user.last_name and user.last_name != ''
        name += user.last_name
        name += ' '
      end
      if name == '' or !name
        name = user.username
      end
      return name
    else
      return 'Udentified'
    end
  end
  
end
