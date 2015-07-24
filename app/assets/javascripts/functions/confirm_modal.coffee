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
