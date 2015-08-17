# Hot validations for forms

ready = ->
  validate_url = '/articles/validate'
  $('#new_article').validate(
    # => Bootstrap integration <= #
    errorClass: 'help-block'
    errorElement: 'span'
    # debug: true
    highlight: (element) ->
      $(element).closest('.form-group').addClass('has-error')
      $(element).closest('.form-group').removeClass('has-success');
    unhighlight: (element) ->
      $(element).closest('.form-group').removeClass('has-error');
      $(element).closest('.form-group').addClass('has-success');
    # -- Bootstrap integration -- #
    rules:
      'article[title]':
        required: true
        remote:
          url: validate_url
          type: 'post'
  )

$(document).on('pjax:complete', ready)
$(document).ready(ready)
