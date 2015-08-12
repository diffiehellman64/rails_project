SimpleNavigation::Configuration.run do |navigation|
  navigation.auto_highlight = false
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false

    primary.item :home, t('views.menus.items.home'), root_path

    primary.item :articles, t('views.menus.items.articles'), '#' do |sub_nav|
      sub_nav.item :articles_index,  t('views.menus.items.articles_list'), articles_path
      #sub_nav.item :action_article_create, 'New article', new_article_path, if: Proc.new { can? :new, Article }
      sub_nav.item :articles_new, t('views.menus.items.articles_new'), new_article_path
      sub_nav.item :articles_versions,  t('views.menus.items.articles_versions'), versions_path('article')
    end
  
    primary.item :gallery, t('views.menus.items.galleries'), '#' do |sub_nav|
      sub_nav.item :gallery_index, t('views.menus.items.galleries_list'), galleries_path
      sub_nav.item :gallery_new, t('views.menus.items.galleries_new'), new_gallery_path
    end
  
   # primary.item :admin, 'Admin', '#',  if: Proc.new { current_user and current_user.has_role?(:admin) } do |sub_nav|
    primary.item :access, t('views.menus.items.access'), '#' do |sub_nav|
      sub_nav.item :access_users, t('views.menus.items.users_manage'), users_all_path
    end

  end
end
