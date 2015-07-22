#= require jquery
#= require bootstrap-sprockets
#= require jquery_ujs
#= require ckeditor/init
#= require turbolinks
#= require_tree .
jQuery ->
  $('[data-toggle="popover"]').popover
    html: true
    placement: 'bottom'
    trigger: 'focus'
    content: ->
      $('#popover_content').html()
    title: ->
      $('#popover_title').html()
    

  $('#popover_content').attr('display', 'none')

showAppMessage = (message, state = 'info') ->
  html_ = $('#application-messager').html()
  html_ += "<div class='message-item alert alert-dismissible alert-#{state}' role='alert' data-dismiss='alert' >"
  html_ += "<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button>"
  html_ += message
  html_ += "</div>"
  $('#application-messager').html(html_)

ready = ->
  $('#action_article_edit').click ->
    url = '/articles/' + $('#action_article_edit').attr('data-article-id') + '/edit'
    $.ajax url,
      type: 'GET'
      response: 'text'
      error: (jqXHR) ->
        if (jqXHR.status == 403)
          showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
        else
          showAppMessage('Unknow error happened!', 'danger');
#        switch(jqXHR.status) {
#          case "403":
#            showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
#            break; 
#          default:
#            showAppMessage('Unknow error happened!', 'danger');
#        }
      success: (jqXHR) ->
        window.location.href = url
  $('#action_article_destroy').click ->
    article_tr = $(this).parents('tr')[0]
    url = '/articles/' + $(article_tr).attr('data-article-id')
    if confirm('Are you shure?')
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
  $('#action_article_create').click ->
    url = '/articles/new'
    $.ajax url,
      type: 'GET'
      response: 'text'
      error: (jqXHR) ->
        if (jqXHR.status == 403)
          showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
        else
          showAppMessage('Unknow error happened!', 'danger');
      success: (jqXHR) ->
        window.location.href = url

$(document).ready(ready)
$(document).on('page:load', ready)
