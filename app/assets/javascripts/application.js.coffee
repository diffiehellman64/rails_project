#= require jquery
#= require bootstrap-sprockets
#= require jquery_ujs
#= require jquery.pjax
#= require ckeditor/init
#= require turbolinks
#= require_tree .


jQuery ->

  $ ->
    $(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]')

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

confirmModal = (message, callback) ->
  modalWindow = $('<div class="modal fade bs-example-modal-xs">' + 
                    '<div class="modal-dialog" >' + 
                      '<div class="modal-content" >' + 
                        '<div class="modal-heder" >' + 
                          '<h3>Confirm your action</h3>' + 
                          '<button class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                        '</div>' + 
                        '<div class="modal-body" >' + 
                          message + 
                        '</div>' + 
                        '<div class="modal-footer" >' + 
                          '<button id="modalYes" class="btn btn-danger">Confirm</button>' +
                          '<button id="modalNo"  class="btn btn-default">Cancel</button>' +
                        '</div>' + 
                      '</div>' + 
                    '</div>' + 
                  '</div>')
  modalWindow.modal('show')
  modalWindow.find('#modalYes').click ->
    callback()
    modalWindow.modal('hide')
  modalWindow.find('#modalNo').click ->
    modalWindow.modal('hide')

ready = ->
#  $('#action_article_edit').click ->
#    url = '/articles/' + $('#action_article_edit').attr('data-article-id') + '/edit'
#    $.ajax url,
#      type: 'GET'
#      response: 'text'
#      error: (jqXHR) ->
#        if (jqXHR.status == 403)
#          showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
#        else
#          showAppMessage('Unknow error happened!', 'danger');
#        switch(jqXHR.status) {
#          case "403":
#            showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
#            break; 
#          default:
#            showAppMessage('Unknow error happened!', 'danger');
#        }
#      success: (jqXHR) ->
#        window.location.href = url

  $('.action_version_destroy').click ->
    version_tr = $(this).parents('tr')[0]
    url = '/admin/versions/'
    url += $(version_tr).attr('data-item-type') +  '/'
    url += $(version_tr).attr('data-item-id') + '/'
    url += $(version_tr).attr('data-version-id') + '/'
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
    )

  $('.action_article_destroy').click ->
    article_tr = $(this).parents('tr')[0]
    console.log article_tr
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
    )

#  $('#action_article_create').click ->
#    url = '/articles/new'
#    $.ajax url,
#      type: 'GET'
#      response: 'text'
#      error: (jqXHR) ->
#        if (jqXHR.status == 403)
#          showAppMessage('<strong>Access denied!</strong> You have no permissions for this action!', 'danger');
#        else
#          showAppMessage('Unknow error happened!', 'danger');
#      success: (jqXHR) ->
#        window.location.href = url

$(document).ready(ready)
$(document).on('page:load', ready)
