#ajax queries to menu constructor

jQuery ->

  c = {}

  $('#menu-constructor tr').draggable
    helper: 'clone',
    start: (event, ui) ->
      c.tr = this;
      c.helper = ui.helper

  $("#menu-constructor tr").droppable
    drop: (event, ui) ->
      inventor = ui.draggable.text();
      $(this).find("input").val(inventor)
      $(c.tr).remove();
      $(c.helper).remove();


  $('body').on('dblclick', '#menu-constructor td', ( ->
    cell = $(this)
    oldContent = cell.html()
    $(this).html('<input class="edit_item" type="text" value='+oldContent+'>')
    $('.edit_item').focusout ->
      newContent = $(this).val()
      if newContent != oldContent
        cell.addClass('warning')
        cell.parent('tr').attr('edited', 'true')
      if !newContent
        cell.addClass('danger')
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
      currentTr = $(this)
      menuItemId = $(this).attr('data-item-id')
      edited = $(this).attr('edited')
      i = 0
      item = []
      requestUrl = '/menus'
      while(cell[i])
        item[fields[i]] = $(cell[i]).html()
        i++
      if item['title'] && item['url']
        if menuItemId == '0'
          $.ajax requestUrl,
            type: 'POST'
            data: 
              menu:
                name: menuName
                title: item['title']
                url:   item['url']
                active: item['active']
            success: (jqXHR) ->
              showAppMessage('<strong>Success!</strong> Created!', 'success');
              currentTr.removeClass().addClass('success')
        else if edited 
          $.ajax requestUrl + '/' + menuItemId,
            type: 'POST'
            data:
              _method: 'PATCH'
              menu:
                name: menuName
                title: item['title']
                url:   item['url']
                active: item['active']
            success: (jqXHR) ->
              showAppMessage('<strong>Success!</strong> Updated!', 'success');
              currentTr.removeClass().addClass('success')
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
