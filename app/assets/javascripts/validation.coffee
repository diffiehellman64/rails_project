# Hot validations for forms
jQuery ->
#  exec = ''
  $('body').on('click', '#new_user', ( ->
#  $('body').click ->

    validate_user_url = '/users/validate'

    $('#new_user').validate(

# => Bootstrap integration <= #
      errorClass: 'help-block'
      errorElement: 'span'
#      debug: true
      highlight: (element) ->
        $(element).closest('.form-group').addClass('has-error')
        $(element).closest('.form-group').removeClass('has-success');
#      element_id = $(element).attr('id')
#      token = $(element).attr('id') + '_status'
#      $(element).attr('aria-describedby', token)
#      $(element).after( "<span class='glyphicon glyphicon-remove form-control-feedback' aria-hidden='true'></span>" );
#      $(element).after( "<span id='" + token + "' class='sr-only'>(error)</span>" );
      unhighlight: (element) ->
        $(element).closest('.form-group').removeClass('has-error');
        $(element).closest('.form-group').addClass('has-success');
# -- Bootstrap integration -- #

      rules:
        'user[email]':
          required: true
          remote:
            url: validate_user_url
            type: 'post'
        'user[username]':
          required: true
          remote:
            url: validate_user_url
            type: 'post'
        'user[avatar]':
          remote:
            url: validate_user_url
            type: 'post'
        'user[password]':
          required: true
          remote:
            url: validate_user_url
            type: 'post'
        'user[password_confirmation]':
          equalTo: '#user_password'
        'user[captcha]':
          required: true
          #remote:
           # url: validate_user_url
            #type: 'post'
          
    )
  ))
