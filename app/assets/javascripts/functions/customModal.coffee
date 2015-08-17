# Function for call confirm modal window

@confirmModal = (message, callback) ->
  modalWindow = $('<div class="modal fade">' +
                    '<div class="modal-dialog" >' +
                      '<div class="modal-content" >' +
                        '<div class="modal-heder" >' +
                        '</div>' +
                        '<div class="modal-body" >' +
                          '<h3>Confirm your action</h3>' +
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

@showInModal = (content, buttonId='modalOk') ->
  modalWindow = $('<div class="modal fade">' +
                    '<div class="modal-dialog" >' +
                      '<div class="modal-content" >' +
                        '<div class="modal-body" >' +
                          content +
                        '</div>' +
                        '<div class="modal-footer" >' +
                          '<button id=' + buttonId + '  class="btn btn-default btn-primary">Ok</button>' +
                        '</div>' +
                      '</div>' +
                    '</div>' +
                  '</div>')
  modalWindow.modal('show')
  modalWindow.find('#' + buttonId).click ->
    modalWindow.modal('hide')

# Перехватчик стандарного окна подтверждения действия
$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link)
  false
$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')
$.rails.showConfirmDialog = (link) ->
  message = link.attr('data-confirm')
  html = '<div class="modal" id="confirmationDialog">' +
           '<div class="modal-dialog" >' +
             '<div class="modal-content" >' +
               '<div class="modal-header">' +
                 '<a class="close" data-dismiss="modal">&times;</a>' +
                 '<h3>Подтвердите ваше действие</h3>' +
               '</div>' +
               '<div class="modal-body">' +
                 '<p>' + message + '</p>' +
               '</div>' + 
               '<div class="modal-footer">' +
                 '<a data-dismiss="modal" class="btn btn-primary">Отмена</a>' +
                 '<a data-dismiss="modal" class="btn btn-danger confirm">Ok</a>' +
               '</div>' +
             '</div>' +
           '</div>' +
         '</div>'
  $(html).modal();
  $('#confirmationDialog .confirm').on('click', ( ->
    $.rails.confirmed(link)
  ))


