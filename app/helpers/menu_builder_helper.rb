module MenuBuilderHelper

  def build_menu(name)
    items = Menu.where(name: name).order(:weight)
    menu_html = ''
#    menu_html = '<nav class="navbar navbar-inverse" role="navigation">'
    menu_html += '<ul class="nav navbar-nav">'
    items.each do |item|
      menu_html += '<li><a href="' + item.url + '">' + item.title + '</a></li>'
    end
    menu_html += '</ul>'
#    menu_html += '</nav>'
  end
end
