# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  
  # Протез для того, чтобы галерея работала при загрузке страницы через ajax
  # Инициализируем скрипт галереи
  $(document).on('pjax:complete', hermitage.init)

  $('body').on('change', '#upload-photo', ( ->
    $($(this).parents('li')[0]).hide()
    $('#edit-gallery-form').submit()
    files = $(this).prop("files")
    loader = ''
    i = 0
    while files[i]
      loader += '<li class="thumbnail photo photo-loading">'
      loader += '<img src="/photo_loading.gif" height="100" width="100" alt="Ok">'
      #loader += '<img src="' + image + '" height="100" width="100" alt="Ok">'
      loader += '<div class="caption">'
      loader += '<a class="btn btn-success btn-xs" data-remote="true" rel="nofollow" data-method="delete" href="#">loading</a>'
      loader += '</div>'
      loader += '</li>'
      i++
    $('#photo_list').append(loader)
  ))
