
#ready ->
jQuery ->
  $('body').on('dblclick', '#menu-constructor td', ( ->
    cell = $(this)
    oldContent = cell.html()
    $(this).html('<input class="edit_item" type="text" value='+oldContent+'>')
    $('.edit_item').focusout ->
      newContent = $(this).val()
      if newContent != oldContent
        cell.addClass('warning')
      cell.html(newContent)
  ))

  $('body').on('click', '#action_apply_menu', ( ->
    table = $('#menu-constructor').children('tbody')
    fields = []
    menuName = $('#menu-constructor').attr('data-menu-name')
    header = $(table).children('tr')[0]
    i = 0
    $('th', header).each ->
      fields[i] = $(this).html().toLowerCase()
      i++
    $('tr', table).each ->
      cell = $(this).children('td')
      menuItemId = $(this).attr('data-item-id')
      i = 0
      item = []
      requestUrl = '/menus?name=' + menuName + '&'
      while(cell[i])
        item[fields[i]] = $(cell[i]).html()
        i++
      if item['title'] && item['url']
        requestUrl += 'title=' + item['title'] + '&'
        requestUrl += 'url=' + item['url'].replace('/','__') + '&'
        requestUrl += 'weight=0' + '&'
        requestUrl += 'parent=0' + '&'
        requestUrl += 'active=' + item['active']
        if menuItemId == '0'
          $.ajax requestUrl,
            type: 'POST'
            success: (jqXHR) ->
              showAppMessage('<strong>Success!</strong> Menu changed!', 'success');
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

#$(document).ready(ready)
#$(document).on('page:load', ready)
