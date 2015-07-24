#= require jquery
#= require bootstrap-sprockets
#= require jquery_ujs
#= require ckeditor/init
#= require turbolinks
#= require jquery.pjax
#= require_tree .
#= require_tree ./functions

#jQuery ->
  #$(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '#data-pjax-container')
  #$(document).pjax('a', '#data-pjax-container')
  #$('a').pjax('#data-pjax-container')

  #$('.action_article_destroy').click ->
  #  console.log 'Ok!!!'
  

ready = ->
    #$(document).pjax('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]')
    #$(document).pjax('a', '#data-pjax-container')


  $('.action_article_destroy').click ->
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
    )

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

$(document).ready(ready)
$(document).on('page:load', ready)
