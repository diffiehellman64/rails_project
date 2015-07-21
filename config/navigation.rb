SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'selected'
  navigation.active_leaf_class = 'active'
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false

    primary.item :home, 'Home', root_path

	
    primary.item :article, 'Articles', '#' do |sub_nav|
      sub_nav.dom_class = 'dropdown-menu'
      sub_nav.item :articles_list, 'Articles list', articles_path
      sub_nav.item :action_article_create, 'New article', new_article_path, if: Proc.new { can? :new, Article }
    end

    primary.item :admin, 'Admin', '#',  if: Proc.new { current_user and current_user.has_role?(:admin) } do |sub_nav|
      sub_nav.dom_class = 'dropdown-menu'
      sub_nav.item :roles, 'Roles', admin_roles_path
      sub_nav.item :users, 'Users', admin_users_path
      sub_nav.item :articles, 'Articles', '/admin/versions/article'
    end

  end
end
