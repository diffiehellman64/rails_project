# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('body').on('change', '#upload-photo', ( ->
    $(this).hide()
    $('#edit-gallery-form').submit()
    files = $(this).prop("files")
    loader = ''
    i = 0
    while files[i]
#      image = ''
#      fr = new FileReader()
#      fr.onload = -> #createImage
#        img = new Image()
#        img.onload = ->
#          canvas = document.createElement('canvas')
#          canvas.width = 100
#          canvas.height = 100
#          ctx = canvas.getContext("2d");
#          ctx.drawImage(img,0,0); 
#          canvas.toDataURL("image/png")
#        img.src = fr.result
#        image = fr.result
#      fr.readAsDataURL(files[i]) 
      
      loader += '<li class="thumbnail photo">'
      loader += '<img src="/photo_loading.gif" height="100" width="100" alt="Ok">'
      #loader += '<img src="' + image + '" height="100" width="100" alt="Ok">'
      loader += '<div class="caption">'
      loader += '<a class="btn btn-success btn-xs" data-remote="true" rel="nofollow" data-method="delete" href="#">loading</a>'
      loader += '</div>'
      loader += '</li>'
      i++
    $('#photo_list').append(loader)
  ))
