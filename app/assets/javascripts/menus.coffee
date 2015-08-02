#ajax queries to menu constructor

jQuery ->

  globalMenu = []

  $('body').on('click', '#action_apply_menu', ( ->
    globalMenu = []
    menuName = $('#menu-constructor').attr('data-menu-name')
    list = $($('#menu-constructor')[0]).children('ol')[0]
    getItemsList(list)
    i = 0
    while globalMenu[i]
      if globalMenu[i]['id'] > 0
        updateMenu(globalMenu[i])
      i++
   ))

  updateMenu = (item) ->
    $.ajax '/menus/' + item['id'],
      type: 'post'
      data:
        _method: 'patch'
        menu:
          id: item['id']
          title: item['title']
          url: item['url']
          weight: item['weight']
          parent_id: item['parent_id']
          active: true
      success: ->
        showAppMessage('<strong>Success!</strong> Updated!', 'success');
      error: (jqXHR) ->
        showAppMessage('<strong>Error:</strong> ' + jqXHR.status + '!', 'danger');

  getItemsList = (list, parent_id = 0) -> # рекуснивно строит массив элементов меню
    i = 0
    while $(list).children('li')[i] # пока список не иссякнет
      itemArr = []
      itemContainer = $(list).children('li')[i] # блок с элементом списка и возможным еще одним списком
      item = $(itemContainer).children('.dd-handle')[0] # выбираем элемент списка
      itemArr['id']  = $(itemContainer).attr('data-item-id')
      itemArr['title'] = $(item).children('.item-title').html()
      itemArr['url']   = $(item).children('.item-url').html()
      itemArr['weight']   = i
      itemArr['parent_id']  = parent_id
      globalMenu.push(itemArr)
      subList = $($(itemContainer)[0]).children('ol')[0]
      if subList
        getItemsList(subList, itemArr['id'])
      i++


  $('body').on('dblclick', '#menu-constructor td', ( ->
    cell = $(this)
    row = $(cell.parent()[0])
    oldContent = cell.html()
    $(this).html('<input class="edit_item" type="text" value='+oldContent+'>')
    $('.edit_item').focusout ->
      newContent = $(this).val()
      if newContent != oldContent
        row.addClass('warning')
        row.attr('edited', 'true')
      if !newContent
        cell.addClass('danger')
      cell.html(newContent)
  ))

  $('body').on('click', '.action_menu_item_del', ( ->
    row = $($(this).parent()[0]).parent()[0]
    itemId = $(row).attr('data-item-id')
    #console.log itemId
    url = '/menus/' + itemId
    $.ajax url,
      type: 'POST'
      data: 
        _method: 'DELETE'
      success: (data) ->
        showAppMessage('<strong>Success!</strong> Deleted!', 'success');
        $(row).fadeOut(200)
  ))

  $('body').on('click', '#action_add_item_menu', ( ->
    table = $('#menu-constructor').children('tbody')
    new_tr = '<tr class="warning" data-item-id="0">'
    header = $(table).children('tr')[0]
    $('th', header).each ->
      new_tr += '<td></td>'
    new_tr +='</tr>'
    i = 0
    $('tr', table).each ->
      i++
    tr_last = $(table).children('tr')[i-1]
    $(tr_last).after(new_tr)
  ))
