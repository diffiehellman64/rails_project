#= require jquery
#= require bootstrap-sprockets
#= require jquery_ujs
#= require ckeditor/init
#= require turbolinks
#= require jquery.pjax
#= require jquery.validate.min
#= require_tree .
#= require_tree ./functions

#jQuery ->

ready = ->

  # console.log window.location.url
#  $(window).on('hashchange', ( ->
#    console.log window.location.url
#  ))
 
#  $('.draggable').draggable()

  # ajax grand roles
  $('body').on('click', '.action_role_manage', ( ->
    # /users/:id/:act/:role
    url = '/users/' + $(this).attr('data-user') + '/' + $(this).is(':checked') + '/' + $(this).attr('data-role')
    confirmModal('Do you really want change this user?', ->
      $.ajax url,
        type: 'POST'
        data: _method: 'PATCH'
        error: (jqXHR) ->
          if (jqXHR.status == 403)
            showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
          else
            showAppMessage('Unknow error happened!', 'danger');
        success: (jqXHR) ->
          showAppMessage('<strong>Success!</strong> User changed!', 'success');
    )
  ))

  # $('#filename_user_avatar').click ->
  #   console.log 'change!'

  # add pjax to application
  $(document).pjax('a', '[pjax-container]')

  # add tooltip to elements who has data-toggle="tooltip"
  $('[data-toggle="tooltip"]').tooltip()
  #  trigger: 'focus'
  #)

  # ajax to action_article_destroy
  $('body').on('click', '.action_article_destroy', ( -> 
    article_tr = $(this).parents('tr')[0]
    url = '/articles/' + $(article_tr).attr('data-article-id')
    confirmModal('Do you really want destroy this article?', ->
      $.ajax url,
        type: 'POST'
        data: _method: 'DELETE'
        error: (jqXHR) ->
          if (jqXHR.status == 403)
            showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
          else
            showAppMessage('Unknow error happened!', 'danger');
        success: (jqXHR) ->
          $(article_tr).fadeOut(200)
          showAppMessage('<strong>Success!</strong> Article deleted!', 'success');
  )))

  # ajax to action_version_destroy
  $('body').on('click', '.action_version_destroy', ( -> 
    version_tr = $(this).parents('tr')[0]
    url = '/versions/'
    url += $(version_tr).attr('data-item-type') +  '/'
    url += $(version_tr).attr('data-item-id') + '/'
    url += $(version_tr).attr('data-version-id')
    confirmModal('Do you really want destroy this version?', ->
      $.ajax url,
        type: 'POST'
        data: _method: 'DELETE'
        error: (jqXHR) ->
          if (jqXHR.status == 403)
            showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
          else
            showAppMessage('Unknow error happened!', 'danger');
        success: (jqXHR) ->
          $(version_tr).fadeOut(200)
          showAppMessage('<strong>Success!</strong> Version deleted!', 'success');
  )))

  #ajax to action_version_preview
  $('body').on('click', '.action_version_preview', ( -> 
    version_tr = $(this).parents('tr')[0]
    url = '/versions/'
    url += $(version_tr).attr('data-item-type') +  '/'
    url += $(version_tr).attr('data-item-id') + '/'
    url += $(version_tr).attr('data-version-id') 
    $.ajax url,
      type: 'GET'
      error: (jqXHR) ->
        if (jqXHR.status == 403)
          showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
        else
          showAppMessage('Unknow error happened!', 'danger');
      success: (data) ->
        content = $(data).find('#main-data').html()
        showInModal(content)
  ))

  # #search_field animation
  $('#search_field').focus ->
    $(this).animate
      width: '+=300'
  $('#search_field').focusout ->
    $(this).animate
      width: '-=300'
  $('#search_field').keyup ->
    cont = $('#search_field').val()
    if cont
      showAppMessage(cont, 'info');
#    if cont == 'test'
#      cont = $('#search_field').val('123')

# enable ready code on all pages of application
$(document).ready(ready)
$(document).on('page:load', ready)
