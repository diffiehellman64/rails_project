#= require jquery
#= require jquery_ujs
#= require ckeditor/init
#= require turbolinks
#= require jquery.validate.min
#= require bootstrap-sprockets
#= require jquery.pjax
#= require jquery.nestable
#= require jquery.remotipart
#= require hermitage
#= require_tree .
#= require_tree ./functions

ready = ->

  $(document).pjax('a:not(.thumbnail)', '[pjax-container]')
 #$(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]')
#  $('a').pjax('[pjax-container]')

#  $(document).pjax('#action_apply_menu', '#nav_menu')


  # Initialize the gallery
  # $('#thumbs a').touchTouch()


  $.pjax.defaults.timeout = 4000
  #$(document).on('pjax:error', ((data, status, xhr) ->
  #  showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
  #  console.log 'pjax!'
  #  console.log status
  #  console.log data
  #  console.log xhr
  #  console.log event
  #))
  $('.dd').nestable()

  $('[data-toggle="tooltip"]').tooltip()

  # ajax to action_article_destroy
  $('body').on('click', '.action_article_destroy', ( -> 
    article_tr = $(this).parents('tr')[0]
    url = '/articles/' + $(article_tr).attr('data-article-id')
    confirmModal('Do you really want destroy this article?', ->
      $.ajax url,
        type: 'POST'
        data: _method: 'DELETE'
        error: (jqXHR) ->
          showAppMessage('<strong>Error:</strong> ' + jqXHR.status, 'danger');
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
          showAppMessage('<strong>Error:</strong> ' + jqXHR.status, 'danger');
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
        showAppMessage('<strong>Error:</strong> ' + jqXHR.status, 'danger');
      success: (data) ->
        content = $(data).find('#main-data').html()
        showInModal(content)
  ))

  # ajax grand roles
  $('body').on('click', '.action_role_manage', ( ->
    chbox = $(this)[0]
    current_state = !chbox.checked
    $(this)[0].checked = current_state
    role = $(this).attr('data-role')
    user = $(this).attr('data-user')
    confirmModal('Do you really want change this user?', ->
      url = '/users/' + user + '/' + !current_state + '/' + role
      chbox.checked = !current_state    
      $.ajax url,
        type: 'POST'
        data: _method: 'PATCH'
        error: (jqXHR) ->
          showAppMessage('<strong>Error:</strong> ' + jqXHR.status, 'danger');
        success: ->
          showAppMessage('<strong>Success!</strong> User changed!', 'success');
    )
  ))

  # ajax change password
  $('.action_change_password').popover(
    placement: 'left'
    title: 'Change password'
    html: true
    content: '<input class="form-control new_password_field" placeholder="********" type="text">' + 
             '<div class="btn btn-primary do_action_change_password">Change password</div>'
  )
  $('body').on('click', '.do_action_change_password', ( ->
    userId = $($(this).parents('tr')[0]).attr('data-user-id')
    url = '/users/' + userId + '/update'
    popoverContainer = $(this).parents('.popover-content')[0]
    pass = $($(popoverContainer).children('.new_password_field')[0]).val()
    $.ajax url,
      type: 'POST'
      data:
        _method: 'PATCH'
        user:
          password: pass
      error: (jqXHR) ->
        showAppMessage('<strong>Error:</strong> ' + jqXHR.status, 'danger');
      success: ->
        showAppMessage('<strong>Success!</strong> Password updated!', 'success');
    $('.action_change_password').popover('hide')
  ))

  # #search_field animation
  $('#search_field').focus ->
    $(this).animate
      width: '+=100'
  $('#search_field').focusout ->
    $(this).animate
      width: '-=100'
  $('#search_field').keyup ->
    cont = $('#search_field').val()
    if cont
      showAppMessage(cont, 'info');
#    if cont == 'test'
#      cont = $('#search_field').val('123')

# enable ready code on all pages of application
$(document).ready(ready)
$(document).on('page:load', ready)
