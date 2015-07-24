SimpleNavigation::Configuration.run do |navigation|
#  navigation.selected_class = 'selected'
#  navigation.active_leaf_class = 'active'
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false

    primary.item :home, 'Home', root_path

  end
end
