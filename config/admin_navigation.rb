SimpleNavigation::Configuration.run do |navigation|
  navigation.active_leaf_class = 'active_n'
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false
	
    primary.item :articles, 'Articles', '#' do |sub_nav|
      sub_nav.item :articles_index, 'Articles list', articles_path
      #sub_nav.item :action_article_create, 'New article', new_article_path, if: Proc.new { can? :new, Article }
      sub_nav.item :articles_new, 'New article', new_article_path
      sub_nav.item :articles_versions, 'Versions', admin_versions_path('article')
    end

   # primary.item :admin, 'Admin', '#',  if: Proc.new { current_user and current_user.has_role?(:admin) } do |sub_nav|
    primary.item :access, 'Access', '#' do |sub_nav|
      sub_nav.dom_class = 'dropdown-menu'
      sub_nav.item :access_users, 'Users', users_all_path
    end
  end
end
