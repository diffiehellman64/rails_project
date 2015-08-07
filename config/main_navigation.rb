SimpleNavigation::Configuration.run do |navigation|
  navigation.auto_highlight = false
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false

    primary.item :home, t('views.menus.items.home'), root_path

    primary.item :articles, t('views.menus.items.articles'), '#' do |sub_nav|
      sub_nav.item :articles_index, 'Articles list', articles_path
      #sub_nav.item :action_article_create, 'New article', new_article_path, if: Proc.new { can? :new, Article }
      sub_nav.item :articles_new, 'New article', new_article_path
      sub_nav.item :articles_versions, 'Versions', versions_path('article')
    end
  
    primary.item :gallery, t('views.menus.items.gallery'), '#' do |sub_nav|
      sub_nav.item :gallery_index, 'Gallery list', galleries_path
      sub_nav.item :gallery_new, 'New gallery', new_gallery_path
    end
  
   # primary.item :admin, 'Admin', '#',  if: Proc.new { current_user and current_user.has_role?(:admin) } do |sub_nav|
    primary.item :access, 'Access', '#' do |sub_nav|
      sub_nav.item :access_users, 'Users', users_all_path, class: 'pjax_action'
    end

  end
end
